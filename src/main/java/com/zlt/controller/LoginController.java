package com.zlt.controller;

import com.zlt.pojo.ResultData;
import com.zlt.service.UserService;
import com.zlt.utils.VerifyCodeUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;

/**
 * @Description: 登陆页面
 * @Param:
 * @Return:
 * @Author: huangyu
 * @Date: 2020/3/7
**/
@Controller
@RequestMapping("/shiro")
public class LoginController {
    private final UserService userService;

    public LoginController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping("/login")
    @ResponseBody
    public ResultData login(String username, String password,String verifyCode) {
        //获取当前的用户
        Subject currentUser = SecurityUtils.getSubject();
        String vCode = (String) currentUser.getSession().getAttribute("verifyCode");
        if (!vCode.equalsIgnoreCase(verifyCode)){
            return new ResultData(1003,"验证码不正确，请重新输入");
        }
        //验证用户是否登录
        if (!currentUser.isAuthenticated()) {
            //把用户名和密码封装为UsernamePasswordToken对象
            UsernamePasswordToken token = new UsernamePasswordToken(username, password);
            //rememberMe
            token.setRememberMe(true);
            try {
                //执行登录
                currentUser.login(token);
                Session session=currentUser.getSession();
                session.setAttribute("sessionUser",userService.findByUsername(token.getUsername()));
            }catch (AuthenticationException ae) {//所有以上异常的父类
                return new ResultData(1002, "用户名或者密码错误，登录失败");
            }
        }
        return new ResultData(200, username);
    }

    /**
     * 获取验证码
     *
     * @param response
     */
    @RequestMapping(value = "/getVCode", method = RequestMethod.GET)
    public void getVCode(HttpServletResponse response) {
        try {
            response.setHeader("Pragma", "No-cache");
            response.setHeader("Cache-Control", "no-cache");
            response.setDateHeader("Expires", 0);
            response.setContentType("image/jpg");
            //生成随机验证码
            String verifyCode = VerifyCodeUtils.generateVerifyCode(4);
            SecurityUtils.getSubject().getSession().setAttribute("verifyCode", verifyCode);
            //生成图片
            int w = 146, h = 33;
            VerifyCodeUtils.outputImage(w, h, response.getOutputStream(), verifyCode);
        } catch (Exception e) {
            System.out.println("获取验证码异常：" + e.getMessage());
        }
    }
}
