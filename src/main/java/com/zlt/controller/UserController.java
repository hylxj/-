package com.zlt.controller;

import com.github.pagehelper.PageInfo;
import com.zlt.pojo.BusCen;
import com.zlt.pojo.ResultData;
import com.zlt.pojo.ResultTable;
import com.zlt.pojo.User;
import com.zlt.service.UserService;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

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
    public String newListPage(){
        return "user/userList";
    }

    @RequestMapping("/list")
    @ResponseBody
    public ResultTable getUserList(int page, int limit){
        PageInfo<User> pageInfo=userService.findAllUser(page,limit);
        if (pageInfo.getTotal()==0){
            return new ResultTable(2001,"没有找到用户数据");
        }
        return new ResultTable(0,"用户数据查找成功",(int)pageInfo.getTotal(),pageInfo.getList());
    }

    @RequestMapping("/search")
    @ResponseBody
    public ResultTable searchUserList(String key){
        return userService.searchUserList(key);
    }

    @RequestMapping("/userAddPage")
    public ModelAndView userAddPage(ModelAndView mv){
        List<BusCen> busCens=userService.findAllBusCenName();
        mv.addObject("busCens",busCens);
        mv.setViewName("user/userAdd");
        return mv;
    }
    @RequestMapping("/userAdd")
    @ResponseBody
    public ResultData userAdd(User user){
        user.setSalt(user.getUsername());
        String hashAlgorithName = "MD5";
        Object credentials = user.getPassword();
        Object salt = ByteSource.Util.bytes(user.getSalt());
        int hashIterations = 1024;
        Object result = new SimpleHash(hashAlgorithName, credentials, salt, hashIterations);
        user.setPassword(String.valueOf(result));
        try {
            userService.userAdd(user);
        }catch (DataAccessException e){
            return new ResultData(4001,"用户名重复了");
        }
        return new ResultData(200,"用户添加成功");
    }
    @RequestMapping("/userEditPage")
    public ModelAndView userEditPage(@RequestParam Integer id, ModelAndView mv){
        List<BusCen> busCens=userService.findAllBusCenName();
        User user=userService.findAllById(id);
        mv.addObject("busCens",busCens);
        mv.addObject("user",user);
        mv.setViewName("user/userEdit");
        return mv;
    }
    @RequestMapping("/userEdit")
    @ResponseBody
    public ResultData userEdit(User user){
        try {
            userService.userEdit(user);
        }catch (DataAccessException e){
            return new ResultData(4001,"用户名重复了");
        }
        return new ResultData(200,"用户更新成功");
    }
    @RequestMapping("/delUser")
    @ResponseBody
    public ResultData delUser(Integer id){
        userService.delUser(id);
        return new ResultData(200,"删除成功");
    }
    @RequestMapping("/batchDelUser")
    @ResponseBody
    public ResultData batchDelUser(@RequestParam("userId[]") Long[] userId){
        userService.batchDelUser(userId);
        return new ResultData(200,"批量删除成功");
    }
    @RequestMapping("/updateLocked")
    @ResponseBody
    public ResultData updateLocked(Integer id,Integer isLocked){
        userService.updateLocked(id,isLocked);
        return new ResultData(200,"");
    }
    @RequestMapping("/changePwdPage")
    public String changePwdPage(String username, Model model){
        model.addAttribute("username",username);
        return "user/changePwd";
    }
    @RequestMapping("/verifyOldPwd")
    @ResponseBody
    public ResultData verifyOldPwd(String username,String password){
        ResultData resultData=userService.verifyOldPwd(username,password);
        return resultData;
    }
    @RequestMapping("/changePwd")
    @ResponseBody
    public ResultData changePwd(String username,String password){
        userService.updatePwd(username,password);
        return null;
    }
}
