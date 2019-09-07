package com.zlt.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zlt.dao.UserDao;
import com.zlt.pojo.*;
import com.zlt.service.UserService;
import com.zlt.utils.PasswordUtil;
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

    /**
     * 分页显示用户列表
     * @param page
     * @param pageSize
     * @return
     */
    @Override
    public PageInfo<User> findAllUser(Integer page, Integer pageSize) {
        PageHelper.startPage(page,pageSize);
        List<User> users = userDao.findAllUser();
        return new PageInfo<>(users);
    }

    /**
     * 根据用户名模糊搜索
     * @param key
     * @return
     */
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

    /**
     * 添加用户
     * @param user
     * @throws DataAccessException
     */
    @Override
    public void userAdd(User user)throws DataAccessException {
        user.setSalt(user.getUsername());
        user.setPassword(PasswordUtil.getMd5Passwword(user.getPassword(),user.getSalt()));//密码加密后存储
        userDao.insertUser(user);
    }

    @Override
    public User findAllById(Integer id) {
        return userDao.findAllById(id);
    }

    /**
     * 用户编辑
     * @param user
     */
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

    /**
     * 更新锁定状态
     * @param id
     * @param isLocked
     */
    @Override
    public void updateLocked(Integer id, Integer isLocked) {
        userDao.updateLocked(id,isLocked);
    }

    /**
     * 验证旧密码
     * @param username
     * @param password
     * @return
     */
    @Override
    public ResultData verifyOldPwd(String username,String password) {
        User user=userDao.findByUsername(username);
        if (!user.getPassword().equals(PasswordUtil.getMd5Passwword(password,user.getSalt()))){
            return new ResultData(5001,"旧密码错误");
        }
        return new ResultData(200,"密码正确");
    }

    /**
     * 更新密码
     * @param username
     * @param password
     */
    @Override
    public void updatePwd(String username, String password) {
        User user=userDao.findByUsername(username);
        String newPwd = PasswordUtil.getMd5Passwword(password, user.getSalt());//新密码
        userDao.changePwd(username,newPwd);
    }

    @Override
    public void saveIcon(Integer id, String filename) {
        userDao.saveIcon(id,filename);
    }

    @Override
    public List<Role> findRolesByUserId(Integer id) {
        return userDao.findRolesByUserId(id);
    }
}
