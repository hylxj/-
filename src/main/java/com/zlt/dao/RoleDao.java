package com.zlt.dao;

import com.zlt.pojo.Menu;
import com.zlt.pojo.Role;
import com.zlt.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author huangyu
 * @date 2019-09-08-12:55
 */

public interface RoleDao {
    List<Role> findAllRole();

    List<Role> searchAllRole(String roleName);

    void deleteByRoleId(Integer roleId);

    void insertRole(Role role);

    void updateRole(Role role);

    Role findRoleById(Integer roleId);

    List<Role> findUserByRoleId(Integer roleId);

    void deleteUserByRoleId(@Param("userId") Integer userId,@Param("roleId") Integer roleId);

    void insertRoleUser(@Param("roleId") Integer roleId,@Param("userId") Integer userId);

    List<Menu> findMeanByRoleId(Integer id);

    void insertRoleMean(@Param("roleId") Integer roleId,@Param("menuId") Integer menuId);

    void deleteMeanByRoleId(@Param("roleId") Integer roleId,@Param("menuId") Integer menuId);
}
