package com.zlt.service;

import com.zlt.pojo.User;

/**
 * @author shushu
 * @date 2019-09-03-15:29
 */

public interface LoginService {
    User findByUsername(String username);
}
