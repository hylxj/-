package com.zlt.service;

import com.github.pagehelper.PageInfo;
import com.zlt.pojo.Menu;
import com.zlt.pojo.Role;
import com.zlt.pojo.User;

import java.util.List;

/**
 * @author huangyu
 * @date 2019-09-08-11:13
 */

public interface MenuService {
    List<Menu> findAllMenuByRole(Integer[] roleIds);

    PageInfo<Menu> findAllMenu(Integer page, Integer limit);

    void updateMenu(Menu menu);

    PageInfo<Menu> searchAllMenu(Integer page, Integer limit, String key);

    void deleteByMenuId(Integer menuId);

    Menu findMenuById(Integer menuId);

    void menuAdd(Menu menu);

    List<Role> findRoleByMenuId(Integer menuId);

    void deleteRoleByMenuId(Integer menuId, Integer roleId);

    void insertMenuRole(Integer menuId, Integer roleId);
}
