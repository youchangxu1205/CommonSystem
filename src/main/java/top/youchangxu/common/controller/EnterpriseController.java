package top.youchangxu.common.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import top.youchangxu.common.model.system.StaffingEnterprise;
import top.youchangxu.common.service.system.IStaffingEnterpriseService;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by dtkj_android on 2017/5/26.
 */
@Controller
@RequestMapping("/enterprise")
public class EnterpriseController extends BaseController {

    private IStaffingEnterpriseService staffingEnterpriseService;

    @Autowired
    public EnterpriseController(IStaffingEnterpriseService staffingEnterpriseService) {
        this.staffingEnterpriseService = staffingEnterpriseService;
    }

    @RequestMapping(value = "/index")
    public String index() {
        return "/enterprise/index";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(int limit, int offset, String sort, String order, StaffingEnterprise staffingEnterprise) {

        EntityWrapper<StaffingEnterprise> enterpriseEntityWrapper = new EntityWrapper<>();


        Page<StaffingEnterprise> staffingEnterprisePage = new Page<>(offset + 1, limit, sort);
        staffingEnterprisePage.setAsc(order.equals("asc"));
        staffingEnterprisePage = staffingEnterpriseService.selectPage(
                staffingEnterprisePage,
                enterpriseEntityWrapper);
        List<StaffingEnterprise> rows = staffingEnterprisePage.getRecords();
        Map<String, Object> result = new HashMap<>();
        result.put("rows", rows);
        result.put("total", staffingEnterprisePage.getTotal());
        return result;
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create() {
        return "/enterprise/create";
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public Object create(StaffingEnterprise staffingEnterprise) {
        return staffingEnterpriseService.insert(staffingEnterprise) ? renderSuccess("添加成功") : renderError("添加失败");
    }

    @RequestMapping(value = "/update/{enterpriseId}", method = RequestMethod.GET)
    public String update(@PathVariable("enterpriseId") Long enterpriseId, Model model) {
        StaffingEnterprise staffingEnterprise = staffingEnterpriseService.selectById(enterpriseId);
        model.addAttribute("staffingEnterprise", staffingEnterprise);
        return "/enterprise/update";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Object update(StaffingEnterprise staffingEnterprise) {
        return staffingEnterpriseService.updateById(staffingEnterprise) ? renderSuccess("修改成功") : renderError("修改失败");
    }

    @RequestMapping(value = "/delete/{ids}", method = RequestMethod.POST)
    @ResponseBody
    public Object delete(@PathVariable("ids") String ids) {
        return staffingEnterpriseService.deleteBatchIds(Arrays.asList(ids.split("-"))) ? renderSuccess("删除成功") : renderError("删除失败");
    }
}
