package top.youchangxu.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import top.youchangxu.model.system.StaffingEmp;
import top.youchangxu.model.system.StaffingPermission;
import top.youchangxu.service.system.IStaffingEmpService;
import top.youchangxu.service.system.IStaffingPermissionService;

import java.util.List;

/**
 * Created by dtkj_android on 2017/5/25.
 */
@Controller
public class ManagerController extends BaseController {
    private IStaffingPermissionService staffingPermissionService;
    private IStaffingEmpService staffingEmpService;

    @Autowired
    public ManagerController(IStaffingPermissionService staffingPermissionService,
                             IStaffingEmpService staffingEmpService) {
        this.staffingPermissionService = staffingPermissionService;
        this.staffingEmpService = staffingEmpService;
    }

    @RequestMapping(value = "/index")
    public String index(Model model) {


        Subject subject = SecurityUtils.getSubject();
        String username = (String) subject.getPrincipal();
        StaffingEmp staffingEmp = staffingEmpService.selectOne(new EntityWrapper<StaffingEmp>().eq("username",username));
        model.addAttribute("staffingEmp",staffingEmp);
        List<StaffingPermission> permissions = staffingPermissionService.selectList(new EntityWrapper<StaffingPermission>());
        model.addAttribute("permissions", permissions);
        return "/index";
    }
}
