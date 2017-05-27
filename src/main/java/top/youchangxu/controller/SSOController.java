package top.youchangxu.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by dtkj_android on 2017/5/26.
 */
@Controller
@RequestMapping("/sso")
public class SSOController extends BaseController {

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        SecurityUtils.getSubject().logout();
        String redirectUrl = request.getHeader("Referer");
        if (null == redirectUrl) {
            redirectUrl = "/sso/login";
        }
        return "redirect:" + redirectUrl;
    }

    @RequestMapping("/login")
    public String login(HttpServletRequest request) {
//        Subject subject = SecurityUtils.getSubject();
//        String username = (String) subject.getPrincipal();
//        if(username!=null){
//            return "/index";
//        }
        return "/sso/login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public Object login(String username, String password) {
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken usernamePasswordToken = new UsernamePasswordToken(username, password);
        try {
            subject.login(usernamePasswordToken);
        } catch (UnknownAccountException e) {
            return renderError("账号不存在");
        } catch (IncorrectCredentialsException e) {
            return renderError("密码错误");
        } catch (ExcessiveAttemptsException e){
            return renderError("重试次数过多,请10分钟再试");
        } catch (Exception e){
            return renderError("服务器错误");
        }
        return renderSuccess("/index");
    }
}
