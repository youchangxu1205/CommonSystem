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
import top.youchangxu.common.result.ResultEnum;
import top.youchangxu.model.system.StaffingEmp;
import top.youchangxu.model.system.StaffingPermission;
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


        Page<StaffingPermission> staffingPermissionPage = new Page<>(offset/limit + 1, limit, sort);
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
        staffingPermission.setPermissionStatus(1);
        return staffingPermissionService.insert(staffingPermission) ? renderSuccess("添加成功") : renderError(ResultEnum.INSERT_ERROR);
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
        return staffingPermissionService.updateById(staffingPermission) ? renderSuccess("修改成功") : renderError(ResultEnum.UPDATE_ERROR);
    }

    @RequestMapping(value = "/delete/{ids}", method = RequestMethod.POST)
    @ResponseBody
    public Object delete(@PathVariable("ids") String ids) {
        return staffingPermissionService.deleteBatchIds(Arrays.asList(ids.split("-"))) ? renderSuccess("删除成功") : renderError(ResultEnum.DELETE_ERROR);
    }


    @RequestMapping(value = "/role/{roleId}", method = RequestMethod.POST)
    @ResponseBody
    public Object role(@PathVariable("roleId") Long roleId) {
        return staffingPermissionService.getSimpleTreeByRoleId(roleId);
    }



    @RequestMapping(value = "/enterprise/{enterpriseId}", method = RequestMethod.POST)
    @ResponseBody
    public Object enterprise(@PathVariable("enterpriseId") Long enterpriseId) {
        return staffingPermissionService.getSimpleTreeByEnterpriseId(enterpriseId);
    }


}
