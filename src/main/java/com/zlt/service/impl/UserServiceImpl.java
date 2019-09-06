package com.zlt.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zlt.dao.UserDao;
import com.zlt.pojo.BusCen;
import com.zlt.pojo.ResultData;
import com.zlt.pojo.ResultTable;
import com.zlt.pojo.User;
import com.zlt.service.UserService;
import com.zlt.utils.PasswordUtil;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author shushu
 * @date 2019-09-03-22:22
 */
@Service
public class UserServiceImpl implements UserService{
    @Autowired
    private UserDao userDao;

    @Override
    public User findByUsername(String username) {
        User user = userDao.findByUsername(username);
        return user;
    }

    @Override
    public PageInfo<User> findAllUser(Integer page, Integer pageSize) {
        PageHelper.startPage(page,pageSize);
        List<User> users = userDao.findAllUser();
        return new PageInfo<>(users);
    }

    @Override
    public ResultTable searchUserList(String key) {
        char[] chars = key.toCharArray();
        String username="%";
        for (char c:chars){
            username+=c+"%";
        }
        List<User> users=userDao.searchUserList(username);
        if (users==null){
            return new ResultTable(3001,"查询失败，无数据");
        }
        return new ResultTable(0,"查询成功",users.size(),users);
    }

    @Override
    public List<BusCen> findAllBusCenName() {
        return userDao.findAllBusCenName();
    }

    @Override
    public void userAdd(User user)throws DataAccessException {
        userDao.insertUser(user);
    }

    @Override
    public User findAllById(Integer id) {
        return userDao.findAllById(id);
    }

    @Override
    public void userEdit(User user) {
        userDao.userEdit(user);
    }

    @Override
    public void delUser(Integer id) {
        userDao.delUser(id);
    }

    @Override
    public void batchDelUser(Long[] userId) {
        userDao.batchDelUser(userId);
    }

    @Override
    public void updateLocked(Integer id, Integer isLocked) {
        userDao.updateLocked(id,isLocked);
    }

    @Override
    public ResultData verifyOldPwd(String username,String password) {
        User user=userDao.findByUsername(username);
        if (user.getPassword().equals(PasswordUtil.getMd5Passwword(password,user.getSalt()))){
            return new ResultData(5001,"旧密码错误");
        }
        return new ResultData(200,"密码正确");
    }

    @Override
    public void updatePwd(String username, String password) {
        User user=userDao.findByUsername(username);
        String newPwd = PasswordUtil.getMd5Passwword(password, user.getSalt());//新密码
        userDao.changePwd(username,newPwd);
    }
}
