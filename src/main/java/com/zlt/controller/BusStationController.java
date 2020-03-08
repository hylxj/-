package com.zlt.controller;

import com.zlt.pojo.BusStation;
import com.zlt.pojo.ResultData;
import com.zlt.pojo.TableData;
import com.zlt.service.BusStationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;


/**
 * 站点管理
 */
@Controller
@RequestMapping("/BusStation")
public class BusStationController {
    @Autowired
    private BusStationService busStationService;
    //显示站台信息页面
    @RequestMapping("/stationPage")
    public String stationPage(){
        return "busStation/stationList";
    }
    //把数据填入到table当中
    @RequestMapping("/tableData")
    @ResponseBody
    public TableData tableData(int page, int limit) {
        TableData resultData = busStationService.findAll(page, limit);
        return resultData;
    }
    //添加站台页面
    @RequestMapping("/addPage")
    public String addPage() {

        return "busStation/stationAdd";
    }
    //添加站台
    @RequestMapping("/addStation")
    @ResponseBody
    public ResultData addStation(String staName) {
        //捕获异常，有异常则添加失败，无异常添加成功
        System.out.println("============================="+staName);
        try {
            busStationService.saveStation(staName);
            return new ResultData(200, "添加成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultData(3000, "公交车车牌不能重复");
        }
    }
    //搜索站台
    @RequestMapping("/search")
    @ResponseBody
    public TableData search(String key,int page, int limit) {
        TableData resultData = busStationService.findByStationName("%" + key + "%",page,limit);
        return resultData;
    }
    //删除单个站点
    @RequestMapping("/del")
    @ResponseBody
    public ResultData del(Integer staId) {
        //捕获异常，有异常则删除失败，无异常删除成功
        try {
            busStationService.delStation(staId);
            return new ResultData(200, "删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultData(3000, "删除失败");
        }

    }
    //修改站台信息返回的页面数据
    @RequestMapping("/editPage")
    public ModelAndView editPage(int id) {
        System.out.println(id);
        BusStation busStation = busStationService.findByStationId(id);
        ModelAndView mv = new ModelAndView("busStation/editStation");
        mv.addObject("station", busStation);
        return mv;
    }
    //修改站点信息的保存
    @RequestMapping("/updateStation")
    @ResponseBody
    public ResultData updateStation(BusStation busStation) {
        System.out.println(busStation.getStaStatus());
        System.out.println(busStation.getStaName());
        busStationService.updateStation(busStation);
        return new ResultData(200, "修改成功");
    }
    //显示站台对应的线路信息页面
    @RequestMapping("/showLines")
    public String showLinesPage(HttpServletRequest request,int staId){
        request.getSession().setAttribute("staId",staId);
        return "busStation/showLines";
    }
    //查看站点的线路
    @RequestMapping("showLinesTable")
    @ResponseBody
    public TableData showLinesTable (HttpServletRequest request,int page, int limit){
        int staId = (int)request.getSession().getAttribute("staId");
        System.out.println("============================================"+staId);
        TableData resultData = busStationService.findLines(staId,page, limit);
        return resultData;
    }
}
