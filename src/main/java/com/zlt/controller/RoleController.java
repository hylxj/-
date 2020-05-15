package com.zlt.controller;

import com.github.pagehelper.PageInfo;
import com.zlt.dao.MenuDao;
import com.zlt.dao.UserDao;
import com.zlt.pojo.*;
import com.zlt.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * @author huangyu
 * @date 2019-09-08-12:50
 */
@Controller
@RequestMapping("/role")
public class RoleController {
    private final RoleService roleService;
    private final UserDao userDao;
    private final MenuDao menuDao;
    public RoleController(RoleService roleService, UserDao userDao, MenuDao menuDao) {
        this.roleService = roleService;
        this.userDao = userDao;
        this.menuDao = menuDao;
    }

    @RequestMapping("/roleListPage")
    public String roleListPage(){
        return "role/roleList";
    }

    @RequestMapping("/roleList")
    @ResponseBody
    public ResultTable roleList(Integer page,Integer limit){
        PageInfo<Role> pageInfo = roleService.findAllRole(page, limit);
        if (pageInfo.getTotal()>=0){
            return new ResultTable(0,"",(int)pageInfo.getTotal(),pageInfo.getList());
        }
        return new ResultTable(6001,"没有找到数据");
    }

    @RequestMapping("/updateRole")
    @ResponseBody
    public ResultData updateRole(Role role){
        try {
            roleService.updateRole(role);
        }catch (DataAccessException e){
            return new ResultData(6002,"发现异常");
        }
        return new ResultData(200,"更新数据成功");
    }

    @RequestMapping("/search")
    @ResponseBody
    public ResultTable searchRole(Integer page,Integer limit,String key){
        PageInfo<Role> pageInfo = roleService.searchAllRole(page, limit,key);
        if (pageInfo.getTotal()>0){
            return new ResultTable(0,"",(int)pageInfo.getTotal(),pageInfo.getList());
        }
        return new ResultTable(6001,"没有找到数据");
    }

    @RequestMapping("/delRole")
    @ResponseBody
    public ResultData delRole(Integer roleId) {
        roleService.deleteByRoleId(roleId);
        return new ResultData(200, "删除成功");
    }
    @RequestMapping("/roleEditPage")
    public String roleEditPage(Integer roleId,Model model){
        Role role = roleService.findRoleById(roleId);
        model.addAttribute("role",role);
        return "/role/roleEdit";
    }
    @RequestMapping("/roleEdit")
    @ResponseBody
    public ResultData roleEdit(Role role){
        try {
            roleService.roleEdit(role);
        }catch (DataAccessException e){
            return new ResultData(6003,"发现异常");
        }
        return new ResultData(200,"更新数据成功");
    }
    @RequestMapping("/roleAddPage")
    public String roleAddPage(){
        return "/role/roleAdd";
    }
    @RequestMapping("/roleAdd")
    @ResponseBody
    public ResultData roleAdd(Role role){
        try {
            roleService.roleAdd(role);
        }catch (DataAccessException e){
            return new ResultData(6005,"添加失败，角色名已存在");
        }
        return new ResultData(200,"角色添加成功");
    }
    /**
     * @Description: 添加菜单页面
     * @Param: [roleId, model]
     * @Return: java.lang.String
     **/
    @RequestMapping("/roleMeanAddPage")
    public String roleMeanAddPage(Integer roleId,Model model) {
        List<Menu> menus=menuDao.findAllMenu();
        model.addAttribute("roleId", roleId);
        model.addAttribute("menus", menus);
        return "/role/roleMeanAdd";
    }
        /**
         * @Description: 角色菜单页面
         * @Param: [roleId, model]
         * @Return: java.lang.String
        **/
    @RequestMapping("/roleMeanPage")
    public String roleMeanPage(Integer roleId,Model model){
        model.addAttribute("roleId",roleId);
        return "/role/roleMeanList";
    }
    /**
     * @Description: 角色菜单列表
     * @Param: [id]
     * @Return: com.zlt.pojo.ResultTable
    **/
    @RequestMapping("/roleMeanList")
    @ResponseBody
    public ResultTable roleUserList(Integer page,Integer limit,Integer roleId){
        PageInfo<Menu> pageInfo=roleService.findMeanByRoleId(page, limit, roleId);

        if (pageInfo.getTotal()>0){
            return new ResultTable(0,"",(int)pageInfo.getTotal(),pageInfo.getList());
        }
        return new ResultTable(6001,"没有找到数据");
    }
    @RequestMapping("/deleteMeanByRoleId")
    @ResponseBody
    public ResultData deleteMeanByRoleId(Integer roleId,Integer menuId){
        roleService.deleteMeanByRoleId(roleId,menuId);
        return new ResultData(200,"取消授权成功");
    }

    @RequestMapping("/roleMenuAdd")
    @ResponseBody
    public ResultData roleMenuAdd(Integer menuId,Integer roleId){
        roleService.insertRoleMean(roleId,menuId);
        return new ResultData(200,"添加菜单成功");
    }
}
