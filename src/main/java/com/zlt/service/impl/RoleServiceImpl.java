package com.zlt.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zlt.dao.RoleDao;
import com.zlt.pojo.ResultData;
import com.zlt.pojo.Role;
import com.zlt.pojo.User;
import com.zlt.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author shushu
 * @date 2019-09-08-12:54
 */
@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    private RoleDao roleDao;

    @Override
    public PageInfo<Role> findAllRole(Integer page, Integer limit) {
        PageHelper.startPage(page,limit);
        List<Role> roles = roleDao.findAllRole();
        return new PageInfo<Role>(roles);
    }

    @Override
    public void updateRole(Role role) throws DataAccessException {
        roleDao.updateRole(role);
    }

    @Override
    public PageInfo<Role> searchAllRole(Integer page, Integer limit, String key) {
        char[] chars = key.toCharArray();
        String roleName="%";
        for (char c:chars){
            roleName+=c+"%";
        }
        PageHelper.startPage(page,limit);
        List<Role> roles = roleDao.searchAllRole(roleName);
        return new PageInfo<Role>(roles);
    }

    @Override
    public void deleteByRoleId(Integer roleId) {
        roleDao.deleteByRoleId(roleId);
    }

    @Override
    public Role findRoleById(Integer roleId) {
        return roleDao.findRoleById(roleId);
    }

    @Override
    public void roleEdit(Role role) throws DataAccessException {
        roleDao.updateRole(role);
    }

    @Override
    public void roleAdd(Role role) {
        roleDao.insertRole(role);
    }

    @Override
    public List<User> findUserByRoleId(Integer roleId) {
        return roleDao.findUserByRoleId(roleId);
    }

    @Override
    public void deleteUserByRoleId(Integer roleId, Integer userId) {
        roleDao.deleteUserByRoleId(roleId,userId);
    }

    @Override
    public void insertRoleUser(Integer roleId, Integer userId) {
        roleDao.insertRoleUser(roleId,userId);
    }
}
