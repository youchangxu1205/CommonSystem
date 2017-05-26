package top.youchangxu.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import top.youchangxu.common.service.system.IStaffingEmpService;

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
    @RequestMapping
    public Object login(String username,String password){
        return null;
    }
}
