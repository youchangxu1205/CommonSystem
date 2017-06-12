package top.youchangxu.controller;

import com.alibaba.druid.support.json.JSONUtils;
import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import org.apache.commons.lang.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import top.youchangxu.common.result.ResultEnum;
import top.youchangxu.model.system.*;
import top.youchangxu.service.system.*;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by dtkj_android on 2017/5/26.
 */
@Controller
@RequestMapping("/post")
public class PostController extends BaseController {

    private IStaffingPostService staffingPostService;
    private IStaffingOrgService staffingOrgService;
    private IMultiplesoreRangeService multiplesoreRangeService;

    @Autowired
    public PostController(IStaffingPostService staffingPostService,
                          IStaffingOrgService staffingOrgService,
                          IMultiplesoreRangeService multiplesoreRangeService) {
        this.staffingPostService = staffingPostService;
        this.staffingOrgService = staffingOrgService;
        this.multiplesoreRangeService = multiplesoreRangeService;
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
     * 奖扣分范围页面
     *
     * @param postId
     * @return
     */
    @RequestMapping(value = "/range/{postId}", method = RequestMethod.GET)
    public String range(@PathVariable("postId") Long postId, Model model) {
        return "post/range";
    }

    @RequestMapping(value = "/postRange/{postId}", method = RequestMethod.GET)
    public Object postRange(@PathVariable("postId") Long postId){
        return multiplesoreRangeService.selectPostRangeVOS(postId);
    }

}
