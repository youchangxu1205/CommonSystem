package top.youchangxu.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import top.youchangxu.model.system.StaffingEmp;
import top.youchangxu.model.system.StaffingRole;
import top.youchangxu.service.PasswordHelper;
import top.youchangxu.service.system.IStaffingEmpService;
import top.youchangxu.service.system.IStaffingRoleService;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by dtkj_android on 2017/5/25.
 */
@Controller
@RequestMapping("/emp")
public class EmpController extends BaseController {


    private IStaffingEmpService staffingEmpService;
    private PasswordHelper passwordHelper;
    private IStaffingRoleService staffingRoleService;

    @Autowired
    public EmpController(IStaffingEmpService staffingEmpService, PasswordHelper passwordHelper, IStaffingRoleService staffingRoleService) {
        this.staffingEmpService = staffingEmpService;
        this.passwordHelper = passwordHelper;
        this.staffingRoleService = staffingRoleService;
    }


    @RequestMapping(value = "/index")
    public String index() {
        return "/emp/index";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(int limit, int offset, String sort, String order, StaffingEmp staffingEmp) {

        EntityWrapper<StaffingEmp> empEntityWrapper = new EntityWrapper<>();

        if (staffingEmp.getEmpStatus() != 0) {
            empEntityWrapper.eq("empStatus", staffingEmp.getEmpStatus());
        }
        Page<StaffingEmp> staffingEmpPage = new Page<>(offset + 1, limit, sort);
        staffingEmpPage.setAsc(order.equals("asc"));
        staffingEmpPage = staffingEmpService.selectPage(
                staffingEmpPage,
                empEntityWrapper);
        List<StaffingEmp> rows = staffingEmpPage.getRecords();
        Map<String, Object> result = new HashMap<>();
        result.put("rows", rows);
        result.put("total", staffingEmpPage.getTotal());
        return result;
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create() {
        return "/emp/create";
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public Object create(StaffingEmp staffingEmp) {

        staffingEmp.setPassword("123456");
        passwordHelper.encryptPassword(staffingEmp);
        return staffingEmpService.insert(staffingEmp) ? renderSuccess("添加成功") : renderError("添加失败");
    }

    @RequestMapping(value = "/update/{empId}", method = RequestMethod.GET)
    public String update(@PathVariable("empId") Long empId, Model model) {
        StaffingEmp staffingEmp = staffingEmpService.selectById(empId);
        model.addAttribute("staffingEmp", staffingEmp);
        return "emp/update";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Object update(StaffingEmp staffingEmp) {
        return staffingEmpService.updateById(staffingEmp) ? renderSuccess("修改成功") : renderError("修改失败");
    }

    @RequestMapping(value = "/delete/{ids}", method = RequestMethod.POST)
    @ResponseBody
    public Object delete(@PathVariable("ids") String ids) {
        return staffingEmpService.deleteBatchIds(Arrays.asList(ids.split("-"))) ? renderSuccess("删除成功") : renderError("删除失败");
    }

    @RequestMapping(value = "/changePwd/{empId}")
    public String changePwd(@PathVariable("empId") Long empId, Model model) {
        model.addAttribute("empId", empId);
        return "emp/changePwd";
    }

    @RequestMapping(value = "/changePwd")
    @ResponseBody
    public Object changePwd(String password, String confirmPwd, Long empId) {
        StaffingEmp staffingEmp = staffingEmpService.selectById(empId);
        staffingEmp.setEmpId(empId);
        staffingEmp.setPassword(password);
        passwordHelper.encryptPassword(staffingEmp);
        return staffingEmpService.updateById(staffingEmp) ? renderSuccess("修改成功") : renderError("修改失败");
    }

    @RequestMapping(value = "/role/{empId}")
    public String role(@PathVariable("empId") Long empId, Model model) {
        StaffingEmp staffingEmp = staffingEmpService.selectById(empId);
String enterpriseId = getEnterpriseId();
        List<StaffingRole> staffingRoles = staffingRoleService.selectList(new EntityWrapper<StaffingRole>().eq("enterpriseId",Long.parseLong(enterpriseId)));
        model.addAttribute("staffingRoles", staffingRoles);

        List<StaffingRole> staffingEmpRoles = staffingEmpService.findRoles(getEnterpriseId(), staffingEmp.getUsername());

        model.addAttribute("staffingEmpRoles", staffingEmpRoles);
        return "emp/role";
    }

    @RequestMapping(value = "/role/{empId}", method = RequestMethod.POST)
    @ResponseBody
    public Object role(@PathVariable("empId") Long empId, HttpServletRequest request) {

//        String[] roleIds = request.getParameterValues("roleId");
//        upmsUserRoleService.role(roleIds, id);
//        return new UpmsResult(UpmsResultConstant.SUCCESS, "");
        return null;
    }


}
