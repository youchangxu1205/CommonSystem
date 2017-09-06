package top.youchangxu.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import org.apache.commons.lang.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import top.youchangxu.common.exception.InsertException;
import top.youchangxu.common.exception.OutOfRangeScoreException;
import top.youchangxu.common.result.ResultEnum;
import top.youchangxu.model.multiplescore.MultiplescoreScoreBill;
import top.youchangxu.model.multiplescore.MultiplescoreScoreBillDetail;
import top.youchangxu.model.system.*;
import top.youchangxu.service.multiplescore.IMultiplescoreScoreBillDetailService;
import top.youchangxu.service.multiplescore.IMultiplescoreScoreBillService;
import top.youchangxu.service.system.*;

import java.util.ArrayList;
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
    private IMultiplescoreScoreBillDetailService multiplescoreScoreBillDetailService;
    private IStaffingPostService staffingPostService;
    private IStaffingPostEmpService staffingPostEmpService;

    @Autowired
    public ScoreBillController(IMultiplescoreScoreBillService multiplescoreScoreBillService,
                               IStaffingEmpService staffingEmpService,
                               IStaffingEnterpriseEmpService staffingEnterpriseEmpService,
                               IMultiplescoreScoreBillDetailService multiplescoreScoreBillDetailService,
                               IStaffingPostService staffingPostService,
                               IStaffingPostEmpService staffingPostEmpService) {
        this.multiplescoreScoreBillService = multiplescoreScoreBillService;
        this.staffingEmpService = staffingEmpService;
        this.staffingEnterpriseEmpService = staffingEnterpriseEmpService;
        this.multiplescoreScoreBillDetailService = multiplescoreScoreBillDetailService;
        this.staffingPostService = staffingPostService;
        this.staffingPostEmpService = staffingPostEmpService;
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
        multiplescoreScoreBillEntityWrapper.eq("enterpriseId",getEnterpriseId());
        Page<MultiplescoreScoreBill> multiplescoreScoreBillPage = new Page<>(offset / limit + 1, limit, sort);
        multiplescoreScoreBillPage.setOrderByField("createTime");
        multiplescoreScoreBillPage.setAsc(order.equals("desc"));
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

        //查询管理岗
        List<Object> postIds = staffingPostService.selectObjs(
                new EntityWrapper<StaffingPost>()
                        .eq("enterpriseId", getEnterpriseId())
                        .eq("isManager", 1)
                        .setSqlSelect("postId"));
        List<StaffingEmp> staffingEmps = new ArrayList<>();
        if (postIds.size() != 0) {
            List<Object> empIds = staffingPostEmpService.selectObjs(
                    new EntityWrapper<StaffingPostEmp>()
                            .in("postId", postIds)
                            .eq("enterpriseId", getEnterpriseId())
                            .setSqlSelect("empId"));

            staffingEmps = staffingEmpService
                    .selectList(new EntityWrapper<StaffingEmp>()
                            .in("empId", empIds)
                            .eq("empStatus", 1));//只查询在职的员工
        }
        model.addAttribute("staffingEmps", staffingEmps);
        //查询担任管理岗的员工

//        List<Object> empIds = staffingEnterpriseEmpService
//                .selectObjs(new EntityWrapper<StaffingEnterpriseEmp>()
//                        .eq("enterpriseId", getEnterpriseId())
//                        .setSqlSelect("empId"));
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
     * @param bills
     * @param drawerID
     * @param billTime
     * @param scoreBillDesc
     * @return
     */
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public Object create(String bills, Long drawerID, String billTime, String scoreBillDesc) {
        try {
            boolean insert = multiplescoreScoreBillService.saveScoreBill(bills, drawerID, billTime, scoreBillDesc, NumberUtils.toLong(getEnterpriseId()));
            return insert ? renderSuccess("添加成功") : renderError(ResultEnum.INSERT_ERROR);
        } catch (OutOfRangeScoreException e) {
            return renderError(e.getMessage());
        } catch (InsertException e) {
            return renderError(e.getMessage());
        }

    }

    @RequestMapping(value = "/detail/{scoreBillId}", method = RequestMethod.GET)
    public String detail(@PathVariable("scoreBillId") Long scoreBillId, Model model) {
        List<MultiplescoreScoreBillDetail> scoreBillDetails = multiplescoreScoreBillDetailService
                .selectList(new EntityWrapper<MultiplescoreScoreBillDetail>().eq("scoreBillId", scoreBillId));
        model.addAttribute("scoreBillDetails", JSON.toJSONString(scoreBillDetails));
        return "scorebill/detail";
    }
}
