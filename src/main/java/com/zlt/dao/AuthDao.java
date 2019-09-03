package com.zlt.dao;

import com.zlt.pojo.AuthUser;

import java.util.List;
import java.util.Map;

/**
 * @author shushu
 * @date 2019-09-01-23:50
 */

public interface AuthDao {
    /**
     * 根据用户信息查询对应权限
     * @param authUser
     * @return
     */
    List<Map<String, Object>> getAuthUserFunction(AuthUser authUser);
}
