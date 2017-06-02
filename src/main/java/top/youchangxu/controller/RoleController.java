package top.youchangxu.controller;

import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import top.youchangxu.common.result.ResultEnum;
import top.youchangxu.model.system.StaffingRole;
import top.youchangxu.service.system.IStaffingRolePermissionService;
import top.youchangxu.service.system.IStaffingRoleService;

import javax.servlet.http.HttpServletRequest;
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
    private IStaffingRolePermissionService staffingRolePermissionService;

    @Autowired
    public RoleController(IStaffingRoleService staffingRoleService,
                          IStaffingRolePermissionService staffingRolePermissionService) {
        this.staffingRoleService = staffingRoleService;
        this.staffingRolePermissionService = staffingRolePermissionService;
    }


    @RequestMapping(value = "/index")
    public String index() {
        return "/role/index";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(int limit, int offset, String sort, String order, StaffingRole staffingRole) {

        EntityWrapper<StaffingRole> roleEntityWrapper = new EntityWrapper<>();
        roleEntityWrapper.eq("enterpriseId",getEnterpriseId());


        Page<StaffingRole> staffingRolePage = new Page<>(offset / limit + 1, limit, sort);
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
        staffingRole.setEnterpriseId(Long.valueOf(getEnterpriseId()));
        return staffingRoleService.insert(staffingRole) ? renderSuccess("添加成功") : renderError(ResultEnum.INSERT_ERROR);
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
        return staffingRoleService.updateById(staffingRole) ? renderSuccess("修改成功") : renderError(ResultEnum.UPDATE_ERROR);
    }

    @RequestMapping(value = "/delete/{ids}", method = RequestMethod.POST)
    @ResponseBody
    public Object delete(@PathVariable("ids") String ids) {
        return staffingRoleService.deleteBatchIds(Arrays.asList(ids.split("-"))) ? renderSuccess("删除成功") : renderError(ResultEnum.DELETE_ERROR);
    }


    @RequestMapping(value = "/permission/{roleId}", method = RequestMethod.GET)
    public String permission(@PathVariable("roleId") int roleId, ModelMap modelMap) {
        StaffingRole role = staffingRoleService.selectById(roleId);
        modelMap.put("role", role);
        return "/role/permission";
    }

    @RequestMapping(value = "/permission/{id}", method = RequestMethod.POST)
    @ResponseBody
    public Object updatePermission(@PathVariable("id") Long id, HttpServletRequest request) {
        JSONArray datas = JSONArray.parseArray(request.getParameter("datas"));
        int result = staffingRolePermissionService.updateRolePermission(datas, id);
        return renderSuccess(ResultEnum.UPDATE_SUCCESS);
    }

}
