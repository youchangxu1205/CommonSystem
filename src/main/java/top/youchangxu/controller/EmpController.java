package top.youchangxu.controller;

import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import org.apache.commons.lang.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import top.youchangxu.common.exception.StaffingException;
import top.youchangxu.common.result.ResultEnum;
import top.youchangxu.model.system.*;
import top.youchangxu.model.vo.PostOrgVO;
import top.youchangxu.service.PasswordHelper;
import top.youchangxu.service.multiplescore.IMultiplescoreEmpRangeService;
import top.youchangxu.service.multiplescore.IMultiplescoreEventRangeService;
import top.youchangxu.service.multiplescore.IMultiplescoreEventService;
import top.youchangxu.service.multiplescore.IMultiplescorePostRangeService;
import top.youchangxu.service.system.*;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by dtkj_android on 2017/5/25.
 */
@Controller
@RequestMapping("/emp")
public class EmpController extends BaseController {


    private IStaffingEmpService staffingEmpService;
    private PasswordHelper passwordHelper;
    private IStaffingRoleService staffingRoleService;
    private IStaffingEnterpriseEmpService staffingEnterpriseEmpService;
    private IStaffingRoleEmpService staffingRoleEmpService;
    private IStaffingOrgEmpService staffingOrgEmpService;
    private IStaffingOrgService staffingOrgService;
    private IMultiplescoreEmpRangeService multiplescoreEmpRangeService;
    private IMultiplescoreEventRangeService multiplescoreEventRangeService;
    private IMultiplescoreEventService multiplescoreEventService;
    private IStaffingPostService staffingPostService;
    private IStaffingPostEmpService staffingPostEmpService;
    private IMultiplescorePostRangeService multiplescorePostRangeService;

    @Autowired
    public EmpController(IStaffingEmpService staffingEmpService,
                         PasswordHelper passwordHelper,
                         IStaffingRoleService staffingRoleService,
                         IStaffingEnterpriseEmpService staffingEnterpriseEmpService,
                         IStaffingRoleEmpService staffingRoleEmpService,
                         IStaffingOrgEmpService staffingOrgEmpService,
                         IStaffingOrgService staffingOrgService,
                         IMultiplescoreEmpRangeService multiplescoreEmpRangeService,
                         IMultiplescoreEventRangeService multiplescoreEventRangeService,
                         IMultiplescoreEventService multiplescoreEventService,
                         IStaffingPostService staffingPostService,
                         IStaffingPostEmpService staffingPostEmpService,
                         IMultiplescorePostRangeService multiplescorePostRangeService) {
        this.staffingEmpService = staffingEmpService;
        this.passwordHelper = passwordHelper;
        this.staffingRoleService = staffingRoleService;
        this.staffingEnterpriseEmpService = staffingEnterpriseEmpService;
        this.staffingRoleEmpService = staffingRoleEmpService;
        this.staffingOrgEmpService = staffingOrgEmpService;
        this.staffingOrgService = staffingOrgService;
        this.multiplescoreEmpRangeService = multiplescoreEmpRangeService;
        this.multiplescoreEventRangeService = multiplescoreEventRangeService;
        this.multiplescoreEventService = multiplescoreEventService;
        this.staffingPostService = staffingPostService;
        this.staffingPostEmpService = staffingPostEmpService;
        this.multiplescorePostRangeService = multiplescorePostRangeService;
    }

