package com.zlt.controller;

import com.zlt.pojo.*;
import com.zlt.service.BusLineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * 公交车线路管理
 */
@Controller
@RequestMapping("/busLine")
public class BusLineController {
    @Autowired
    private BusLineService busLineService;
    //返回公交车路线信息的页面
    @RequestMapping("/linePage")
    public String  linePage(){
        return "busLine/lineList";
    }
    //把数据填入到table当中
    @RequestMapping("/tableData")
    @ResponseBody
    public TableData tableData(int page, int limit) {
        TableData resultData = busLineService.findAll(page, limit);
        return resultData;
    }
    //通过线路名称查询线路信息
    @RequestMapping("/search")
    @ResponseBody
    public TableData search(String key,int page, int limit)  {
        System.out.println("==========="+key);
        TableData tableData = busLineService.findByLineName("%" + key + "%",page,limit);
        return  tableData;
    }
    //添加线路页面
    @RequestMapping("/addPage")
    public ModelAndView addPage() {
        List<BusStation> list = busLineService.findAllStation();
        ModelAndView mv = new ModelAndView("busLine/lineAdd");
        mv.addObject("stationList",list);
        return mv;
    }
    //添加线路
    @RequestMapping("/addLine")
    @ResponseBody
    public ResultData addLine(String lineName,String lineTime,String linePrice,String lineStation) {//,
        //捕获异常，有异常则添加失败，无异常添加成功
        String sta [] =lineStation.split(",");
        int station [] = new int [sta.length];
        for(int i=0;i<station.length;i++){
            station [i] = Integer.parseInt(sta[i]);
        }
        try {
            busLineService.saveLine(lineName,lineTime,linePrice,station);
            System.out.println("+++++++++++===="+lineName+lineTime+linePrice);
            return new ResultData(200, "添加成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultData(3000, "公交车车牌不能重复");
        }
    }
    //删除单条路线
    @RequestMapping("/del")
    @ResponseBody
    public ResultData del(Integer lineId) {
        //捕获异常，有异常则删除失败，无异常删除成功
        try {
            busLineService.delLine(lineId);
            return new ResultData(200, "添加成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultData(3000, "添加失败");
        }
    }
    //修改线路信息返回的页面数据
    @RequestMapping("/editPage")
    public ModelAndView editPage(int id) {
        BusLine line = busLineService.findByLineId(id);
        ModelAndView mv = new ModelAndView("busLine/editLine");
        mv.addObject("line", line);
        return mv;
    }

    //修改线路信息的保存
    @RequestMapping("/updateLine")
    @ResponseBody
    public ResultData updateBus(BusLine line) {
        System.out.println(line);
        busLineService.updateLine(line);
        return new ResultData(200, "修改成功");
    }
    //通过线路名称查询站台信息
    @RequestMapping("/showStaPage")
    public ModelAndView showStaPage(String lineName) {
       List<LineStaView> lineStaList = busLineService.findStaByLineName(lineName);
        ModelAndView mv = new ModelAndView("busLine/lineStation");
        mv.addObject("lineStaList",lineStaList);
        return mv;
    }
}
