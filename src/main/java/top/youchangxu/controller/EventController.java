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
import top.youchangxu.model.system.MultiplescoreEvent;
import top.youchangxu.model.system.MultiplescoreEventCategory;
import top.youchangxu.model.system.MultiplescorePostEventRange;
import top.youchangxu.model.system.StaffingPostEmp;
import top.youchangxu.service.system.IMultiplescoreEventCategoryService;
import top.youchangxu.service.system.IMultiplescoreEventService;
import top.youchangxu.service.system.IMultiplescorePostEventRangeService;
import top.youchangxu.service.system.IStaffingPostEmpService;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by dtkj_android on 2017/6/9.
 */
@Controller
@RequestMapping("/event")
public class EventController extends BaseController {

    private IMultiplescoreEventService multiplescoreEventService;
    private IMultiplescoreEventCategoryService multiplescoreEventCategoryService;
    private IMultiplescorePostEventRangeService multiplescorePostEventRangeService;
    private IStaffingPostEmpService staffingPostEmpService;

    @Autowired
    public EventController(IMultiplescoreEventService multiplescoreEventService,
                           IMultiplescoreEventCategoryService multiplescoreEventCategoryService,
                           IMultiplescorePostEventRangeService multiplescorePostEventRangeService,
                           IStaffingPostEmpService staffingPostEmpService) {
        this.multiplescoreEventService = multiplescoreEventService;
        this.multiplescoreEventCategoryService = multiplescoreEventCategoryService;
        this.multiplescorePostEventRangeService = multiplescorePostEventRangeService;
        this.staffingPostEmpService = staffingPostEmpService;
    }

    /**
     * 积分事件首页
     *
     * @return
     */
    @RequestMapping(value = "/index")
//    @RequiresPermissions("staffing:event:read")
    public String index(Model model) {

        JSONArray eventCategories = multiplescoreEventCategoryService.getBootstrapTreeData(getEnterpriseId());
        model.addAttribute("eventCategories", eventCategories);
        return "/event/index";
    }

    @RequestMapping(value = "/listCategory", method = RequestMethod.GET)
    @ResponseBody
    public Object listCategory() {
        JSONArray eventCategories = multiplescoreEventCategoryService.getBootstrapTreeData(getEnterpriseId());
        return eventCategories;
    }

    /**
     * 积分事件列表
     *
     * @param limit
     * @param offset
     * @param sort
     * @param order
     * @param multiplescoreEvent
     * @return
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
//    @RequiresPermissions("staffing:event:read")
    @ResponseBody
    public Object list(int limit, int offset, String sort, String order, MultiplescoreEvent multiplescoreEvent) {

        EntityWrapper<MultiplescoreEvent> eventEntityWrapper = new EntityWrapper<>();
        if (multiplescoreEvent.getEventCategoryId() != null) {
            eventEntityWrapper.eq("eventCategoryId", multiplescoreEvent.getEventCategoryId());
        }
        Page<MultiplescoreEvent> multiplescoreEventPage = new Page<>(offset / limit + 1, limit, sort);
        multiplescoreEventPage.setAsc(order.equals("asc"));
        multiplescoreEventPage = multiplescoreEventService.selectPage(
                multiplescoreEventPage,
                eventEntityWrapper);
        List<MultiplescoreEvent> rows = multiplescoreEventPage.getRecords();
        Map<String, Object> result = new HashMap<>();
        result.put("rows", rows);
        result.put("total", multiplescoreEventPage.getTotal());
        return result;
    }


    /**
     * 创建积分事件
     *
     * @return
     */
    @RequestMapping(value = "/create", method = RequestMethod.GET)
//    @RequiresPermissions("staffing:event:create")
    public String create() {
        return "/event/create";
    }

    /**
     * 创建积分分类
     *
     * @return
     */
    @RequestMapping(value = "/category/create", method = RequestMethod.GET)
//    @RequiresPermissions("staffing:event:create")
    public String createCategory() {
        return "/event/createCategory";
    }


    /**
     * 修改积分分类
     *
     * @return
     */
    @RequestMapping(value = "/category/update/{eventCategoryId}", method = RequestMethod.GET)
    public String updateCategory(@PathVariable("eventCategoryId") Long eventCategoryId, Model model) {
        MultiplescoreEventCategory multiplescoreEventCategory = multiplescoreEventCategoryService.selectById(eventCategoryId);
        model.addAttribute("multiplescoreEventCategory", multiplescoreEventCategory);
        return "/event/updateCategory";
    }