    /**
     * 员工首页
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/index")
    public String index(Model model) {
        JSONArray orgBootstrapTree = staffingOrgService.getOrgBootstrapTree(Long.parseLong(getEnterpriseId()));
        model.addAttribute("treeData", orgBootstrapTree);
        return "/emp/index";
    }

    /**
     * 获取员工列表
     *
     * @param limit
     * @param offset
     * @param sort
     * @param order
     * @param staffingEmp
     * @param orgId
     * @return
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(int limit, int offset, String sort, String order, StaffingEmp staffingEmp, Long orgId) {
        Map<String, Object> result = new HashMap<>();

        //获取


        Wrapper<StaffingOrg> staffingOrgWrapper = new EntityWrapper<StaffingOrg>()
                .setSqlSelect("orgId")
                .eq("enterpriseId", getEnterpriseId());
        if (orgId != 0) {
            StaffingOrg staffingOrg = staffingOrgService.selectById(orgId);
            staffingOrgWrapper.like("orgPath", staffingOrg.getOrgPath() + ",");
        }

        //获取部门以及下属部门的Id
        List<Object> orgStrs = staffingOrgService.selectObjs(
                staffingOrgWrapper);
        orgStrs.add(orgId);


        //查询部门下的所有员工
        List<Object> orgEmps = staffingOrgEmpService.selectObjs(
                new EntityWrapper<StaffingOrgEmp>()
                        .in("orgId", orgStrs)
                        .setSqlSelect("empId").groupBy("empId"));
        List<StaffingEmp> rows = new ArrayList<>();
        if (orgEmps.size() == 0) {
            result.put("rows", rows);
            result.put("total", 0);
            return result;
        }

        EntityWrapper<StaffingEmp> empEntityWrapper = new EntityWrapper<>();

        if (staffingEmp.getEmpStatus() != 0) {
            empEntityWrapper.eq("empStatus", staffingEmp.getEmpStatus());
        }
        empEntityWrapper.in("empId", orgEmps);
        Page<StaffingEmp> staffingEmpPage = new Page<>(offset / limit + 1, limit, sort);
        staffingEmpPage.setAsc(order.equals("asc"));
        staffingEmpPage = staffingEmpService.selectPage(
                staffingEmpPage,
                empEntityWrapper);
        rows = staffingEmpPage.getRecords();
        result.put("rows", rows);
        result.put("total", staffingEmpPage.getTotal());
        return result;
    }

    /**
     * 创建员工
     *
     * @return
     */
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(Long orgId, Model model) {
        model.addAttribute("orgId", orgId);
        return "/emp/create";
    }

    /**
     * 创建用户
     *
     * @param staffingEmp
     * @param orgId
     * @return
     */
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public Object create(StaffingEmp staffingEmp, Long orgId) {


        try {
            boolean save = staffingEmpService.saveEmp(staffingEmp, orgId, getEnterpriseId());
            return save ? renderSuccess("添加成功") : renderError(ResultEnum.INSERT_ERROR);
        } catch (StaffingException staffingException) {
            return renderError("添加失败");
        } catch (Exception e) {
            return renderError(e.getMessage());
        }
    }

    /**
     * 更新用户
     *
     * @param empId
     * @param model
     * @return
     */
    @RequestMapping(value = "/update/{empId}", method = RequestMethod.GET)
    public String update(@PathVariable("empId") Long empId, Model model) {
        StaffingEmp staffingEmp = staffingEmpService.selectById(empId);
        model.addAttribute("staffingEmp", staffingEmp);
        return "emp/update";
    }

    /**
     * 更新用户
     *
     * @param staffingEmp
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Object update(StaffingEmp staffingEmp) {
        return staffingEmpService.updateById(staffingEmp) ? renderSuccess("修改成功") : renderError(ResultEnum.UPDATE_ERROR);
    }

    /**
     * 批量删除用户
     *
     * @param ids
     * @return
     */
    @RequestMapping(value = "/delete/{ids}", method = RequestMethod.POST)
    @ResponseBody
    public Object delete(@PathVariable("ids") String ids) {
        return staffingEmpService.deleteBatchIds(Arrays.asList(ids.split("-"))) ? renderSuccess("删除成功") : renderError(ResultEnum.DELETE_ERROR);
    }

    /**
     * 修改密码
     *
     * @param empId
     * @param model
     * @return
     */
    @RequestMapping(value = "/changePwd/{empId}")
    public String changePwd(@PathVariable("empId") Long empId, Model model) {
        model.addAttribute("empId", empId);
        return "emp/changePwd";
    }

    /**
     * 修改密码
     *
     * @param password
     * @param confirmPwd
     * @param empId
     * @return
     */
    @RequestMapping(value = "/changePwd")
    @ResponseBody
    public Object changePwd(String password, String confirmPwd, Long empId) {
        StaffingEmp staffingEmp = staffingEmpService.selectById(empId);
        staffingEmp.setEmpId(empId);
        staffingEmp.setPassword(password);
        passwordHelper.encryptPassword(staffingEmp);
        return staffingEmpService.updateById(staffingEmp) ? renderSuccess("修改成功") : renderError(ResultEnum.UPDATE_ERROR);
    }

