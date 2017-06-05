package top.youchangxu.core.interceptor;

import org.apache.commons.lang.ObjectUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import top.youchangxu.common.utils.RequestUtil;
import top.youchangxu.model.system.StaffingLog;
import top.youchangxu.service.system.IStaffingLogServicce;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;

/**
 * 日志记录AOP实现
 * Created by ZhangShuzheng on 2017/3/14.
 */
@Aspect
public class LogAspect {

    private static Logger _log = LoggerFactory.getLogger(LogAspect.class);

    // 开始时间
    private long startTime = 0L;
    // 结束时间
    private long endTime = 0L;

    @Autowired
    IStaffingLogServicce staffingLogServicce;

    @Before("execution(* *..controller..*.*(..))")
    public void doBeforeInServiceLayer(JoinPoint joinPoint) {
        _log.debug("doBeforeInServiceLayer");
        startTime = System.currentTimeMillis();
    }

    @After("execution(* *..controller..*.*(..))")
    public void doAfterInServiceLayer(JoinPoint joinPoint) {
        _log.debug("doAfterInServiceLayer");
    }

    @Around("execution(* *..controller..*.*(..))")
    public Object doAround(ProceedingJoinPoint pjp) throws Throwable {
        // 获取request
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) requestAttributes;
        HttpServletRequest request = servletRequestAttributes.getRequest();

        StaffingLog staffingLog = new StaffingLog();
        // 从注解中获取操作名称、获取响应结果
        Object result = pjp.proceed();
        Signature signature = pjp.getSignature();
        MethodSignature methodSignature = (MethodSignature) signature;
        Method method = methodSignature.getMethod();
//		if (method.isAnnotationPresent(ApiOperation.class)) {
//			ApiOperation log = method.getAnnotation(ApiOperation.class);
//			upmsLog.setDescription(log.value());
//		}
        if (method.isAnnotationPresent(RequiresPermissions.class)) {
            RequiresPermissions requiresPermissions = method.getAnnotation(RequiresPermissions.class);
            String[] permissions = requiresPermissions.value();
            if (permissions.length > 0) {
                staffingLog.setPermissions(permissions[0]);
            }
        }
        endTime = System.currentTimeMillis();
        _log.debug("doAround>>>result={},耗时：{}", result, endTime - startTime);

        staffingLog.setBasePath(RequestUtil.getBasePath(request));
        staffingLog.setIp(RequestUtil.getIpAddr(request));
        staffingLog.setMethod(request.getMethod());
        if (request.getMethod().equalsIgnoreCase("GET")) {
            staffingLog.setParameter(request.getQueryString());
        } else {
            staffingLog.setParameter(ObjectUtils.toString(request.getParameterMap()));
        }
        staffingLog.setResult(ObjectUtils.toString(result));
        staffingLog.setSpendTime((int) (endTime - startTime));
        staffingLog.setStartTime(startTime);
        staffingLog.setUri(request.getRequestURI());
        staffingLog.setUrl(ObjectUtils.toString(request.getRequestURL()));
        staffingLog.setUserAgent(request.getHeader("User-Agent"));
        staffingLog.setUsername(ObjectUtils.toString(request.getUserPrincipal()));
        staffingLogServicce.insert(staffingLog);
        return result;
    }

}
