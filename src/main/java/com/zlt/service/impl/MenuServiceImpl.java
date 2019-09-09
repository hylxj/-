package com.zlt.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zlt.dao.MenuDao;
import com.zlt.pojo.Menu;
import com.zlt.pojo.Role;
import com.zlt.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @author shushu
 * @date 2019-09-08-11:15
 */
@Service
public class MenuServiceImpl implements MenuService {
    @Autowired
    private MenuDao menuDao;

    @Override
    public List<Menu> findAllMenuByRole( Integer[] roleIds) {
        List<Menu> menus= menuDao.findAllMenuByRole(roleIds);
        List<Menu> treeMenus=new ArrayList<>();
        for (Menu menu : menus) {
            if (menu.getParentId()==null){
                treeMenus.add(findChildren(menu,menus));
            }
        }
        return treeMenus;
    }

    /**
     * 递归查找字节点
     * @param menu
     * @param menus
     * @return
     */
    private Menu findChildren(Menu menu, List<Menu> menus) {
        for (Menu item : menus) {
            if (menu.getMenuId()==item.getParentId()){
                if (menu.getChildren()==null){
                    menu.setChildren(new ArrayList<>());
                }
                menu.getChildren().add(findChildren(item,menus));
            }
        }
        return menu;
    }

    @Override
    public PageInfo<Menu> findAllMenu(Integer page, Integer limit) {
        PageHelper.startPage(page,limit);
        List<Menu> menus = menuDao.findAllMenu();
        return new PageInfo<>(menus);
    }

    @Override
    public void updateMenu(Menu menu) {
        menuDao.updateMenu(menu);
    }

    @Override
    public PageInfo<Menu> searchAllMenu(Integer page, Integer limit, String key) {
        char[] chars = key.toCharArray();
        String menuName="%";
        for (char c:chars){
            menuName+=c+"%";
        }
        PageHelper.startPage(page,limit);
        List<Menu> menus = menuDao.searchAllMenu(menuName);
        return new PageInfo<>(menus);
    }

    @Override
    public void deleteByMenuId(Integer menuId) {
        menuDao.deleteByMenuId(menuId);
    }

    @Override
    public Menu findMenuById(Integer menuId) {
        return menuDao.findMenuById(menuId);
    }

    @Override
    public void menuAdd(Menu menu) {
        menuDao.insertMenu(menu);
    }

    @Override
    public List<Role> findRoleByMenuId(Integer menuId) {
        return menuDao.findRoleByMenuId(menuId);
    }

    @Override
    public void deleteRoleByMenuId(Integer menuId, Integer roleId) {
        menuDao.deleteRoleByMenuId(roleId,menuId);
    }

    @Override
    public void insertMenuRole(Integer menuId, Integer roleId) {
        menuDao.insertMenuRole(roleId,menuId);
    }
}
