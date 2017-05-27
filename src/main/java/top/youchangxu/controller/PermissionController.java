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
import top.youchangxu.model.system.StaffingPermission;
import top.youchangxu.service.PasswordHelper;
import top.youchangxu.service.system.IStaffingEmpService;
import top.youchangxu.service.system.IStaffingPermissionService;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by dtkj_android on 2017/5/25.
 */
@Controller
@RequestMapping("/permission")
public class PermissionController extends BaseController {


    private IStaffingPermissionService staffingPermissionService;

    @Autowired
    public PermissionController(IStaffingPermissionService staffingPermissionService) {
        this.staffingPermissionService = staffingPermissionService;
    }


    @RequestMapping(value = "/index")
    public String index() {
        return "/permission/index";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(int limit, int offset, String sort, String order, StaffingEmp staffingEmp) {

        EntityWrapper<StaffingPermission> permissionEntityWrapper = new EntityWrapper<>();


        Page<StaffingPermission> staffingPermissionPage = new Page<>(offset + 1, limit, sort);
        staffingPermissionPage.setAsc(order.equals("asc"));
        staffingPermissionPage = staffingPermissionService.selectPage(
                staffingPermissionPage,
                permissionEntityWrapper);
        List<StaffingPermission> rows = staffingPermissionPage.getRecords();
        Map<String, Object> result = new HashMap<>();
        result.put("rows", rows);
        result.put("total", staffingPermissionPage.getTotal());
        return result;
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create() {
        return "/permission/create";
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public Object create(StaffingPermission staffingPermission) {

        return staffingPermissionService.insert(staffingPermission) ? renderSuccess("添加成功") : renderError("添加失败");
    }

    @RequestMapping(value = "/update/{permissionId}", method = RequestMethod.GET)
    public String update(@PathVariable("permissionId") Long empId, Model model) {
        StaffingPermission staffingPermission = staffingPermissionService.selectById(empId);
        model.addAttribute("staffingPermission", staffingPermission);
        return "/permission/update";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Object update(StaffingPermission staffingPermission) {
        return staffingPermissionService.updateById(staffingPermission) ? renderSuccess("修改成功") : renderError("修改失败");
    }

    @RequestMapping(value = "/delete/{ids}", method = RequestMethod.POST)
    @ResponseBody
    public Object delete(@PathVariable("ids") String ids) {
        return staffingPermissionService.deleteBatchIds(Arrays.asList(ids.split("-"))) ? renderSuccess("删除成功") : renderError("删除失败");
    }

}
