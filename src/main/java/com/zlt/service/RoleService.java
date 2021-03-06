package com.zlt.service;

import com.github.pagehelper.PageInfo;
import com.zlt.pojo.Menu;
import com.zlt.pojo.ResultData;
import com.zlt.pojo.Role;
import com.zlt.pojo.User;

import java.util.List;
import java.util.Map;

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

    List<Role> findUserByRoleId(Integer roleId);

    void deleteUserByRoleId(Integer userId, Integer roleId);

    void insertRoleUser(Integer roleId, Integer userId);

    PageInfo<Menu> findMeanByRoleId(Integer page, Integer limit,Integer id);

    void insertRoleMean(Integer roleId, Integer meunId);

    void deleteMeanByRoleId(Integer roleId, Integer menuId);
}
