package com.zlt.dao;

import com.zlt.pojo.Role;
import com.zlt.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author shushu
 * @date 2019-09-08-12:55
 */

public interface RoleDao {
    List<Role> findAllRole();

    List<Role> searchAllRole(String roleName);

    void deleteByRoleId(Integer roleId);

    void insertRole(Role role);

    void updateRole(Role role);

    Role findRoleById(Integer roleId);

    List<User> findUserByRoleId(Integer roleId);

    void deleteUserByRoleId(@Param("roleId") Integer roleId,@Param("userId") Integer userId);

    void insertRoleUser(@Param("roleId") Integer roleId,@Param("userId") Integer userId);
}
