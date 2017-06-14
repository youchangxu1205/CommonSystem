package top.youchangxu.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import top.youchangxu.common.result.ResultEnum;
import top.youchangxu.model.system.MultiplescoreScoreBill;
import top.youchangxu.model.system.StaffingEmp;
import top.youchangxu.model.system.StaffingEnterpriseEmp;
import top.youchangxu.service.system.IMultiplescoreScoreBillService;
import top.youchangxu.service.system.IStaffingEmpService;
import top.youchangxu.service.system.IStaffingEnterpriseEmpService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by dtkj_android on 2017/6/14.
 */
@Controller
@RequestMapping("/scorebill")
public class ScoreBillController extends BaseController {
    private IMultiplescoreScoreBillService multiplescoreScoreBillService;
    private IStaffingEmpService staffingEmpService;
    private IStaffingEnterpriseEmpService staffingEnterpriseEmpService;

    @Autowired
    public ScoreBillController(IMultiplescoreScoreBillService multiplescoreScoreBillService,
                               IStaffingEmpService staffingEmpService,
                               IStaffingEnterpriseEmpService staffingEnterpriseEmpService) {
        this.multiplescoreScoreBillService = multiplescoreScoreBillService;
        this.staffingEmpService = staffingEmpService;
        this.staffingEnterpriseEmpService = staffingEnterpriseEmpService;
    }

    /**
     * 单据管理首页
     *
     * @return
     */
    @RequestMapping(value = "/index")
    public String index() {
        return "/scorebill/index";
    }

    /**
     * 单据列表
     *
     * @param limit
     * @param offset
     * @param sort
     * @param order
     * @param multiplescoreScoreBill
     * @return
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(int limit, int offset, String sort, String order, MultiplescoreScoreBill multiplescoreScoreBill) {

        EntityWrapper<MultiplescoreScoreBill> multiplescoreScoreBillEntityWrapper = new EntityWrapper<>();
        Page<MultiplescoreScoreBill> multiplescoreScoreBillPage = new Page<>(offset / limit + 1, limit, sort);
        multiplescoreScoreBillPage.setAsc(order.equals("asc"));
        multiplescoreScoreBillPage = multiplescoreScoreBillService.selectPage(
                multiplescoreScoreBillPage,
                multiplescoreScoreBillEntityWrapper);
        List<MultiplescoreScoreBill> rows = multiplescoreScoreBillPage.getRecords();
        Map<String, Object> result = new HashMap<>();
        result.put("rows", rows);
        result.put("total", multiplescoreScoreBillPage.getTotal());
        return result;
    }

    /**
     * 新增单据
     *
     * @return
     */
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(Model model) {

        List<Object> empIds = staffingEnterpriseEmpService
                .selectObjs(new EntityWrapper<StaffingEnterpriseEmp>()
                        .eq("enterpriseId", getEnterpriseId())
                        .setSqlSelect("empId"));
        List<StaffingEmp> staffingEmps = staffingEmpService
                .selectList(new EntityWrapper<StaffingEmp>().in("empId", empIds));
        model.addAttribute("staffingEmps", staffingEmps);
        return "/scorebill/create";
    }


    /**
     * 新增新纪录
     *
     * @return
     */
    @RequestMapping(value = "/addRecord", method = RequestMethod.GET)
    public String addRecord() {
        return "/scorebill/addRecord";
    }


    /**
     * 新增单据
     *
     * @param multiplescoreScoreBill
     * @return
     */
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public Object create(MultiplescoreScoreBill multiplescoreScoreBill) {
        boolean insert = multiplescoreScoreBillService.insert(multiplescoreScoreBill);

        return insert ? renderSuccess("添加成功") : renderError(ResultEnum.INSERT_ERROR);
    }
//
//    /**
//     * 更新企业信息
//     *
//     * @param enterpriseId
//     * @param model
//     * @return
//     */
//    @RequiresPermissions("staffing:enterprise:update")
//    @RequestMapping(value = "/update/{enterpriseId}", method = RequestMethod.GET)
//    public String update(@PathVariable("enterpriseId") Long enterpriseId, Model model) {
//        StaffingEnterprise staffingEnterprise = staffingEnterpriseService.selectById(enterpriseId);
//        model.addAttribute("staffingEnterprise", staffingEnterprise);
//        return "/enterprise/update";
//    }
//
//    /**
//     * 更新企业信息
//     *
//     * @param staffingEnterprise
//     * @return
//     */
//    @RequestMapping(value = "/update", method = RequestMethod.POST)
//    @RequiresPermissions("staffing:enterprise:update")
//    @ResponseBody
//    public Object update(StaffingEnterprise staffingEnterprise) {
//        return staffingEnterpriseService.updateById(staffingEnterprise) ? renderSuccess("修改成功") : renderError(ResultEnum.UPDATE_ERROR);
//    }
//
//    /**
//     * 删除企业
//     *
//     * @param ids
//     * @return
//     */
//    @RequestMapping(value = "/delete/{ids}", method = RequestMethod.POST)
//    @ResponseBody
//    public Object delete(@PathVariable("ids") String ids) {
//        return staffingEnterpriseService.deleteBatchIds(Arrays.asList(ids.split("-"))) ? renderSuccess("删除成功") : renderError(ResultEnum.DELETE_ERROR);
//    }
}
