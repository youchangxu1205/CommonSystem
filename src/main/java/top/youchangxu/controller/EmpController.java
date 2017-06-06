package top.youchangxu.controller;

import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import top.youchangxu.common.exception.StaffingException;
import top.youchangxu.common.result.ResultEnum;
import top.youchangxu.model.system.StaffingEmp;
import top.youchangxu.model.system.StaffingOrg;
import top.youchangxu.model.system.StaffingOrgEmp;
import top.youchangxu.model.system.StaffingRole;
import top.youchangxu.service.PasswordHelper;
import top.youchangxu.service.system.*;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by dtkj_android on 2017/5/25.
 */
@Controller
@RequestMapping("/emp")
public class EmpController extends BaseController {


    private IStaffingEmpService staffingEmpService;
    private PasswordHelper passwordHelper;
    private IStaffingRoleService staffingRoleService;
    private IStaffingEnterpriseEmpService staffingEnterpriseEmpService;
    private IStaffingRoleEmpService staffingRoleEmpService;
    private IStaffingOrgEmpService staffingOrgEmpService;
    private IStaffingOrgService staffingOrgService;

    @Autowired
    public EmpController(IStaffingEmpService staffingEmpService,
                         PasswordHelper passwordHelper,
                         IStaffingRoleService staffingRoleService,
                         IStaffingEnterpriseEmpService staffingEnterpriseEmpService,
                         IStaffingRoleEmpService staffingRoleEmpService,
                         IStaffingOrgEmpService staffingOrgEmpService,
                         IStaffingOrgService staffingOrgService) {
        this.staffingEmpService = staffingEmpService;
        this.passwordHelper = passwordHelper;
        this.staffingRoleService = staffingRoleService;
        this.staffingEnterpriseEmpService = staffingEnterpriseEmpService;
        this.staffingRoleEmpService = staffingRoleEmpService;
        this.staffingOrgEmpService = staffingOrgEmpService;
        this.staffingOrgService = staffingOrgService;
    }

    /**
     * 员工首页
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/index")
    public String index(Model model) {
        JSONArray orgBootstrapTree = staffingOrgService.getOrgBootstrapTree(Long.parseLong(getEnterpriseId()));
        model.addAttribute("treeData", orgBootstrapTree);
        return "/emp/index";
    }

    /**
     * 获取员工列表
     *
     * @param limit
     * @param offset
     * @param sort
     * @param order
     * @param staffingEmp
     * @param orgId
     * @return
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(int limit, int offset, String sort, String order, StaffingEmp staffingEmp, Long orgId) {
        Map<String, Object> result = new HashMap<>();
        Wrapper<StaffingOrg> staffingOrgWrapper = new EntityWrapper<StaffingOrg>()
                .setSqlSelect("orgId")
                .eq("enterpriseId", getEnterpriseId());
        if (orgId != 0) {
            staffingOrgWrapper.like("orgPath", "/" + orgId + "/");
        }
        //获取部门以及下属部门的Id
        List<Object> orgStrs = staffingOrgService.selectObjs(
                staffingOrgWrapper);


        //查询部门下的所有员工
        List<Object> orgEmps = staffingOrgEmpService.selectObjs(
                new EntityWrapper<StaffingOrgEmp>()
                        .in("orgId", orgStrs)
                        .setSqlSelect("empId").groupBy("empId"));
        List<StaffingEmp> rows = new ArrayList<>();
        if (orgEmps.size() == 0) {
            result.put("rows", rows);
            result.put("total", 0);
            return result;
        }

        EntityWrapper<StaffingEmp> empEntityWrapper = new EntityWrapper<>();

        if (staffingEmp.getEmpStatus() != 0) {
            empEntityWrapper.eq("empStatus", staffingEmp.getEmpStatus());
        }
        empEntityWrapper.in("empId", orgEmps);
        Page<StaffingEmp> staffingEmpPage = new Page<>(offset / limit + 1, limit, sort);
        staffingEmpPage.setAsc(order.equals("asc"));
        staffingEmpPage = staffingEmpService.selectPage(
                staffingEmpPage,
                empEntityWrapper);
        rows = staffingEmpPage.getRecords();
        result.put("rows", rows);
        result.put("total", staffingEmpPage.getTotal());
        return result;
    }

    /**
     * 创建员工
     *
     * @return
     */
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(Long orgId, Model model) {
        model.addAttribute("orgId", orgId);
        return "/emp/create";
    }

