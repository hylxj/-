package com.zlt.dao;

import com.zlt.pojo.Menu;
import com.zlt.pojo.Role;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author shushu
 * @date 2019-09-08-10:30
 */

public interface MenuDao {
    List<Menu> findAllMenuByRole(Integer[] roleIds);

    List<Menu> findAllMenu();

    List<Menu> searchAllMenu(String title);

    void deleteByMenuId(Integer menuId);

    void insertMenu(Menu menu);

    void updateMenu(Menu menu);

    Menu findMenuById(Integer menuId);

    List<Role> findRoleByMenuId(Integer menuId);

    void deleteRoleByMenuId(@Param("roleId") Integer roleId, @Param("menuId") Integer menuId);

    void insertMenuRole(@Param("roleId") Integer roleId,@Param("menuId") Integer menuId);
}
