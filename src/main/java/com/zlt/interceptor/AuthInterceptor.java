package com.zlt.interceptor;

import com.zlt.pojo.AuthUser;
import com.zlt.pojo.AuthUserFunctionModel;
import org.omg.CORBA.MARSHAL;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * 实现用户登录访问的控制
 * 1.如果用户没有登录，要去访问后台地址，则拦截用户的请求
 * 2.如果用户登录，且session里面有用户的记录，则放行
 * @author shushu
 * @date 2019-09-01-22:45
 */

public class AuthInterceptor extends HandlerInterceptorAdapter{

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session=request.getSession();
        //得到存储在session对象里面的用户信息+权限信息
        AuthUserFunctionModel model= (AuthUserFunctionModel) session.getAttribute("authUserFunctionModel");
        //model为空，没有权限,重新登录
        if (model==null){
            response.sendRedirect("/index.jsp");
            return false;
        }
        //取用户信息
        AuthUser aUser=model.getAuthUser();
        if (aUser==null){
            response.sendRedirect("/index.jsp");
            return false;
        }
        //取权限信息
        //权限信息没有不是代表没有登录，可能是系统没有给用户设置访问权限
        List<Map<String,Object>> listFunction=model.getAuthFunction();

        //获取用户的请求地址（接口地址）
        String requestURI = request.getRequestURI();

        //比较求地址和存储在数据库中权限地址是否一致
        boolean access=false;
        for (Map<String,Object> map:listFunction){
            if(requestURI.indexOf(map.get("url").toString())>=0){
                access=true;
                break;
            }
        }
        //没有权限，阻止访问后台界面
        if (!access){
            request.getRequestDispatcher("/WEB-INF/pages/404.jsp").forward(request,response);
            return access;
        }
        return access;
    }
}
