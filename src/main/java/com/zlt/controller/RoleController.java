package com.zlt.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author shushu
 * @date 2019-09-02-16:15
 */
@Controller
@RequestMapping("/role")
public class RoleController {
    @RequestMapping("/query")
    public String query(){
        return "";
    }
}
