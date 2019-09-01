package com.zlt.controller;

import com.zlt.pojo.ResultData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author shushu
 * @date 2019-08-30-16:42
 */
@Controller
public class LoginController {
    @RequestMapping("/login")
    @ResponseBody
    public ResultData login(String username, String userpassword){
        System.out.println(username+"=="+userpassword);
        ResultData resultData=null;
        if ("admin".equals(username)&&"123".equals(userpassword)) {
            resultData= new ResultData(200,"login success");
        }
        return resultData;
    }
    @RequestMapping("/index")
    public String indexPage(){
        return "";
    }
}
