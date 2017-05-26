package top.youchangxu.core.shiro;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.web.filter.PathMatchingFilter;
import org.springframework.beans.factory.annotation.Autowired;
import top.youchangxu.common.Constants;
import top.youchangxu.model.system.StaffingEmp;
import top.youchangxu.service.system.IStaffingEmpService;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 * Created by dtkj_android on 2017/5/26.
 */
public class StaffingEmpFilter extends PathMatchingFilter {

    @Autowired
    private IStaffingEmpService staffingEmpService;
    @Override
    protected boolean preHandle(ServletRequest request, ServletResponse response) throws Exception {
        String username = (String) SecurityUtils.getSubject().getPrincipal();
        request.setAttribute(Constants.CURRENT_USER, staffingEmpService.selectOne(new EntityWrapper<StaffingEmp>().eq("username",username)));
        return true;
    }
}
