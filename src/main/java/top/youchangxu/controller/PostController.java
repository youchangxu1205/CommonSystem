package top.youchangxu.controller;

import com.alibaba.fastjson.JSONArray;
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
import top.youchangxu.common.result.ResultEnum;
import top.youchangxu.common.utils.StringUtil;
import top.youchangxu.model.system.*;
import top.youchangxu.model.vo.PostRangeVO;
import top.youchangxu.service.system.*;

import java.util.*;

/**
 * Created by dtkj_android on 2017/5/26.
 */
@Controller
@RequestMapping("/post")
public class PostController extends BaseController {

    private IStaffingPostService staffingPostService;
    private IStaffingOrgService staffingOrgService;
    private IMultiplescorePostRangeService multiplesoreRangeService;
    private IMultiplescorePostEventRangeService multiplescorePostEventRangeService;
    private IMultiplescoreEventService multiplescoreEventService;
    private IStaffingPostEmpService staffingPostEmpService;
    private IStaffingEmpService staffingEmpService;

    @Autowired
    public PostController(IStaffingPostService staffingPostService,
                          IStaffingOrgService staffingOrgService,
                          IMultiplescorePostRangeService multiplesoreRangeService,
                          IMultiplescorePostEventRangeService multiplescorePostEventRangeService,
                          IMultiplescoreEventService multiplescoreEventService,
                          IStaffingPostEmpService staffingPostEmpService,
                          IStaffingEmpService staffingEmpService) {
        this.staffingPostService = staffingPostService;
        this.staffingOrgService = staffingOrgService;
        this.multiplesoreRangeService = multiplesoreRangeService;
        this.multiplescorePostEventRangeService = multiplescorePostEventRangeService;
        this.multiplescoreEventService = multiplescoreEventService;
        this.staffingPostEmpService = staffingPostEmpService;
        this.staffingEmpService = staffingEmpService;
    }

    /**
     * 岗位首页
     *
     * @return
     */
    @RequestMapping(value = "/index")
    public String index(Model model) {
        JSONArray orgBootstrapTree = staffingOrgService.getOrgBootstrapTree(Long.parseLong(getEnterpriseId()));
        model.addAttribute("treeData", orgBootstrapTree);
        return "/post/index";
    }

    /**
     * 岗位列表
     *
     * @param limit
     * @param offset
     * @param sort
     * @param order
     * @param staffingPost
     * @return
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(int limit, int offset, String sort, String order, StaffingPost staffingPost) {

        EntityWrapper<StaffingPost> postEntityWrapper = new EntityWrapper<>();
        postEntityWrapper.eq("enterpriseId", getEnterpriseId());
        if (staffingPost.getOrgId() != 0) {
            postEntityWrapper.eq("orgId", staffingPost.getOrgId());
        }
        Page<StaffingPost> staffingPostPage = new Page<>(offset / limit + 1, limit, sort);
        staffingPostPage.setAsc(order.equals("asc"));
        staffingPostPage = staffingPostService.selectPage(
                staffingPostPage,
                postEntityWrapper);
        List<StaffingPost> rows = staffingPostPage.getRecords();
        Map<String, Object> result = new HashMap<>();
        result.put("rows", rows);
        result.put("total", staffingPostPage.getTotal());
        return result;
    }

    /**
     * 创建岗位
     *
     * @return
     */
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(Model model, Long orgId) {
        List<StaffingOrg> orgs = staffingOrgService.selectList(new EntityWrapper<StaffingOrg>().eq("enterpriseId", getEnterpriseId()));
        model.addAttribute("staffingOrgs", orgs);
        StaffingOrg staffingOrg = staffingOrgService.selectById(orgId);
        model.addAttribute("staffingOrg", staffingOrg);
        return "/post/create";
    }

    /**
     * 创建岗位
     *
     * @param staffingPost
     * @return
     */
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public Object create(StaffingPost staffingPost) {
        staffingPost.setEnterpriseId(NumberUtils.toLong(getEnterpriseId()));
        boolean insert = staffingPostService.insert(staffingPost);
        return insert ? renderSuccess("添加成功") : renderError(ResultEnum.INSERT_ERROR);
    }

