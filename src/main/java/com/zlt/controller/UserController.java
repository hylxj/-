package com.zlt.controller;

import com.github.pagehelper.PageInfo;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.WebResource;
import com.zlt.dao.RoleDao;
import com.zlt.dao.UserDao;
import com.zlt.pojo.*;
import com.zlt.service.RoleService;
import com.zlt.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import sun.misc.BASE64Encoder;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

/**
 * @author huangyu
 * @date 2019-08-30-16:51
 */
@Controller
@RequestMapping("/user")
public class UserController {
    private final UserService userService;
    private final RoleDao roleDao;
    private final RoleService roleService;
    private final UserDao userDao;
    public UserController(UserService userService, RoleDao roleDao, RoleService roleService, UserDao userDao) {
        this.userService = userService;
        this.roleDao = roleDao;
        this.roleService = roleService;
        this.userDao = userDao;
    }

    @RequiresRoles(value = {"admin","gxadmin","sladmin"},logical = Logical.OR)
    @RequestMapping("/userList")
    public String newListPage(Model model) {
        Subject currentUser= SecurityUtils.getSubject();
        User user=(User)currentUser.getPrincipal();
        System.out.println(user);
        model.addAttribute("roles",userService.findRolesByUserId(user.getId()));
        return "user/userList";
    }

    /**
     * 分页显示用户列表
     *
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping("/list")
    @ResponseBody
    public ResultTable getUserList(int page, int limit) {
        PageInfo<User> pageInfo = userService.findAllUser(page, limit);
        if (pageInfo.getTotal() == 0) {
            return new ResultTable(2001, "没有找到用户数据");
        }
        return new ResultTable(0, "用户数据查找成功", (int) pageInfo.getTotal(), pageInfo.getList());
    }

    /**
     * 根据用户名模糊搜索
     *
     * @param key
     * @return
     */
    @RequestMapping("/search")
    @ResponseBody
    public ResultTable searchUserList(String key) {
        return userService.searchUserList(key);
    }

    @RequestMapping("/userAddPage")
    public ModelAndView userAddPage(ModelAndView mv) {
        List<BusCen> busCens = userService.findAllBusCenName();
        List<Role> roles = roleDao.findAllRole();
        mv.addObject("roles",roles);
        mv.addObject("busCens", busCens);
        mv.setViewName("user/userAdd");
        return mv;
    }
    @RequestMapping("/roleUserPage")
    public String roleUserPage(Integer id,Model model){
        model.addAttribute("id",id);
        return "/user/roleUserList";
    }
    @RequestMapping("/roleUserList")
    @ResponseBody
    public ResultTable roleUserList(Integer id){
        List<Role> roles=roleService.findUserByRoleId(id);
        return new ResultTable(0,"",roles.size(),roles);
    }
    /**
     * @Description: 删除该用户拥有的角色
     * @Param: [roleId, userId]
     * @Return: com.zlt.pojo.ResultData
    **/
    @RequestMapping("/deleteUserByRoleId")
    @ResponseBody
    public ResultData deleteUserByRoleId(Integer roleId,Integer userId){
        roleService.deleteUserByRoleId(roleId,userId);
        return new ResultData(200,"删除角色成功");
    }
    /**
     * @Description: 添加角色页面
     * @Param: [roleId, model]
     * @Return: java.lang.String
    **/
    @RequestMapping("/roleUserAddPage")
    public String roleUserAddPage(Integer userId,Model model){
        List<Role> roles= roleDao.findAllRole();
        model.addAttribute("userId",userId);
        model.addAttribute("roles",roles);
        return "/user/roleUserAdd";
    }
    /**
     * @Description: 为用户添加角色
     * @Param: [userId, roleId]
     * @Return: com.zlt.pojo.ResultData
    **/
    @RequestMapping("/roleUserAdd")
    @ResponseBody
    public ResultData roleUserAdd(Integer userId,Integer roleId){
        roleService.insertRoleUser(roleId,userId);
        return new ResultData(200,"添加角色成功");
    }
    /**
     * 添加用户
     *
     * @param user
     * @return
     */
    @RequestMapping("/userAdd")
    @ResponseBody
    public ResultData userAdd(User user) {
        try {
            userService.userAdd(user);
            roleDao.insertRoleUser(user.getType(),user.getId());
        } catch (DataAccessException e) {
            return new ResultData(4001, "用户名重复了");
        }
        return new ResultData(200, "用户添加成功");
    }

