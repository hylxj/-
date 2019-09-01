package com.zlt.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
}

