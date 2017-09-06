package top.youchangxu.controller;

import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import top.youchangxu.common.result.ResultEnum;
import top.youchangxu.model.system.StaffingEnterprise;
import top.youchangxu.service.system.IStaffingEnterprisePermissionService;
import top.youchangxu.service.system.IStaffingEnterpriseService;

import javax.servlet.http.HttpServletRequest;
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
    private IStaffingEnterprisePermissionService staffingEnterprisePermissionService;

    @Autowired
    public EnterpriseController(IStaffingEnterpriseService staffingEnterpriseService,
                                IStaffingEnterprisePermissionService staffingEnterprisePermissionService) {
        this.staffingEnterpriseService = staffingEnterpriseService;
        this.staffingEnterprisePermissionService = staffingEnterprisePermissionService;
    }

    /**
     * 企业首页
     *
     * @return
     */
    @RequestMapping(value = "/index")
    @RequiresPermissions("staffing:enterprise:read")
    public String index() {
        return "/enterprise/index";
    }

    /**
     * 企业列表
     *
     * @param limit
     * @param offset
     * @param sort
     * @param order
     * @param staffingEnterprise
     * @return
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @RequiresPermissions("staffing:enterprise:read")
    @ResponseBody
    public Object list(int limit, int offset, String sort, String order, StaffingEnterprise staffingEnterprise) {

        EntityWrapper<StaffingEnterprise> enterpriseEntityWrapper = new EntityWrapper<>();
        Page<StaffingEnterprise> staffingEnterprisePage = new Page<>(offset / limit + 1, limit, sort);
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

    /**
     * 创建企业
     *
     * @return
     */
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    @RequiresPermissions("staffing:enterprise:create")
    public String create() {
        return "/enterprise/create";
    }

    /**
     * 创建企业
     *
     * @param staffingEnterprise
     * @return
     */
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @RequiresPermissions("staffing:enterprise:create")
    @ResponseBody
    public Object create(StaffingEnterprise staffingEnterprise) {
        boolean insert = staffingEnterpriseService.saveEnterprise(staffingEnterprise);

        return insert ? renderSuccess("添加成功") : renderError(ResultEnum.INSERT_ERROR);
    }

    /**
     * 更新企业信息
     *
     * @param enterpriseId
     * @param model
     * @return
     */
    @RequiresPermissions("staffing:enterprise:update")
    @RequestMapping(value = "/update/{enterpriseId}", method = RequestMethod.GET)
    public String update(@PathVariable("enterpriseId") Long enterpriseId, Model model) {
        StaffingEnterprise staffingEnterprise = staffingEnterpriseService.selectById(enterpriseId);
        model.addAttribute("staffingEnterprise", staffingEnterprise);
        return "/enterprise/update";
    }

    /**
     * 更新企业信息
     *
     * @param staffingEnterprise
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @RequiresPermissions("staffing:enterprise:update")
    @ResponseBody
    public Object update(StaffingEnterprise staffingEnterprise) {
        return staffingEnterpriseService.updateById(staffingEnterprise) ? renderSuccess("修改成功") : renderError(ResultEnum.UPDATE_ERROR);
    }

    /**
     * 删除企业
     *
     * @param ids
     * @return
     */
    @RequestMapping(value = "/delete/{ids}", method = RequestMethod.POST)
    @ResponseBody
    public Object delete(@PathVariable("ids") String ids) {
        return staffingEnterpriseService.deleteBatchIds(Arrays.asList(ids.split("-"))) ? renderSuccess("删除成功") : renderError(ResultEnum.DELETE_ERROR);
    }

    @RequestMapping(value = "/permission/{enterpriseId}", method = RequestMethod.GET)
    public String permission(@PathVariable String enterpriseId, ModelMap modelMap){
        //查询企业已有的权限信息

        return "/enterprise/permission";
    }


    @RequestMapping(value = "/permission/{enterpriseId}", method = RequestMethod.POST)
    @ResponseBody
    public Object updatePermission(@PathVariable("enterpriseId") Long enterpriseId, HttpServletRequest request) {
        JSONArray datas = JSONArray.parseArray(request.getParameter("datas"));
        int result = staffingEnterprisePermissionService.updateEnterprisePermission(datas, enterpriseId);
        return renderSuccess(ResultEnum.UPDATE_SUCCESS);
    }
}
