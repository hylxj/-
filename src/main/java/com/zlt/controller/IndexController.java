package com.zlt.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author shushu
 * @date 2019-09-01-12:22
 */
@Controller
public class IndexController {

    @RequestMapping("/mainPage")
    public String mainPage(String username, Model model){
        model.addAttribute("username",username);
        return "main";
    }

    @RequestMapping("/index")
    public String  indexPage(String username, Model model){
        model.addAttribute("username",username);
        return "index";
    }
    @RequestMapping("/errorPage")
    public String errorPage(){
        return "404";
    }
}

