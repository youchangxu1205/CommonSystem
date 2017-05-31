package top.youchangxu.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import top.youchangxu.core.shiro.EnterpriseToken;
import top.youchangxu.model.system.StaffingEmp;
import top.youchangxu.model.system.StaffingEnterprise;
import top.youchangxu.service.system.IStaffingEmpService;
import top.youchangxu.service.system.IStaffingEnterpriseEmpService;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by dtkj_android on 2017/5/26.
 */
@Controller
@RequestMapping("/sso")
public class SSOController extends BaseController {

    private IStaffingEmpService staffingEmpService;
    private IStaffingEnterpriseEmpService staffingEnterpriseEmpService;

    @Autowired
    public SSOController(IStaffingEmpService staffingEmpService, IStaffingEnterpriseEmpService staffingEnterpriseEmpService) {
        this.staffingEmpService = staffingEmpService;
        this.staffingEnterpriseEmpService = staffingEnterpriseEmpService;
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
    public Object login(String username, String password) {

        //查看用户是否存在
        StaffingEmp staffingEmp = staffingEmpService.selectOne(new EntityWrapper<StaffingEmp>().eq("username", username));
        if (staffingEmp == null) {
            return renderError("账号不存在");
        }
        //需要获取用户加入的企业
        List<StaffingEnterprise> enterprises = staffingEnterpriseEmpService.findEnterpriseByEmpId(staffingEmp.getEmpId());
        if(enterprises.size()>1){
            //跳转到企业选择界面
        }else if(enterprises.size()==1){
            //直接进行登录操作

            Subject subject = SecurityUtils.getSubject();

            EnterpriseToken enterpriseToken = new EnterpriseToken(username,password,enterprises.get(0).getEnterpriseId());
//            UsernamePasswordToken usernamePasswordToken = new UsernamePasswordToken(username, password);
            try {
                subject.login(enterpriseToken);
            } catch (UnknownAccountException e) {
                return renderError("账号不存在");
            } catch (IncorrectCredentialsException e) {
                return renderError("密码错误");
            } catch (ExcessiveAttemptsException e) {
                return renderError("重试次数过多,请10分钟再试");
            } catch (Exception e) {
                return renderError("服务器错误");
            }
            return renderSuccess("/index");

        }else{
            //员工未加入企业
        }

        return renderSuccess("/index");
    }
}