    /**
     * 创建积分事件
     *
     * @param multiplescoreEventCategory
     * @return
     */
    @RequestMapping(value = "/createCategory", method = RequestMethod.POST)
    @ResponseBody
    public Object createCategory(MultiplescoreEventCategory multiplescoreEventCategory) {
        multiplescoreEventCategory.setEnterpriseId(Long.parseLong(getEnterpriseId()));
        boolean insert = multiplescoreEventCategoryService.insert(multiplescoreEventCategory);
        return insert ? renderSuccess("添加成功") : renderError(ResultEnum.INSERT_ERROR);
    }

    /**
     * 修改积分分类
     *
     * @param multiplescoreEventCategory
     * @return
     */
    @RequestMapping(value = "/updateCategory", method = RequestMethod.POST)
    @ResponseBody
    public Object updateCategory(MultiplescoreEventCategory multiplescoreEventCategory) {
        boolean insert = multiplescoreEventCategoryService.updateById(multiplescoreEventCategory);
        return insert ? renderSuccess("添加成功") : renderError(ResultEnum.INSERT_ERROR);
    }

    /**
     * 删除积分分类
     *
     * @param eventCategoryId
     * @return
     */
    @RequestMapping(value = "/deleteCategory/{eventCategoryId}", method = RequestMethod.POST)
    @ResponseBody
    public Object deleteCategory(@PathVariable("eventCategoryId") Long eventCategoryId) {
        boolean insert = multiplescoreEventCategoryService.deleteById(eventCategoryId);
        return insert ? renderSuccess("添加成功") : renderError(ResultEnum.INSERT_ERROR);
    }

    /**
     * 创建积分事件
     *
     * @param multiplescoreEvent
     * @return
     */
    @RequestMapping(value = "/create", method = RequestMethod.POST)
//    @RequiresPermissions("staffing:event:create")
    @ResponseBody
    public Object create(MultiplescoreEvent multiplescoreEvent) {
        multiplescoreEvent.setEnterpriseId(Long.parseLong(getEnterpriseId()));
        boolean insert = multiplescoreEventService.insert(multiplescoreEvent);
        return insert ? renderSuccess("添加成功") : renderError(ResultEnum.INSERT_ERROR);
    }

    /**
     * 更新积分事件
     *
     * @param eventId
     * @param model
     * @return
     */
//    @RequiresPermissions("staffing:event:update")
    @RequestMapping(value = "/update/{eventId}", method = RequestMethod.GET)
    public String update(@PathVariable("eventId") Long eventId, Model model) {
        MultiplescoreEvent multiplescoreEvent = multiplescoreEventService.selectById(eventId);
        model.addAttribute("multiplescoreEvent", multiplescoreEvent);
        return "/event/update";
    }

    /**
     * 更新积分事件
     *
     * @param multiplescoreEvent
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
//    @RequiresPermissions("staffing:enterprise:update")
    @ResponseBody
    public Object update(MultiplescoreEvent multiplescoreEvent) {
        return multiplescoreEventService.updateById(multiplescoreEvent) ? renderSuccess("修改成功") : renderError(ResultEnum.UPDATE_ERROR);
    }

    /**
     * 删除积分事件
     *
     * @param ids
     * @return
     */
    @RequestMapping(value = "/delete/{ids}", method = RequestMethod.POST)
    @ResponseBody
    public Object delete(@PathVariable("ids") String ids) {
        return multiplescoreEventService.deleteBatchIds(Arrays.asList(ids.split("-"))) ? renderSuccess("删除成功") : renderError(ResultEnum.DELETE_ERROR);
    }

    /**
     * 根据员工Id获取奖扣分事件
     * @param empId
     * @return
     */
    @RequestMapping(value = "/empEvent", method = RequestMethod.GET)
    @ResponseBody
    public Object empEvent(Long empId) {

        Map<String, Object> result = new HashMap<>();
        if(empId==null){
            return result;
        }

        List<Object> postIds = staffingPostEmpService.selectObjs(new EntityWrapper<StaffingPostEmp>().eq("empId", empId)
                .eq("enterpriseId", getEnterpriseId()).setSqlSelect("postId").groupBy("postId"));

        List<Object> scoreEventIds = multiplescorePostEventRangeService.selectObjs(
                new EntityWrapper<MultiplescorePostEventRange>()
                        .in("posthigherId", postIds).eq("enterpriseId", getEnterpriseId()).setSqlSelect("scoreEventId"));
        List<MultiplescoreEvent> multiplescoreEvents = multiplescoreEventService.selectList(new EntityWrapper<MultiplescoreEvent>().in("eventId", scoreEventIds)
                .eq("enterpriseId", getEnterpriseId()));

        result.put("rows", multiplescoreEvents);
        result.put("total", multiplescoreEvents.size());
        return result;
    }

}
