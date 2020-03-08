package com.zlt.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zlt.pojo.BarBean;
import com.zlt.pojo.BusCenter;
import com.zlt.pojo.ResultData;
import com.zlt.pojo.ResultTable;
import com.zlt.service.CenBusService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class CenBusController {
    @Autowired
    private CenBusService cenBusService;

    /**
     * 请求锦江页面
     * @return
     */
    @RequestMapping("/CenWorkerNumPage")
    public String CenWorkerNumPage(){
        return "statistics/jinjiang";
    }

    /**
     * 返回出锦江页面内容
     * @return
     */
    @RequestMapping("/CenWorkerNum")
    @ResponseBody
    public List<BarBean> getCenWorkerNum(){
        List<BarBean> barBeans = cenBusService.selectCenWorkerNum();
        return barBeans;
    }


    /**
     * 请求公交总站页面
     */
    @RequestMapping("/terminusPage")
    public String TerminusPage(){
        return "statistics/busTerminus";
    }
    /**
     * 返回公交总站信息
     */
    @RequestMapping("/BusCenter")
    @ResponseBody
    public ResultTable getBusCenter(Integer page,Integer limit){
        PageHelper.startPage(page,limit);
        List<BusCenter> busCenters = cenBusService.selectBusCenter();
        PageInfo<BusCenter> pageInfo = new PageInfo<>(busCenters);
        ResultTable resultTables = new ResultTable(0,"",(int)pageInfo.getTotal(),pageInfo.getList());
        return resultTables;
    }

    /**
     * 删除总站信息
     * @param id
     * @return
     */
    @RequestMapping("/termDel")
    @ResponseBody
    public String termDel(Integer id){
        cenBusService.termDel(id);
        return "statisics/busTerminus";
    }

    /**
     * 搜索总站信息
     */
    @RequestMapping("/termSearch")
    @ResponseBody
    public ResultTable termSearch(Integer id){
        List<BusCenter> busCenters = cenBusService.termSearch(id);
        ResultTable resultTable = new ResultTable(0,"",busCenters.size(),busCenters);
        return resultTable;

    }

    /**
     *添加站点页面
     * @return
     */
    @RequestMapping("/busTerminusAddPage")
    public String busTerminusAddPage(){
        return "statistics/busTerminusAdd";
    }
    /**
     * 添加站点信息
     */
    @RequestMapping("/busTerminusAdd")
    @ResponseBody
    public ResultData busTerminusAdd(BusCenter busCenter){
        cenBusService.busTerminusAdd(busCenter);
        ResultData resultData = new ResultData(0,"");
        return resultData;
    }

    /**
     * 查询更新页面并有数据
     */
    @RequestMapping("/busTerminusUpdatePage")
    public String busTerminusUpdatePage(Integer id, Model model){
        BusCenter busCenter = cenBusService.busTerminusUpdatePage(id);
        model.addAttribute("buscenter",busCenter);
        return "statistics/busTerminusUpdate";
    }
    /**
     * 更新查出来的数据
     */
    @RequestMapping("/busTerminusUpdate")
    @ResponseBody
    public ResultData busTerminusUpdate(BusCenter busCenter){
        cenBusService.busTerminusUpdate(busCenter);
        ResultData resultData = new ResultData(0,"");
        return resultData;
    }

    /**
     * 地图显示
     */
    @RequestMapping("/mapPage")
    public String mapPage(){
        return "statistics/map2";
    }



}
