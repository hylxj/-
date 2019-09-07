package com.zlt.shiro.factory;

import java.util.LinkedHashMap;

/**
 * @author shushu
 * @date 2019-09-03-10:48
 */

public class FilterChainDefinitionMapBuilder {
    public LinkedHashMap<String,String> buildFilterChainDefinitionMap(){
        LinkedHashMap<String,String> map=new LinkedHashMap<>();
        map.put("/index.jsp","anon");
        map.put("/shiro/login","anon");
        map.put("/shiro/getVCode","anon");
        map.put("/shiro/logout","logout");

        map.put("/user.jsp","authc,roles[user]");
        map.put("/admin.jsp","authc,roles[admin]");
        map.put("/list.jsp","user");

//        map.put("/**","authc");
        return map;
    }
}
