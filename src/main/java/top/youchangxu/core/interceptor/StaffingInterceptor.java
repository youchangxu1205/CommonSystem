package top.youchangxu.core.interceptor;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import top.youchangxu.model.system.StaffingEmp;
import top.youchangxu.service.system.IStaffingEmpService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 登录信息拦截器
 * Created by shuzheng on 2017/2/11.
 */
public class StaffingInterceptor extends HandlerInterceptorAdapter {

    private static Logger _log = LoggerFactory.getLogger(StaffingInterceptor.class);

    @Autowired
    IStaffingEmpService staffingEmpService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 过滤ajax
        if (null != request.getHeader("X-Requested-With") && request.getHeader("X-Requested-With").equalsIgnoreCase("XMLHttpRequest")) {
            return true;
        }
        // 登录信息
        Subject subject = SecurityUtils.getSubject();
        String principal = (String) subject.getPrincipal();
        if (principal != null) {
            String[] split = principal.split("#");
            StaffingEmp staffingEmp = staffingEmpService.selectOne(new EntityWrapper<StaffingEmp>().eq("username", split[1]));
            request.setAttribute("staffingEmp", staffingEmp);
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        super.postHandle(request, response, handler, modelAndView);
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        super.afterCompletion(request, response, handler, ex);
    }

    @Override
    public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        super.afterConcurrentHandlingStarted(request, response, handler);
    }

}
