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

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by dtkj_android on 2017/5/27.
 */
@Controller
@RequestMapping("/role")
public class RoleController extends BaseController {
    private IStaffingRoleService staffingRoleService;

    @Autowired
    public RoleController(IStaffingRoleService staffingRoleService) {
        this.staffingRoleService = staffingRoleService;
    }


    @RequestMapping(value = "/index")
    public String index() {
        return "/role/index";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(int limit, int offset, String sort, String order, StaffingRole staffingRole) {

        EntityWrapper<StaffingRole> roleEntityWrapper = new EntityWrapper<>();


        Page<StaffingRole> staffingRolePage = new Page<>(offset + 1, limit, sort);
        staffingRolePage.setAsc(order.equals("asc"));
        staffingRolePage = staffingRoleService.selectPage(
                staffingRolePage,
                roleEntityWrapper);
        List<StaffingRole> rows = staffingRolePage.getRecords();
        Map<String, Object> result = new HashMap<>();
        result.put("rows", rows);
        result.put("total", staffingRolePage.getTotal());
        return result;
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create() {
        return "/role/create";
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public Object create(StaffingRole staffingRole) {

        return staffingRoleService.insert(staffingRole) ? renderSuccess("添加成功") : renderError("添加失败");
    }

    @RequestMapping(value = "/update/{roleId}", method = RequestMethod.GET)
    public String update(@PathVariable("roleId") Long empId, Model model) {
        StaffingRole staffingRole = staffingRoleService.selectById(empId);
        model.addAttribute("staffingRole", staffingRole);
        return "/role/update";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Object update(StaffingRole staffingRole) {
        return staffingRoleService.updateById(staffingRole) ? renderSuccess("修改成功") : renderError("修改失败");
    }

    @RequestMapping(value = "/delete/{ids}", method = RequestMethod.POST)
    @ResponseBody
    public Object delete(@PathVariable("ids") String ids) {
        return staffingRoleService.deleteBatchIds(Arrays.asList(ids.split("-"))) ? renderSuccess("删除成功") : renderError("删除失败");
    }
}
