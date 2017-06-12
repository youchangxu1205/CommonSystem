package top.youchangxu.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import top.youchangxu.common.result.JsonResult;
import top.youchangxu.common.result.ResultEnum;
import top.youchangxu.model.system.StaffingOrg;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Author: D.Yang
 * Email: koyangslash@gmail.com
 * Date: 16/10/9
 * Time: 下午1:37
 * Describe: 基础控制器
 */
public class BaseController {
    /**
     * 渲染失败数据
     *
     * @return result
     */
    protected JsonResult renderError() {
        JsonResult result = new JsonResult();
        result.setSuccess(false);
        result.setStatus("500");
        return result;
    }

    /**
     * 获取企业编号
     *
     * @return
     */
    protected String getEnterpriseId() {
        Subject subject = SecurityUtils.getSubject();
        String principal = (String) subject.getPrincipal();
        String[] strings = principal.split("#");
        String enterpriseId = strings[0];
        return enterpriseId;
    }

    /**
     * 获取用户名
     *
     * @return
     */
    protected String getEmpId() {
        Subject subject = SecurityUtils.getSubject();
        String principal = (String) subject.getPrincipal();
        String[] strings = principal.split("#");
        String username = strings[1];
        return username;
    }

    /**
     * 渲染失败数据（带消息）
     *
     * @return result
     */
    protected JsonResult renderError(ResultEnum resultEnum) {
        JsonResult result = renderError();
        result.setMsg(resultEnum.getMsg());
        return result;
    }

//    protected List<StaffingOrg> getCookiesOrg(HttpServletRequest request) {
//        Cookie[] cookies = request.getCookies();
//        if (cookies == null) {
//            return null;
//        } else {
//            for (Cookie cookie :
//                    cookies) {
//                String name = cookie.getName();
//            }
//        }
//    }

    /**
     * 渲染失败数据（带消息）
     *
     * @return result
     */
    protected JsonResult renderError(String msg) {
        JsonResult result = renderError();
        result.setMsg(msg);
        return result;
    }

    /**
     * 渲染成功数据
     *
     * @return result
     */
    protected JsonResult renderSuccess() {
        JsonResult result = new JsonResult();
        result.setSuccess(true);
        result.setStatus("200");
        return result;
    }

    /**
     * 渲染成功数据（带信息）
     *
     * @param msg 需要返回的信息
     * @return result
     */
    protected JsonResult renderSuccess(String msg) {
        JsonResult result = renderSuccess();
        result.setMsg(msg);
        return result;
    }

    /**
     * 渲染成功数据（带信息）
     * <p>
     * x     * @return result
     */
    protected JsonResult renderSuccess(ResultEnum resultEnum) {
        JsonResult result = renderSuccess();
        result.setMsg(resultEnum.getMsg());
        return result;
    }

    /**
     * 渲染成功数据（带数据）
     *
     * @param obj 需要返回的对象
     * @return result
     */
    protected JsonResult renderSuccess(Object obj) {
        JsonResult result = renderSuccess();
        result.setObj(obj);
        return result;
    }
}
