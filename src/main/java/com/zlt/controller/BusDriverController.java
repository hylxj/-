package com.zlt.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zlt.pojo.BusDriver;
import com.zlt.pojo.ResultData;
import com.zlt.pojo.ResultTable;
import com.zlt.service.BusDriverService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class BusDriverController {
    private final BusDriverService busDriverService;

    public BusDriverController(BusDriverService busDriverService) {
        this.busDriverService = busDriverService;
    }

    /**
     * 请求司机信息页面
     */
    @RequestMapping("/driverPage")
    public String driverPage(){
        return "busdriver/driver";
    }
    /**
     * 查询司机信息,并分页显示
     */
    @RequestMapping("/driver")
    @ResponseBody
    public ResultTable getDriver(Integer page,Integer limit){
        PageHelper.startPage(page,limit);
        List<BusDriver> busDrivers = busDriverService.selectDriver();
        PageInfo<BusDriver> pageInfo = new PageInfo<>(busDrivers);
        ResultTable resultTable = new ResultTable(0,"",(int)pageInfo.getTotal(),pageInfo.getList());
        return resultTable;
    }

    /**
     * 搜索司机，模糊搜索
     */
    @RequestMapping("/driverSel")
    @ResponseBody
    public ResultTable driverSel(String name){
        List<BusDriver> busDrivers = busDriverService.driverSel(name);
        ResultTable resultTable = new ResultTable(0,"",busDrivers.size(),busDrivers);
        return resultTable;
    }

    /**
     * 请求添加司机页面
     */
    @RequestMapping("/driverAddPage")
    public String driverAddPage(){
        return "busdriver/driverAdd";
    }
    /**
     * 添加司机信息
     */
    @RequestMapping("/driverAdd")
    @ResponseBody
    public ResultData driverAdd(BusDriver busDriver){
        busDriverService.driverAdd(busDriver);
        ResultData resultData = new ResultData(0,"");
        return resultData;
    }

    /**
     * 批量删除
     */
    @RequestMapping("/driverDels")
    @ResponseBody
    public String driverDels(@RequestParam("ids[]") Long[] ids){
        busDriverService.driverDels(ids);
        return "busdriver/driver";

    }

    /**
     * 编辑，先请求页面
     * 页面包含一条数据
     */
    @RequestMapping("/driverUpdatePage")
    public String driverUpdatePage(Integer id, Model model){
        BusDriver busDriver = busDriverService.selectOneDriver(id);
        model.addAttribute("busDriver",busDriver);
        return "busdriver/driverUpdate";
    }
    /**
     * 将数据更新
     */
    @RequestMapping("/driverUpdate")
    @ResponseBody
    public ResultData expenseUpdate(BusDriver busDriver){
        busDriverService.driverUpdate(busDriver);
        ResultData resultData = new ResultData(0,"");
        return  resultData;
    }

    /**
     * 删除数据
     */
    @RequestMapping("/driverDel")
    @ResponseBody
    public String driverDel(Integer id){
        busDriverService.driverDel(id);
        return "busdriver/driver";
    }


}
