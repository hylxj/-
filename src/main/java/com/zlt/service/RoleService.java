package com.zlt.service;

import com.github.pagehelper.PageInfo;
import com.zlt.pojo.ResultData;
import com.zlt.pojo.Role;
import com.zlt.pojo.User;

import java.util.List;

/**
 * @author huangyu
 * @date 2019-09-08-12:53
 */

public interface RoleService {
    PageInfo<Role> findAllRole(Integer page, Integer limit);

    void updateRole(Role role);

    PageInfo<Role> searchAllRole(Integer page, Integer limit, String key);

    void deleteByRoleId(Integer roleId);

    Role findRoleById(Integer roleId);

    void roleEdit(Role role);

    void roleAdd(Role role);

    List<User> findUserByRoleId(Integer roleId);

    void deleteUserByRoleId(Integer roleId, Integer userId);

    void insertRoleUser(Integer roleId, Integer userId);
}
