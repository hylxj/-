package com.zlt.dao;

import com.zlt.pojo.AuthUser;

import java.util.List;
import java.util.Map;

/**
 * @author shushu
 * @date 2019-09-02-9:08
 */

public interface LoginDao {
    /**
     * 根据用户名查找密码
     * @return
     */
    AuthUser findPwdByName(AuthUser authUser);


}