    /**
     * 创建用户
     *
     * @param staffingEmp
     * @param orgId
     * @return
     */
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public Object create(StaffingEmp staffingEmp, Long orgId) {


        try {
            boolean save = staffingEmpService.saveEmp(staffingEmp, orgId, getEnterpriseId());
            return save ? renderSuccess("添加成功") : renderError(ResultEnum.INSERT_ERROR);
        } catch (StaffingException staffingException) {
            return renderError("添加失败");
        } catch (Exception e){
            return renderError(e.getMessage());
        }

//        //判断账户名在企业内是否存在
//        List<StaffingEnterpriseEmp> enterpriseEmps = staffingEnterpriseEmpService.selectList(
//                new EntityWrapper<StaffingEnterpriseEmp>()
//                        .eq("enterpriseId", getEnterpriseId())
//                        .eq("enterpriseEmpName", staffingEmp.getUsername()));
//
//        if (enterpriseEmps.size() > 0) {
//            return renderError(ResultEnum.USERNAME_HAS_EXITS);
//        }
//        //设置企业的初始密码
//        staffingEmp.setPassword("123456");
//        //加密数据
//        passwordHelper.encryptPassword(staffingEmp);
//        //判断手机号是否在员工表中存在
//        List<StaffingEmp> staffingEmps = staffingEmpService.selectList(
//                new EntityWrapper<StaffingEmp>()
//                        .eq("empPhone", staffingEmp.getEmpPhone()));
//        boolean insert = false;
//        if (staffingEmps.size() == 0) {
//            insert = staffingEmpService.insert(staffingEmp);
//        } else {
//            staffingEmp = staffingEmps.get(0);
//            insert = true;
//        }
//
//        if (insert) {
//            boolean insertEmpToEnterprise = staffingEnterpriseEmpService.insert(
//                    new StaffingEnterpriseEmp(Long.parseLong(getEnterpriseId()),
//                            staffingEmp.getEmpId(),
//                            0,
//                            staffingEmp.getPassword(),
//                            staffingEmp.getSalt(),
//                            staffingEmp.getUsername()));
//            if (insertEmpToEnterprise) {
//                boolean insertOrgEmp = staffingOrgEmpService.insert(new StaffingOrgEmp(orgId, staffingEmp.getEmpId()));
//                if (insertOrgEmp) {
//                    return insertOrgEmp ? renderSuccess("添加成功") : renderError(ResultEnum.INSERT_ERROR);
//                }
//            }
//            return renderError(ResultEnum.INSERT_ERROR);
//        }
//        return renderError(ResultEnum.INSERT_ERROR);
    }

    /**
     * 更新用户
     *
     * @param empId
     * @param model
     * @return
     */
    @RequestMapping(value = "/update/{empId}", method = RequestMethod.GET)
    public String update(@PathVariable("empId") Long empId, Model model) {
        StaffingEmp staffingEmp = staffingEmpService.selectById(empId);
        model.addAttribute("staffingEmp", staffingEmp);
        return "emp/update";
    }

    /**
     * 更新用户
     *
     * @param staffingEmp
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Object update(StaffingEmp staffingEmp) {
        return staffingEmpService.updateById(staffingEmp) ? renderSuccess("修改成功") : renderError(ResultEnum.UPDATE_ERROR);
    }

    /**
     * 批量删除用户
     *
     * @param ids
     * @return
     */
    @RequestMapping(value = "/delete/{ids}", method = RequestMethod.POST)
    @ResponseBody
    public Object delete(@PathVariable("ids") String ids) {
        return staffingEmpService.deleteBatchIds(Arrays.asList(ids.split("-"))) ? renderSuccess("删除成功") : renderError(ResultEnum.DELETE_ERROR);
    }

    /**
     * 修改密码
     *
     * @param empId
     * @param model
     * @return
     */
    @RequestMapping(value = "/changePwd/{empId}")
    public String changePwd(@PathVariable("empId") Long empId, Model model) {
        model.addAttribute("empId", empId);
        return "emp/changePwd";
    }

    /**
     * 修改密码
     *
     * @param password
     * @param confirmPwd
     * @param empId
     * @return
     */
    @RequestMapping(value = "/changePwd")
    @ResponseBody
    public Object changePwd(String password, String confirmPwd, Long empId) {
        StaffingEmp staffingEmp = staffingEmpService.selectById(empId);
        staffingEmp.setEmpId(empId);
        staffingEmp.setPassword(password);
        passwordHelper.encryptPassword(staffingEmp);
        return staffingEmpService.updateById(staffingEmp) ? renderSuccess("修改成功") : renderError(ResultEnum.UPDATE_ERROR);
    }

    /**
     * 员工角色
     *
     * @param empId
     * @param model
     * @return
     */
    @RequestMapping(value = "/role/{empId}")
    public String role(@PathVariable("empId") Long empId, Model model) {
        StaffingEmp staffingEmp = staffingEmpService.selectById(empId);
        String enterpriseId = getEnterpriseId();
        List<StaffingRole> staffingRoles = staffingRoleService.selectList(
                new EntityWrapper<StaffingRole>()
                        .eq("enterpriseId", Long.parseLong(enterpriseId)));
        model.addAttribute("staffingRoles", staffingRoles);

        List<StaffingRole> staffingEmpRoles = staffingEmpService.findRoles(getEnterpriseId(), staffingEmp.getEmpId() + "");

        model.addAttribute("staffingEmpRoles", staffingEmpRoles);
        return "emp/role";
    }

    /**
     * 保存更新员工角色
     *
     * @param empId
     * @param request
     * @return
     */
    @RequestMapping(value = "/role/{empId}", method = RequestMethod.POST)
    @ResponseBody
    public Object role(@PathVariable("empId") Long empId, HttpServletRequest request) {

        String[] roleIds = request.getParameterValues("roleId");
        staffingRoleEmpService.updateRole(roleIds, empId);
        return renderSuccess(ResultEnum.UPDATE_SUCCESS);
    }


}
