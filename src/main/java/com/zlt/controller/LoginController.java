package com.zlt.controller;

import cn.hutool.crypto.SecureUtil;
import com.zlt.pojo.AuthUser;
import com.zlt.pojo.AuthUserFunctionModel;
import com.zlt.pojo.ResultData;
import com.zlt.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * @author shushu
 * @date 2019-08-30-16:42
 */
@Controller
public class LoginController {
    @Autowired
    LoginService loginService;

    @RequestMapping("/login")
    @ResponseBody
    public ResultData login(AuthUser authUser, HttpSession session){
        //密码加密后存入对象中
        authUser.setPassword(SecureUtil.md5(authUser.getPassword()));
        //调用service方法完成登录验证
        ResultData resultData = loginService.login(authUser);
        if (resultData.getCode()==200){
            /**
             * 获取用户的权限信息
             * 把AuthUser+Function-起绑定到权限的模型里面
             * 权限的模型放入到Session里面
             */
            //查询用户对应的权限
            List<Map<String,Object>> listFunction=loginService.getAuthUserFunction(authUser);
            //把查出来的用户信息和对应的权限信息放入模型中
            AuthUserFunctionModel authUserFunctionModel=new AuthUserFunctionModel((AuthUser) resultData.getData(),listFunction);
            session.setAttribute("authUserFunctionModel",authUserFunctionModel);
        }
        return resultData;
    }
}
