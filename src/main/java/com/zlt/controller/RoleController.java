package com.zlt.controller;

import com.github.pagehelper.PageInfo;
import com.zlt.dao.UserDao;
import com.zlt.pojo.ResultData;
import com.zlt.pojo.ResultTable;
import com.zlt.pojo.Role;
import com.zlt.pojo.User;
import com.zlt.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author shushu
 * @date 2019-09-08-12:50
 */
@Controller
@RequestMapping("/role")
public class RoleController {
    @Autowired
    private RoleService roleService;
    @Autowired
    private UserDao userDao;

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
    @RequestMapping("/roleUserPage")
    public String roleUserPage(Integer roleId,Model model){
        model.addAttribute("roleId",roleId);
        return "/role/roleUserList";
    }
    @RequestMapping("/roleUserList")
    @ResponseBody
    public ResultTable roleUserList(Integer roleId){
        List<User> users=roleService.findUserByRoleId(roleId);
        return new ResultTable(0,"",users.size(),users);
    }
    @RequestMapping("/deleteUserByRoleId")
    @ResponseBody
    public ResultData deleteUserByRoleId(Integer roleId,Integer userId){
        roleService.deleteUserByRoleId(roleId,userId);
        return new ResultData(200,"取消授权成功");
    }
    @RequestMapping("/roleUserAddPage")
    public String roleUserAddPage(Integer roleId,Model model){
        List<User> users = userDao.findAllUser();
        model.addAttribute("roleId",roleId);
        model.addAttribute("users",users);
        return "/role/roleUserAdd";
    }
    @RequestMapping("/roleUserAdd")
    @ResponseBody
    public ResultData roleUserAdd(Integer userId,Integer roleId){
        roleService.insertRoleUser(roleId,userId);
        return new ResultData(200,"添加用户成功");
    }
}
