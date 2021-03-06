package top.youchangxu.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import org.apache.commons.lang.BooleanUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import top.youchangxu.common.result.ResultEnum;
import top.youchangxu.core.shiro.EnterpriseToken;
import top.youchangxu.model.system.StaffingEmp;
import top.youchangxu.model.system.StaffingEnterprise;
import top.youchangxu.model.vo.EnterpriseEmpVO;
import top.youchangxu.service.PasswordHelper;
import top.youchangxu.service.system.IStaffingEmpService;
import top.youchangxu.service.system.IStaffingEnterpriseEmpService;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by dtkj_android on 2017/5/26.
 */
@Controller
@RequestMapping("/sso")
public class SSOController extends BaseController {

    private IStaffingEmpService staffingEmpService;
    private IStaffingEnterpriseEmpService staffingEnterpriseEmpService;
    private PasswordHelper passwordHelper;

    @Autowired
    public SSOController(IStaffingEmpService staffingEmpService,
                         IStaffingEnterpriseEmpService staffingEnterpriseEmpService,
                         PasswordHelper passwordHelper) {
        this.staffingEmpService = staffingEmpService;
        this.staffingEnterpriseEmpService = staffingEnterpriseEmpService;
        this.passwordHelper = passwordHelper;
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        SecurityUtils.getSubject().logout();
        String redirectUrl = request.getHeader("Referer");
        if (null == redirectUrl) {
            redirectUrl = "/sso/login";
        }
        return "redirect:" + redirectUrl;
    }

    @RequestMapping("/login")
    public String login(HttpServletRequest request) {
        return "/sso/login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public Object login(String username, String password, String rememberMe) {
        //TODO 优化登录流程
        //查看用户是否存在
        //只支持手机号登陆,根据手机号查询手机号
        StaffingEmp staffingEmp = staffingEmpService.selectOne(new EntityWrapper<StaffingEmp>().eq("empPhone", username));
        if (staffingEmp == null || !passwordHelper.compilePassword(password, staffingEmp)) {
            return renderError(ResultEnum.ACCOUNT_OR_PASSWORD_IS_WRONG);
        }

        //需要获取用户加入的企业
        List<StaffingEnterprise> enterprises = staffingEnterpriseEmpService.findEnterpriseByEmpId(staffingEmp.getEmpId());
        Map<String, Object> map = new HashMap<>();
        map.put("enterprises", enterprises);
        map.put("staffingEmp", staffingEmp);
        map.put("rememberMe", rememberMe);
        if (enterprises.size() > 1) {
            //跳转到企业选择界面

            return renderSuccess(map);
        } else if (enterprises.size() == 1) {
            //直接进行登录操作
            Subject subject = SecurityUtils.getSubject();
            EnterpriseToken enterpriseToken = new EnterpriseToken(staffingEmp.getEmpId()+"", password, enterprises.get(0).getEnterpriseId(), null);
            Object x = commonLogin(rememberMe, subject, enterpriseToken);
            if (x != null) return x;
            return renderSuccess("/index");

        } else {
            //员工未加入企业
            return renderError("没有加入企业");
        }

    }

    /**
     * 企业登录
     *
     * @param enterpriseEmpVO
     * @return
     */
    @RequestMapping(value = "/enterpriseLogin", method = RequestMethod.POST)
    @ResponseBody
    public Object enterpriseLogin(EnterpriseEmpVO enterpriseEmpVO, String rememberMe) {
        Subject subject = SecurityUtils.getSubject();
        EnterpriseToken enterpriseToken = new EnterpriseToken(enterpriseEmpVO.getUsername(), "", enterpriseEmpVO.getEnterpriseId(), enterpriseEmpVO);
        Object x = commonLogin(rememberMe, subject, enterpriseToken);
        if (x != null) return x;
        return renderSuccess("/index");
    }

    private Object commonLogin(String rememberMe, Subject subject, EnterpriseToken enterpriseToken) {
        try {
            if (BooleanUtils.toBoolean(rememberMe)) {
                enterpriseToken.setRememberMe(true);
            } else {
                enterpriseToken.setRememberMe(false);
            }
            subject.login(enterpriseToken);
        } catch (UnknownAccountException e) {
            return renderError(ResultEnum.ACCOUNT_OR_PASSWORD_IS_WRONG);
        } catch (IncorrectCredentialsException e) {
            return renderError(ResultEnum.ACCOUNT_OR_PASSWORD_IS_WRONG);
        } catch (ExcessiveAttemptsException e) {
            return renderError(ResultEnum.REPEAT_LOGIN_TO_MUCH);
        } catch (Exception e) {
            return renderError(ResultEnum.SERVER_HAS_BUSY);
        }
        return null;
    }


}
