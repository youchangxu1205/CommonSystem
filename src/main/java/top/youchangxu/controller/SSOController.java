package top.youchangxu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by dtkj_android on 2017/5/26.
 */
@Controller
@RequestMapping("/sso")
public class SSOController extends BaseController {


    @RequestMapping("/logout")
    public String logout() {

        return "/sso/login";
    }
    @RequestMapping("/login")
    public Object login(String username,String password){


        return null;
    }
}
