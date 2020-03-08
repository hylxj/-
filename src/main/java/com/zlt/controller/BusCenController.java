package com.zlt.controller;

import com.github.pagehelper.PageInfo;
import com.zlt.dao.RoleDao;
import com.zlt.pojo.BusCen;
import com.zlt.pojo.ResultData;
import com.zlt.pojo.ResultTable;
import com.zlt.pojo.Role;
import com.zlt.service.BusCenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author shushu
 * @date 2019-09-09-11:07
 */
@Controller
@RequestMapping("/busCen")
public class BusCenController {
    @Autowired
    BusCenService busCenService;
    @Autowired
    RoleDao roleDao;

    @RequestMapping("/treeLoad")
    @ResponseBody
    public List<BusCen> treeLoad(@RequestParam("roleIds") List<Integer> roleIds){
        return busCenService.treeLoad(roleIds.toArray(new Integer[0]));
    }

    @RequestMapping("/busCenListPage")
    public String busCenListPage(){
        return "buscen/busCenList";
    }

    @RequestMapping("/busCenList")
    @ResponseBody
    public ResultTable busCenList(Integer page,Integer limit){
        PageInfo<BusCen> pageInfo = busCenService.findAllBusCen(page, limit);
        if (pageInfo.getTotal()>0){
            return new ResultTable(0,"",(int)pageInfo.getTotal(),pageInfo.getList());
        }
        return new ResultTable(6001,"没有找到数据");
    }

    @RequestMapping("/updateBusCen")
    @ResponseBody
    public ResultData updateBusCen(BusCen busCen){
        try {
            busCenService.updateBusCen(busCen);
        }catch (DataAccessException e){
            return new ResultData(6002,"发现异常");
        }
        return new ResultData(200,"更新数据成功");
    }

    @RequestMapping("/search")
    @ResponseBody
    public ResultTable searchBusCen(Integer page,Integer limit,String key){
        PageInfo<BusCen> pageInfo = busCenService.searchAllBusCen(page, limit,key);
        if (pageInfo.getTotal()>0){
            return new ResultTable(0,"",(int)pageInfo.getTotal(),pageInfo.getList());
        }
        return new ResultTable(6001,"没有找到数据");
    }

    @RequestMapping("/delBusCen")
    @ResponseBody
    public ResultData delBusCen(Integer buscenId) {
        busCenService.deleteByBusCenId(buscenId);
        return new ResultData(200, "删除成功");
    }
    @RequestMapping("/busCenEditPage")
    public String busCenEditPage(Integer buscenId,Model model){
        BusCen busCen = busCenService.findBusCenById(buscenId);
        model.addAttribute("busCen",busCen);
        return "/buscen/busCenEdit";
    }
    @RequestMapping("/busCenAddPage")
    public String busCenAddPage(){
        return "/buscen/busCenAdd";
    }
    @RequestMapping("/busCenAdd")
    @ResponseBody
    public ResultData busCenAdd(BusCen busCen){
        try {
            busCenService.busCenAdd(busCen);
        }catch (DataAccessException e){
            return new ResultData(6005,"添加失败，机构名已存在");
        }
        return new ResultData(200,"机构名添加成功");
    }
    @RequestMapping("/busCenRolePage")
    public String busCenRolePage(Integer buscenId,Model model){
        model.addAttribute("buscenId",buscenId);
        return "/buscen/busCenRoleList";
    }
    @RequestMapping("/busCenRoleList")
    @ResponseBody
    public ResultTable busCenRoleList(Integer buscenId){
        List<Role> roles=busCenService.findRoleByBusCenId(buscenId);
        return new ResultTable(0,"",roles.size(),roles);
    }
    @RequestMapping("/deleteRoleByBusCenId")
    @ResponseBody
    public ResultData deleteRoleByBusCenId(Integer buscenId, Integer roleId){
        busCenService.deleteRoleByBusCenId(buscenId,roleId);
        return new ResultData(200,"取消授权成功");
    }
    @RequestMapping("/busCenRoleAddPage")
    public String busCenRoleAddPage(Integer buscenId, Model model){
        List<Role> roles = roleDao.findAllRole();
        model.addAttribute("buscenId",buscenId);
        model.addAttribute("roles",roles);
        return "/buscen/busCenRoleAdd";
    }
    @RequestMapping("/busCenRoleAdd")
    @ResponseBody
    public ResultData busCenRoleAdd(Integer buscenId,Integer roleId){
        busCenService.insertBusCenRole(buscenId,roleId);
        return new ResultData(200,"添加机构名成功");
    }
}
