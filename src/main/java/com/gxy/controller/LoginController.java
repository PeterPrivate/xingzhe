package com.gxy.controller;

import com.gxy.common.MsgResponse;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by guanxy on 2017/11/14.
 */
@Controller
public class LoginController {

    @GetMapping("/login")
    public String login(){
        if (SecurityUtils.getSubject().isAuthenticated()){
            return "index";
        }
        return "login";
    }


    @GetMapping("/index")
    public String index(){
        if (SecurityUtils.getSubject().isAuthenticated()){
            return "index";
        }
        return "login";
    }

    @PostMapping("login")
    @ResponseBody
    public MsgResponse login(String username, String password){
        Subject subject = SecurityUtils.getSubject();
        try {
            UsernamePasswordToken token = new UsernamePasswordToken(username, password);
            token.setRememberMe(true);  //记住我，必须使用user过滤器（登录或者记住我），不能使用authc（必须登录）
            subject.login(token);
        }catch (UnknownAccountException e1){
            throw new UnknownAccountException("用户名不存在");
        }catch (IncorrectCredentialsException e2){
            throw new IncorrectCredentialsException("密码错误");
        }
        return new MsgResponse(true);
    }
}
