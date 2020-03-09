package com.zlt.controller;

import com.github.pagehelper.PageInfo;
import com.zlt.dao.RoleDao;
import com.zlt.pojo.*;
import com.zlt.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author huangyu
 * @date 2019-09-08-11:38
 */
@Controller
@RequestMapping("/menu")
public class MenuController {
    @Autowired
    private MenuService menuService;
    @Autowired
    private RoleDao roleDao;

    @RequestMapping("/findAllMenuByRole")
    @ResponseBody
    public List<Menu> findAllMenuByRole(@RequestParam("roleIds") List<Integer> roleIds){
        return menuService.findAllMenuByRole(roleIds.toArray(new Integer[0]));
    }
    @RequestMapping("/menuListPage")
    public String menuListPage(){
        return "menu/menuList";
    }

    @RequestMapping("/menuList")
    @ResponseBody
    public ResultTable menuList(Integer page,Integer limit){
        PageInfo<Menu> pageInfo = menuService.findAllMenu(page, limit);
        if (pageInfo.getTotal()>0){
            return new ResultTable(0,"",(int)pageInfo.getTotal(),pageInfo.getList());
        }
        return new ResultTable(6001,"没有找到数据");
    }

    @RequestMapping("/updateMenu")
    @ResponseBody
    public ResultData updateMenu(Menu menu){
        try {
            menuService.updateMenu(menu);
        }catch (DataAccessException e){
            return new ResultData(6002,"发现异常");
        }
        return new ResultData(200,"更新数据成功");
    }

    @RequestMapping("/search")
    @ResponseBody
    public ResultTable searchMenu(Integer page,Integer limit,String key){
        PageInfo<Menu> pageInfo = menuService.searchAllMenu(page, limit,key);
        if (pageInfo.getTotal()>0){
            return new ResultTable(0,"",(int)pageInfo.getTotal(),pageInfo.getList());
        }
        return new ResultTable(6001,"没有找到数据");
    }

    @RequestMapping("/delMenu")
    @ResponseBody
    public ResultData delMenu(Integer menuId) {
        menuService.deleteByMenuId(menuId);
        return new ResultData(200, "删除成功");
    }
    @RequestMapping("/menuEditPage")
    public String menuEditPage(Integer menuId,Model model){
        Menu menu = menuService.findMenuById(menuId);
        model.addAttribute("menu",menu);
        return "/menu/menuEdit";
    }
    @RequestMapping("/menuAddPage")
    public String menuAddPage(){
        return "/menu/menuAdd";
    }
    @RequestMapping("/menuAdd")
    @ResponseBody
    public ResultData menuAdd(Menu menu){
        try {
            menuService.menuAdd(menu);
        }catch (DataAccessException e){
            return new ResultData(6005,"添加失败，菜单名已存在");
        }
        return new ResultData(200,"菜单添加成功");
    }
    @RequestMapping("/menuRolePage")
    public String menuRolePage(Integer menuId,Model model){
        model.addAttribute("menuId",menuId);
        return "/menu/menuRoleList";
    }
    @RequestMapping("/menuRoleList")
    @ResponseBody
    public ResultTable menuRoleList(Integer menuId){
        List<Role> roles=menuService.findRoleByMenuId(menuId);
        return new ResultTable(0,"",roles.size(),roles);
    }
    @RequestMapping("/deleteRoleByMenuId")
    @ResponseBody
    public ResultData deleteRoleByMenuId(Integer menuId,Integer roleId){
        menuService.deleteRoleByMenuId(menuId,roleId);
        return new ResultData(200,"取消授权成功");
    }
    @RequestMapping("/menuRoleAddPage")
    public String menuRoleAddPage(Integer menuId,Model model){
        List<Role> roles = roleDao.findAllRole();
        model.addAttribute("menuId",menuId);
        model.addAttribute("roles",roles);
        return "/menu/menuRoleAdd";
    }
    @RequestMapping("/menuRoleAdd")
    @ResponseBody
    public ResultData menuRoleAdd(Integer menuId,Integer roleId){
        menuService.insertMenuRole(menuId,roleId);
        return new ResultData(200,"添加菜单成功");
    }
}
