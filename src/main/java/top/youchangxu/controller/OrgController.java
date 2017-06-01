package top.youchangxu.controller;

import com.alibaba.fastjson.JSONArray;
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
import top.youchangxu.model.system.StaffingOrg;
import top.youchangxu.service.system.IStaffingOrgService;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by dtkj_android on 2017/5/25.
 */
@Controller
@RequestMapping("/org")
public class OrgController extends BaseController {

    private IStaffingOrgService staffingOrgService;

    @Autowired
    public OrgController(IStaffingOrgService staffingOrgService) {
        this.staffingOrgService = staffingOrgService;
    }

    @RequestMapping(value = "/index")
    public String index(){
        return "/org/index";
    }
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    @ResponseBody
    public Object list(int limit, int offset, String sort, String order, StaffingOrg staffingOrg){

        EntityWrapper<StaffingOrg> orgEntityWrapper = new EntityWrapper<>();

        Page<StaffingOrg> staffingOrgPage = new Page<>(offset + 1, limit, sort);
        staffingOrgPage.setAsc(order.equals("asc"));
        staffingOrgPage = staffingOrgService.selectPage(
                staffingOrgPage,
                orgEntityWrapper);
        List<StaffingOrg> rows = staffingOrgPage.getRecords();
        Map<String, Object> result = new HashMap<>();
        result.put("rows", rows);
        result.put("total", staffingOrgPage.getTotal());
        return result;
    }
    @RequestMapping(value = "/create",method = RequestMethod.GET)
    public String create(){
        return "/org/create";
    }
    @RequestMapping(value = "/create",method = RequestMethod.POST)
    @ResponseBody
    public Object create(StaffingOrg staffingOrg){
        return staffingOrgService.insert(staffingOrg)? renderSuccess("添加成功"):renderError(ResultEnum.INSERT_ERROR);
    }

    @RequestMapping(value = "/update/{orgId}",method = RequestMethod.GET)
    public String update(@PathVariable("orgId") Long orgId, Model model){
        StaffingOrg staffingOrg = staffingOrgService.selectById(orgId);
        model.addAttribute("staffingOrg",staffingOrg);
        return "/org/update";
    }
    @RequestMapping(value = "/update",method = RequestMethod.POST)
    @ResponseBody
    public Object update(StaffingOrg staffingOrg){
        return staffingOrgService.updateById(staffingOrg)? renderSuccess("修改成功"):renderError(ResultEnum.UPDATE_ERROR);
    }

    @RequestMapping(value = "/delete/{ids}",method = RequestMethod.POST)
    @ResponseBody
    public Object delete(@PathVariable("ids") String ids){
        return staffingOrgService.deleteBatchIds(Arrays.asList(ids.split("-")))? renderSuccess("删除成功"):renderError(ResultEnum.DELETE_ERROR);
    }


    @RequestMapping(value = "/orgTree", method = RequestMethod.GET)
    public String orgTree() {
        return "/org/orgTree";
    }

    @RequestMapping(value = "/orgTree/{orgId}", method = RequestMethod.GET)
    @ResponseBody
    public Object orgTree(@PathVariable("orgId") Long orgId) {
        JSONArray orgTree = staffingOrgService.getOrgTree(orgId);
        return orgTree;
    }


}