    /**
     * 更新岗位信息
     *
     * @param postId
     * @param model
     * @return
     */
    @RequestMapping(value = "/update/{postId}", method = RequestMethod.GET)
    public String update(@PathVariable("postId") Long postId, Model model) {
        StaffingPost staffingPost = staffingPostService.selectById(postId);
        model.addAttribute("staffingPost", staffingPost);
        List<StaffingOrg> orgs = staffingOrgService.selectList(new EntityWrapper<StaffingOrg>().eq("enterpriseId", getEnterpriseId()));
        model.addAttribute("staffingOrgs", orgs);
        return "/post/update";
    }

    /**
     * 更新岗位信息
     *
     * @param staffingPost
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Object update(StaffingPost staffingPost) {
        return staffingPostService.updateById(staffingPost) ? renderSuccess("修改成功") : renderError(ResultEnum.UPDATE_ERROR);
    }

    /**
     * 删除岗位
     *
     * @param ids
     * @return
     */
    @RequestMapping(value = "/delete/{ids}", method = RequestMethod.POST)
    @ResponseBody
    public Object delete(@PathVariable("ids") String ids) {
        return staffingPostService.deleteBatchIds(Arrays.asList(ids.split("-"))) ? renderSuccess("删除成功") : renderError(ResultEnum.DELETE_ERROR);
    }


    /**
     * 奖扣分范围岗位页面
     *
     * @param postId
     * @return
     */
    @RequestMapping(value = "/range/{postId}", method = RequestMethod.GET)
    public String range(@PathVariable("postId") Long postId, Model model) {
        return "post/range";
    }

    @RequestMapping(value = "/range", method = RequestMethod.GET)
    @ResponseBody
    public Object range(Long postId) {
        Map<String, Object> result = new HashMap<>();
        List<PostRangeVO> postRangeVOS = multiplesoreRangeService.selectPostRangeVOS(postId);
        result.put("rows", postRangeVOS);
        result.put("total", postRangeVOS.size());
        return result;
    }

    /**
     * 获取不在岗位范围内的岗位
     *
     * @param postId
     * @return
     */
    @RequestMapping(value = "/noRange", method = RequestMethod.GET)
    @ResponseBody
    public Object noRange(Long postId) {
        Map<String, Object> result = new HashMap<>();
        List<PostRangeVO> postRangeVOS = multiplesoreRangeService.selectPostNoRangeVOS(postId);
        result.put("rows", postRangeVOS);
        result.put("total", postRangeVOS.size());
        return result;
    }

    /**
     * 更新岗位范围
     *
     * @param ids
     * @param postId
     * @return
     */
    @RequestMapping(value = "/postRange", method = RequestMethod.POST)
    @ResponseBody
    public Object postRange(String ids, Long postId) {
        List<MultiplescorePostRange> multiplescorePostRanges = new ArrayList<>();
        if (StringUtil.isNotEmpty(ids)) {
            String[] idsArray = ids.split("-");
            for (String id :
                    idsArray) {
                MultiplescorePostRange multiplescorePostRange = new MultiplescorePostRange();
                multiplescorePostRange.setPostHigherId(postId);
                multiplescorePostRange.setPostLowerId(NumberUtils.toLong(id));
                multiplescorePostRange.setEnterpriseId(NumberUtils.toLong(getEnterpriseId()));
                multiplescorePostRanges.add(multiplescorePostRange);
            }
        }

        boolean b = multiplesoreRangeService.updateRanges(multiplescorePostRanges, postId, NumberUtils.toLong(getEnterpriseId()));
        return b ? renderSuccess(ResultEnum.UPDATE_SUCCESS) : renderError(ResultEnum.UPDATE_ERROR);
    }


    /**
     * 奖扣分范围事件页面
     *
     * @param postId
     * @return
     */
    @RequestMapping(value = "/eventRange/{postId}", method = RequestMethod.GET)
    public String eventRange(@PathVariable("postId") Long postId, Model model) {
        return "post/eventRange";
    }

