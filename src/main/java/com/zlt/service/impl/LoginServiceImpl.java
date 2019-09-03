package com.zlt.service.impl;

import com.zlt.dao.LoginDao;
import com.zlt.pojo.User;
import com.zlt.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author shushu
 * @date 2019-09-03-15:29
 */
@Service
public class LoginServiceImpl implements LoginService {
    @Autowired
    private LoginDao loginDao;
    @Override
    public User findByUsername(String username) {
        User user = loginDao.findByUsername(username);
        return user;
    }
}