    @RequestMapping("/userEditPage")
    public ModelAndView userEditPage(@RequestParam Integer id, ModelAndView mv) {
        List<BusCen> busCens = userService.findAllBusCenName();
        User user = userService.findAllById(id);
        mv.addObject("busCens", busCens);
        mv.addObject("user", user);
        mv.setViewName("user/userEdit");
        return mv;
    }
    /**
     * 用户编辑
     * @param user
     * @return
     */
    @RequestMapping("/userEdit")
    @ResponseBody
    public ResultData userEdit(User user) {
        try {
            userService.userEdit(user);
        } catch (DataAccessException e) {
            System.out.println(e.getMessage());
            return new ResultData(4001, "用户名重复了");
        }
        return new ResultData(200, "用户更新成功");
    }

    @RequestMapping("/delUser")
    @ResponseBody
    @RequiresRoles({"admin"})
    public ResultData delUser(Integer id) {
        userService.delUser(id);
        return new ResultData(200, "删除成功");
    }

    @RequestMapping("/batchDelUser")
    @ResponseBody
    @RequiresRoles({"admin"})
    public ResultData batchDelUser(@RequestParam("userId[]") Long[] userId) {
        userService.batchDelUser(userId);
        return new ResultData(200, "批量删除成功");
    }

    /**
     * 更新锁定状态
     * @param id
     * @param isLocked
     * @return
     */
    @RequestMapping("/updateLocked")
    @ResponseBody
    public ResultData updateLocked(Integer id, Integer isLocked) {
        userService.updateLocked(id, isLocked);
        return new ResultData(200, "");
    }

    @RequestMapping("/changePwdPage")
    public String changePwdPage(String username, Model model) {
        model.addAttribute("username", username);
        return "user/changePwd";
    }
    @RequestMapping("/userInfoPage")
    public String userInfoPage(String username,Model model){
        User user = userService.findByUsername(username);
        BASE64Encoder encoder = new BASE64Encoder();
        String icon = "";
        if(user.getIcon()!=null){
            icon = encoder.encode(user.getIcon());
        }
        model.addAttribute("user",userService.findByUsername(username));
        model.addAttribute("icon",icon);
        return "user/userInfo";
    }
    /**
     * 验证旧密码
     * @param username
     * @param password
     * @return
     */
    @RequestMapping("/verifyOldPwd")
    @ResponseBody
    public ResultData verifyOldPwd(String username, String password) {
        ResultData resultData = userService.verifyOldPwd(username, password);
        return resultData;
    }

    /**
     * 更新密码
     * @param username
     * @param password
     * @return
     */
    @RequestMapping("/changePwd")
    @ResponseBody
    public ResultData changePwd(String username, String password) {
        userService.updatePwd(username, password);
        return new ResultData(200,"更新密码成功");
    }

    /**
     * 头像上传
     * layui上传文件名字默认是file
     * @param request
     * @return
     */
    @RequestMapping(value = "/uploadIcon")
    @ResponseBody
    public ResultData uploadIcon(HttpServletRequest request,Integer id) throws IOException {
        // 转型为MultipartHttpRequest：解决shiroHttpServletRequest问题
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

        // 获得文件：
        MultipartFile file = multipartRequest.getFile("file");
        byte [] fileByte = file.getBytes();
        userService.saveIcon(id,fileByte);
        return new ResultData(0,"上传头像成功",fileByte);
    }
    @RequestMapping("/listByType")
    @ResponseBody
    public ResultTable listByType(Integer page,Integer limit,Integer type){
        ResultTable resultTable=null;
        if (type==0){//查找所有的调度中心
            PageInfo<User> pageInfo = userService.findAllUser(page, limit);
            return new ResultTable(0,"",(int)pageInfo.getTotal(),pageInfo.getList());
        }else {
            resultTable=userService.listByType(page,limit,type);
        }
        return resultTable;
    }
}
