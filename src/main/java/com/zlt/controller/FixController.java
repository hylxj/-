package com.zlt.controller;

import com.zlt.pojo.*;
import com.zlt.service.BusService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;

/**
 * @ClassName FixController
 * @Description: TODO
 * @Author huangyu
 * @Date 2020/4/5
 * @Version V1.0
 **/
@Controller
@RequestMapping("fix")
public class FixController {
    private final BusService busService;

    public FixController(BusService busService) {
        this.busService = busService;
    }
    @RequestMapping("/busFixPage")
    public String menuListPage(){
        return "fix/fixBus";
    }
    @RequestMapping("/fixLog")
    public String fixLogPage(){
        return "fix/fixBusLog";
    }

    // 查询维修信息
    @RequestMapping("/fixCenter")
    @ResponseBody
    public TableData fixCenter (int page, int limit){
        TableData resultData = busService.findFixBus(page,limit);
        return resultData;
    }
    // 查询维修记录
    @RequestMapping("/fixLogList")
    @ResponseBody
    public TableData fixLogList (int page, int limit){
        TableData resultData = busService.fixLogList(page,limit);
        return resultData;
    }
    // 查询维修车辆信息
    @RequestMapping("/fixing")
    @ResponseBody
    public ModelAndView fixCenter (int id){
        List<IdAndName> driverName = busService.findDriverName();
        List<IdAndName> lineName = busService.findLineName();
        ModelAndView mv = new ModelAndView("fix/fixing");
        mv.addObject("driverName", driverName);
        mv.addObject("lineName", lineName);
        Map map = busService.findFixBusById(id);
        mv.addObject("harmBus", map);
        return mv;
    }
    //添加维修车辆信息记录
    @RequestMapping("/addFixBusLog")
    @ResponseBody
    public ResultData addFixBusLog(@RequestParam(value = "busId") int busId,@RequestParam(value = "fixId") int fixId, @RequestParam(value = "fixMoney") String fixMoney) {
        busService.addFixBusLog(busId,fixId,fixMoney);
        return new ResultData(200, "修改成功");
    }
    @RequestMapping("/del")
    @ResponseBody
    public ResultData delBusCen(int busId) {
        busService.delFixBus(busId);
        return new ResultData(200, "删除成功");
    }
}
