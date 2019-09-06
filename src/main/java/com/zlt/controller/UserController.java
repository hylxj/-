package com.zlt.controller;

import com.github.pagehelper.PageInfo;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.WebResource;
import com.zlt.pojo.BusCen;
import com.zlt.pojo.ResultData;
import com.zlt.pojo.ResultTable;
import com.zlt.pojo.User;
import com.zlt.service.UserService;
import com.zlt.utils.PasswordUtil;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

/**
 * @author shushu
 * @date 2019-08-30-16:51
 */
@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("/userList")
    public String newListPage() {
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
        mv.addObject("busCens", busCens);
        mv.setViewName("user/userAdd");
        return mv;
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
    public ResultData delUser(Integer id) {
        userService.delUser(id);
        return new ResultData(200, "删除成功");
    }

    @RequestMapping("/batchDelUser")
    @ResponseBody
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
        model.addAttribute("user",userService.findByUsername(username));
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
     * @param file
     * @return
     */
    @RequestMapping("/uploadIcon")
    @ResponseBody
    public ResultData uploadIcon(HttpServletRequest request, MultipartFile file,Integer id){
        //定义上传文件服务器路径
        String path="http://localhost:9090/uploads/";
        //获取文件名称
        String filename = file.getOriginalFilename();
        //把文件的名称设置唯一值，uuid
        String uuid = UUID.randomUUID().toString().replace("-", "");
        filename=uuid+"_"+filename;
        try {
            //完成文件上传,跨服务器文件
            //创建客户端的对象
            Client client= Client.create();
            //和图片服务器进行连接
            WebResource webResource = client.resource(path + filename);
            //上传文件
            webResource.put(file.getBytes());
        } catch (IOException e) {
            e.printStackTrace();
        }
        userService.saveIcon(id,filename);
        return new ResultData(0,"上传头像成功",filename);
    }
}
