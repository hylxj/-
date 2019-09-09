package com.zlt.controller;

import com.zlt.pojo.Role;
import com.zlt.pojo.User;
import com.zlt.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * @author shushu
 * @date 2019-09-01-12:22
 */
@Controller
public class IndexController {
    @Autowired
    private UserService userService;

    @RequestMapping("/mainPage")
    public String mainPage(String username, Model model){
        model.addAttribute("username",username);
        return "main";
    }

    @RequestMapping("/index")
    public String  indexPage(String username, Model model){
        User user = userService.findByUsername(username);
        List<Role> roles=userService.findRolesByUserId(user.getId());
        model.addAttribute("roles",roles);
        model.addAttribute("user",user);
        return "index";
    }
    @RequestMapping("/unauthorizedPage")
    public String errorPage(){
        return "unauthorized";
    }
}