    /**
     * 员工角色
     *
     * @param empId
     * @param model
     * @return
     */
    @RequestMapping(value = "/role/{empId}")
    public String role(@PathVariable("empId") Long empId, Model model) {
        StaffingEmp staffingEmp = staffingEmpService.selectById(empId);
        String enterpriseId = getEnterpriseId();
        List<StaffingRole> staffingRoles = staffingRoleService.selectList(
                new EntityWrapper<StaffingRole>()
                        .eq("enterpriseId", Long.parseLong(enterpriseId)));
        model.addAttribute("staffingRoles", staffingRoles);

        List<StaffingRole> staffingEmpRoles = staffingEmpService.findRoles(getEnterpriseId(), staffingEmp.getEmpId() + "");

        model.addAttribute("staffingEmpRoles", staffingEmpRoles);
        return "emp/role";
    }

    /**
     * 保存更新员工角色
     *
     * @param empId
     * @param request
     * @return
     */
    @RequestMapping(value = "/role/{empId}", method = RequestMethod.POST)
    @ResponseBody
    public Object role(@PathVariable("empId") Long empId, HttpServletRequest request) {

        String[] roleIds = request.getParameterValues("roleId");
        staffingRoleEmpService.updateRole(roleIds, empId, getEnterpriseId());
        return renderSuccess(ResultEnum.UPDATE_SUCCESS);
    }

    /**
     * 奖扣分范围页面
     *
     * @param empId
     * @return
     */
    @RequestMapping(value = "/range/{empId}", method = RequestMethod.GET)
    public String range(@PathVariable("empId") Long empId, Model model) {

        //获取企业所有的员工
        List<Object> empIds = staffingEnterpriseEmpService.selectObjs(
                new EntityWrapper<StaffingEnterpriseEmp>()
                        .eq("enterpriseId", getEnterpriseId()).setSqlSelect("empId"));

        List<StaffingEmp> staffingEmps = staffingEmpService.selectList(new EntityWrapper<StaffingEmp>().in("empId", empIds));

        //获取员工的奖扣分范围
        List<MultiplescoreEmpRange> staffingRangeEmps =
                multiplescoreEmpRangeService.selectList(
                        new EntityWrapper<MultiplescoreEmpRange>()
                                .eq("enterpriseId", getEnterpriseId())
                                .eq("higherId", empId));

        model.addAttribute("staffingEmps", staffingEmps);
        model.addAttribute("staffingRangeEmps", staffingRangeEmps);


        List<MultiplescoreEvent> multiplescoreEvents = multiplescoreEventService.selectList(new EntityWrapper<MultiplescoreEvent>().eq("enterpriseId", getEnterpriseId()));
        //获取员工的奖扣分事件范围
        List<MultiplescoreEventRange> multiplescoreEventRanges =
                multiplescoreEventRangeService.selectList(
                        new EntityWrapper<MultiplescoreEventRange>()
                                .eq("enterpriseId", getEnterpriseId())
                                .eq("empId", empId));

        model.addAttribute("multiplescoreEvents", multiplescoreEvents);
        model.addAttribute("multiplescoreEventRanges", multiplescoreEventRanges);

        return "emp/range";
    }


    /**
     * 保存员工的奖扣分范围
     *
     * @param empId
     * @param request
     * @return
     */
    @RequestMapping(value = "/range/{empId}", method = RequestMethod.POST)
    @ResponseBody
    public Object range(@PathVariable("empId") Long empId, HttpServletRequest request) {

        String[] empIds = request.getParameterValues("empIds");
        String[] eventIds = request.getParameterValues("eventIds");
        multiplescoreEmpRangeService.updateEmpRanges(empIds, empId, getEnterpriseId());
        multiplescoreEventRangeService.updateEventRanges(eventIds, empId, getEnterpriseId());
        return renderSuccess(ResultEnum.UPDATE_SUCCESS);
    }

    /**
     * 奖扣分范围页面
     *
     * @param empId
     * @return
     */
    @RequestMapping(value = "/org/{empId}", method = RequestMethod.GET)
    public String org(@PathVariable("empId") Long empId, Model model) {

        List<StaffingOrg> orgs = staffingOrgService.selectList(
                new EntityWrapper<StaffingOrg>().eq("enterpriseId", getEnterpriseId()));
        model.addAttribute("staffingOrgs", orgs);
        List<StaffingOrgEmp> staffingOrgEmps = staffingOrgEmpService.selectList(
                new EntityWrapper<StaffingOrgEmp>().eq("empId", empId).eq("enterpriseId", getEnterpriseId()));
        model.addAttribute("staffingOrgEmps", staffingOrgEmps);
        return "emp/org";
    }


