package com.zlt.dao;

import com.zlt.pojo.User;

/**
 * @author shushu
 * @date 2019-09-03-15:39
 */

public interface LoginDao {
    User findByUsername(String username);
}
