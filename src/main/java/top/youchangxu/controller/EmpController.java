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
import top.youchangxu.service.system.IStaffingEmpService;

import java.util.*;

/**
 * Created by dtkj_android on 2017/5/25.
 */
@Controller
@RequestMapping("/emp")
public class EmpController extends BaseController {

    private IStaffingEmpService staffingEmpService;

    @Autowired
    public EmpController(IStaffingEmpService staffingEmpService) {
        this.staffingEmpService = staffingEmpService;
    }

    @RequestMapping(value = "/index")
    public String index(){
        return "/emp/index";
    }
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    @ResponseBody
    public Object list(int limit, int offset, String sort, String order, StaffingEmp staffingEmp){

        EntityWrapper<StaffingEmp> empEntityWrapper = new EntityWrapper<>();

        if(staffingEmp.getEmpStatus() != 0){
            empEntityWrapper.eq("empStatus",staffingEmp.getEmpStatus());
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
    @RequestMapping(value = "/create",method = RequestMethod.GET)
    public String create(){
        return "/emp/create";
    }
    @RequestMapping(value = "/create",method = RequestMethod.POST)
    @ResponseBody
    public Object create(StaffingEmp staffingEmp){
        return staffingEmpService.insert(staffingEmp)? renderSuccess("添加成功"):renderError("添加失败");
    }

    @RequestMapping(value = "/update/{empId}",method = RequestMethod.GET)
    public String update(@PathVariable("empId") Long empId, Model model){
        StaffingEmp staffingEmp = staffingEmpService.selectById(empId);
        model.addAttribute("staffingEmp",staffingEmp);
        return "/emp/update";
    }
    @RequestMapping(value = "/update",method = RequestMethod.POST)
    @ResponseBody
    public Object update(StaffingEmp staffingEmp){
        return staffingEmpService.updateById(staffingEmp)? renderSuccess("修改成功"):renderError("修改失败");
    }

    @RequestMapping(value = "/delete/{ids}",method = RequestMethod.POST)
    @ResponseBody
    public Object delete(@PathVariable("ids") String ids){
        return staffingEmpService.deleteBatchIds(Arrays.asList(ids.split("-")))? renderSuccess("删除成功"):renderError("删除失败");
    }

}
