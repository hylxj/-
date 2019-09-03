package com.zlt.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author shushu
 * @date 2019-09-01-12:22
 */
@Controller
public class IndexController {

    @RequestMapping("/mainPage")
    public String mainPage(){
        return "main";
    }

    @RequestMapping("/news/newsListPage")
    public String newListPage(){
        return "news/newsList";
    }

    @RequestMapping("/index")
    public String  indexPage(){
        return "index";
    }
    @RequestMapping("/errorPage")
    public String errorPage(){
        return "404";
    }
}

