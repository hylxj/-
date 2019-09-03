package com.zlt.service;

import com.zlt.pojo.AuthUser;
import com.zlt.pojo.ResultData;

import java.util.List;
import java.util.Map;

/**
 * @author shushu
 * @date 2019-09-02-9:08
 */

public interface LoginService {
    /**
     * 登录操作
     * @return
     */
    ResultData login(AuthUser authUser);

    /**
     * 根据用户信息查询对应权限
     * @param authUser
     * @return
     */
    List<Map<String, Object>> getAuthUserFunction(AuthUser authUser);
}