    /**
     * 保存员工的奖扣分范围
     *
     * @param empId
     * @param request
     * @return
     */
    @RequestMapping(value = "/org/{empId}", method = RequestMethod.POST)
    @ResponseBody
    public Object org(@PathVariable("empId") Long empId, HttpServletRequest request) {

        String[] orgIds = request.getParameterValues("orgIds");
        staffingOrgEmpService.updateEmpOrg(orgIds, empId, getEnterpriseId());
        return renderSuccess(ResultEnum.UPDATE_SUCCESS);
    }


    /**
     * 奖扣分范围页面
     *
     * @param empId
     * @return
     */
    @RequestMapping(value = "/post/{empId}", method = RequestMethod.GET)
    public String post(@PathVariable("empId") Long empId, Model model) {

        List<PostOrgVO> posts = staffingPostService.selectPostOrgList(NumberUtils.toLong(getEnterpriseId()));
        model.addAttribute("staffingPosts", posts);
        List<StaffingPostEmp> staffingPostEmps = staffingPostEmpService
                .selectList(new EntityWrapper<StaffingPostEmp>().eq("empId", empId).eq("enterpriseId", getEnterpriseId()));
        model.addAttribute("staffingPostEmps", staffingPostEmps);
        return "emp/post";
    }


    /**
     * 保存员工的奖扣分范围
     *
     * @param empId
     * @param request
     * @return
     */
    @RequestMapping(value = "/post/{empId}", method = RequestMethod.POST)
    @ResponseBody
    public Object post(@PathVariable("empId") Long empId, HttpServletRequest request) {

        String[] postIds = request.getParameterValues("postIds");
        staffingPostEmpService.updateEmpPost(postIds, empId, getEnterpriseId());
        return renderSuccess(ResultEnum.UPDATE_SUCCESS);
    }

    @RequestMapping(value = "/noSetPostEmp", method = RequestMethod.GET)
    public String noSetPostEmp() {
        return "emp/noSetPostEmp";
    }

    @RequestMapping(value = "/noSetPostEmpCount", method = RequestMethod.GET)
    @ResponseBody
    public Object noSetPostEmpCount() {
        int count = staffingEmpService.selectNoSetPostCount(getEnterpriseId());
        return count;
    }


    @RequestMapping(value = "/noSetPostEmpTable", method = RequestMethod.GET)
    @ResponseBody
    public Object noSetPostEmpTable() {
        List<StaffingEmp> staffingEmps = staffingEmpService.selectNoSetPostEmps(getEnterpriseId());
        Map<String, Object> result = new HashMap<>();
        result.put("rows", staffingEmps);
        result.put("total", staffingEmps.size());
        return result;
    }


    /**
     * 根据员工Id获取下属员工
     *
     * @param empId
     * @return
     */
    @RequestMapping(value = "/lowerEmp", method = RequestMethod.GET)
    @ResponseBody
    public Object lowerEmp(Long empId) {
        Map<String, Object> result = new HashMap<>();
        if (empId == null) {
            return result;
        }
        //查询员工的岗位
        List<Object> postIds = staffingPostEmpService.selectObjs(
                new EntityWrapper<StaffingPostEmp>()
                        .eq("empId", empId).eq("enterpriseId", getEnterpriseId()).setSqlSelect("postId"));
        if (postIds.size() == 0) {
            return result;
        }
        //查询岗位的下属岗位
        List<Object> postLowerIds = multiplescorePostRangeService.selectObjs(
                new EntityWrapper<MultiplescorePostRange>()
                        .in("postHigherId", postIds)
                        .eq("enterpriseId", getEnterpriseId()).setSqlSelect("postLowerId"));
        if (postLowerIds.size() == 0) {
            return result;
        }
        //查询岗位的员工
        List<Object> empIds = staffingPostEmpService.selectObjs(
                new EntityWrapper<StaffingPostEmp>()
                        .in("postId", postLowerIds)
                        .eq("enterpriseId", getEnterpriseId())
                        .setSqlSelect("empId"));
        if (empIds.size() == 0) {
            return result;
        }
        List<StaffingEmp> staffingEmps = staffingEmpService.selectList(new EntityWrapper<StaffingEmp>()
                .in("empId", empIds)
                .eq("empStatus", 1));//只查询在职的员工

        result.put("rows", staffingEmps);
        result.put("total", staffingEmps.size());
        return result;
    }

}
