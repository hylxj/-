package com.zlt.service.impl;

import com.zlt.dao.AuthDao;
import com.zlt.dao.LoginDao;
import com.zlt.pojo.AuthUser;
import com.zlt.pojo.ResultData;
import com.zlt.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author shushu
 * @date 2019-09-02-9:11
 */
@Service
public class LoginServiceImpl implements LoginService {
    @Autowired
    private LoginDao loginDao;
    @Autowired
    private AuthDao authDao;

    /**
     * 登录操作
     * @param authUser
     * @return
     */
    @Override
    public ResultData login(AuthUser authUser) {
        //根据对象的信息取出数据库的信息比对
        AuthUser aUser = loginDao.findPwdByName(authUser);
        if (aUser==null){
            return new ResultData(1001,"用户名称错误或不存在");
        }
        if (authUser.getPassword().equals(aUser.getPassword())){
            return new ResultData(200,"登录成功",aUser);
        }else {
            return new ResultData(1002,"密码错误");
        }
    }

    /**
     * 根据用户信息查询对应权限
     * @param authUser
     * @return
     */
    @Override
    public List<Map<String, Object>> getAuthUserFunction(AuthUser authUser) {
        List<Map<String, Object>> listFunction = authDao.getAuthUserFunction(authUser);
        return listFunction;
    }
}
