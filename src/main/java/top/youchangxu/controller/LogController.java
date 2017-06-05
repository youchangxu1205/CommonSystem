package top.youchangxu.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import top.youchangxu.model.system.StaffingLog;
import top.youchangxu.service.system.IStaffingLogServicce;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by dtkj_android on 2017/6/5.
 */
@Controller
@RequestMapping("/log")
public class LogController extends BaseController {
    private IStaffingLogServicce staffingLogServicce;

    @Autowired
    public LogController(IStaffingLogServicce staffingLogServicce) {
        this.staffingLogServicce = staffingLogServicce;
    }

    @RequestMapping(value = "/index")
    public String index() {
        return "/log/index";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(int limit, int offset, String sort, String order, StaffingLog staffingLog) {

        EntityWrapper<StaffingLog> permissionEntityWrapper = new EntityWrapper<>();
        Page<StaffingLog> staffingLogPage = new Page<>(offset / limit + 1, limit, sort);
        staffingLogPage.setAsc(order.equals("asc"));
        staffingLogPage = staffingLogServicce.selectPage(
                staffingLogPage,
                permissionEntityWrapper);
        List<StaffingLog> rows = staffingLogPage.getRecords();
        Map<String, Object> result = new HashMap<>();
        result.put("rows", rows);
        result.put("total", staffingLogPage.getTotal());
        return result;
    }
}