    /**
     * 获取事件范围内的事件
     *
     * @param postId
     * @return
     */
    @RequestMapping(value = "/eventRange", method = RequestMethod.GET)
    @ResponseBody
    public Object eventRange(Long postId) {
        Map<String, Object> result = new HashMap<>();


        List<Object> eventIds = multiplescorePostEventRangeService.selectObjs(new EntityWrapper<MultiplescorePostEventRange>()
                .eq("enterpriseId", getEnterpriseId())
                .eq("postHigherId", postId)
                .setSqlSelect("scoreEventId"));
        List<MultiplescoreEvent> multiplescoreEvents = new ArrayList<>();
        if (eventIds.size() > 0) {
            multiplescoreEvents = multiplescoreEventService.selectList(
                    new EntityWrapper<MultiplescoreEvent>().in("eventId", eventIds).eq("enterpriseId", getEnterpriseId()));

        }
        result.put("rows", multiplescoreEvents);
        result.put("total", multiplescoreEvents.size());
        return result;
    }

    /**
     * 获取不在事件范围内的事件
     *
     * @param postId
     * @return
     */
    @RequestMapping(value = "/noEventRange", method = RequestMethod.GET)
    @ResponseBody
    public Object noEventRange(Long postId) {
        Map<String, Object> result = new HashMap<>();


        List<Object> eventIds = multiplescorePostEventRangeService.selectObjs(new EntityWrapper<MultiplescorePostEventRange>()
                .eq("enterpriseId", getEnterpriseId())
                .eq("postHigherId", postId)
                .setSqlSelect("scoreEventId"));

        List<MultiplescoreEvent> multiplescoreEvents = multiplescoreEventService.selectList(
                new EntityWrapper<MultiplescoreEvent>().notIn("eventId", eventIds).eq("enterpriseId", getEnterpriseId()));


        result.put("rows", multiplescoreEvents);
        result.put("total", multiplescoreEvents.size());
        return result;
    }

    /**
     * 更新事件范围
     *
     * @param ids
     * @param postId
     * @return
     */
    @RequestMapping(value = "/eventRange", method = RequestMethod.POST)
    @ResponseBody
    public Object postEventRange(String ids, Long postId) {
        List<MultiplescorePostEventRange> multiplescorePostEventRanges = new ArrayList<>();
        if (StringUtil.isNotEmpty(ids)) {
            String[] idsArray = ids.split("-");
            for (String id :
                    idsArray) {
                MultiplescorePostEventRange multiplescorePostEventRange = new MultiplescorePostEventRange();
                multiplescorePostEventRange.setPostHigherId(postId);
                multiplescorePostEventRange.setScoreEventId(NumberUtils.toLong(id));
                multiplescorePostEventRange.setEnterpriseId(NumberUtils.toLong(getEnterpriseId()));
                multiplescorePostEventRanges.add(multiplescorePostEventRange);
            }
        }

        boolean b = multiplescorePostEventRangeService.updateEventRanges(multiplescorePostEventRanges, postId, NumberUtils.toLong(getEnterpriseId()));
        return b ? renderSuccess(ResultEnum.UPDATE_SUCCESS) : renderError(ResultEnum.UPDATE_ERROR);
    }
    @RequestMapping(value = "/emp",method = RequestMethod.GET)
    public String emp(){
        return "post/emp";
    }

    /**
     * 查看岗位担任人
     *
     * @param postId
     * @return
     */
    @RequestMapping(value = "/emp/{postId}", method = RequestMethod.GET)
    @ResponseBody
    public Object emp(@PathVariable("postId") Long postId) {
        Map<String, Object> result = new HashMap<>();
        List<Object> empIds = staffingPostEmpService.selectObjs(
                new EntityWrapper<StaffingPostEmp>()
                        .eq("enterpriseId", getEnterpriseId())
                        .eq("postId", postId)
                        .setSqlSelect("empId"));
        if (empIds.size() == 0) {
            return result;
        }
        List<StaffingEmp> staffingEmps = staffingEmpService.selectList(
                new EntityWrapper<StaffingEmp>().in("empId", empIds));
        result.put("rows", staffingEmps);
        result.put("total", staffingEmps.size());
        return result;
    }

}
