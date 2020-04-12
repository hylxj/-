package com.zlt.controller;

import cn.hutool.core.lang.UUID;
import com.zlt.pojo.*;
import com.zlt.service.BusService;
import com.zlt.utils.ExcelUtil;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 公交车管理
 */
@Controller
@RequestMapping("bus")
public class BusController {
    private final BusService busService;

    public BusController(BusService busService) {
        this.busService = busService;
    }
    //返回公交车数据列表页面
    @RequestMapping("/tablePage")
    public String tablePage() {
        return "bus/busList";
    }

    //数据列表，把数据填入到table当中
    @RequestMapping("/tableData")
    @ResponseBody
    public TableData tableData(int page, int limit) {
        TableData resultData = busService.findAll(page, limit);
        return resultData;
    }

    //添加车辆页面
    @RequestMapping("/addPage")
    public ModelAndView addPage() {
        List<IdAndName> driverName = busService.findDriverName();
        List<IdAndName> lineName = busService.findLineName();
        ModelAndView mv = new ModelAndView("bus/busAdd");
        mv.addObject("driverName", driverName);
        mv.addObject("lineName", lineName);
        return mv;
    }

    //添加车辆
    @RequestMapping("/addBus")
    @ResponseBody
    public ResultData addBus(Bus bus) {
        //捕获异常，有异常则添加失败，无异常添加成功
        System.out.println(bus.toString());
        try {
            busService.saveBus(bus);
            return new ResultData(200, "添加成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultData(3000, "公交车车牌不能重复");
        }
    }

    //搜索车辆
    @RequestMapping("/search")
    @ResponseBody
    public TableData search(String key,int page, int limit) {
        TableData resultData = busService.findByBusName("%" + key + "%",page,limit);
        return resultData;
    }

    //删除单个车辆
    @RequestMapping("/del")
    @ResponseBody
    public ResultData del(Integer busId) {
        //捕获异常，有异常则删除失败，无异常删除成功
        try {
            busService.delBus(busId);
            return new ResultData(200, "删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultData(3000, "删除失败");
        }

    }

    //批量删除车辆
    @RequestMapping("/delAll")
    @ResponseBody
    public ResultData delAll(@RequestParam("ids[]") long[] busIds) {
        //捕获异常，有异常则删除失败，无异常删除成功
        try {
            busService.delAllBus(busIds);
            return new ResultData(200, "添加成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultData(3001, "添加失败");
        }
    }

    //修改车辆信息返回的页面数据
    @RequestMapping("/editPage")
    public ModelAndView editPage(int id) {
        List<IdAndName> driverName = busService.findDriverName();
        List<IdAndName> lineName = busService.findLineName();
        ModelAndView mv = new ModelAndView("bus/editBus");
        mv.addObject("driverName", driverName);
        mv.addObject("lineName", lineName);
        Bus bus = busService.findByBusId(id);
        mv.addObject("bus", bus);
        return mv;
    }
    //修改车辆信息返回的页面数据
    @RequestMapping("/fixPage")
    public ModelAndView fixPage(int id) {
        List<IdAndName> driverName = busService.findDriverName();
        List<IdAndName> lineName = busService.findLineName();
        ModelAndView mv = new ModelAndView("bus/fixBus");
        mv.addObject("driverName", driverName);
        mv.addObject("lineName", lineName);
        Bus bus = busService.findByBusId(id);
        mv.addObject("bus", bus);
        return mv;
    }

    //修改车辆信息的保存
    @RequestMapping("/updateBus")
    @ResponseBody
    public ResultData updateBus(Bus bus) {
        busService.updateBus(bus);
        return new ResultData(200, "修改成功");
    }
    //报修车辆信息的保存
    @RequestMapping("/fixBusInfo")
    @ResponseBody
    public ResultData fixBusInfo(@RequestParam(value = "busId") int busId,@RequestParam(value = "busFixReason") String busFixReason) {
        busService.fixBus(busId,busFixReason);
        return new ResultData(200, "修改成功");
    }

    //文件上传
    @RequestMapping("/fileUpload")
    @ResponseBody
    public ResultData fileUpload(HttpServletRequest request, MultipartFile file) throws IOException, ParseException {
        String path = request.getSession().getServletContext().getRealPath("/loads/");//指定文件上传到服务器的位置
        File file1 = new File(path);//
        if (!file1.exists()) {//目录不存在，则创建目录
            file1.mkdirs();
        }
        String fileName = file.getOriginalFilename();//获取文件的文件的名字
        String ext = fileName.substring(fileName.lastIndexOf("."));
        if (".xlsx.xls".indexOf(ext) == -1) {
            return new ResultData(600, "上传文件格式不对");
        }
        String uuid = UUID.randomUUID().toString().replace("-", "");//设置文件上传名字唯一
        fileName = uuid + "_" + fileName;
        file.transferTo(new File(path, fileName));//把文件写入服务器
        File file2 = new File(path, fileName);
        //数据导入
        FileInputStream inputStream = new FileInputStream(file2);
        List<List<String>> lists = ExcelUtil.parseExcel(inputStream);
        for (List<String> list : lists) {
            Bus bus = new Bus(list.get(0), list.get(1), Integer.valueOf(list.get(2)), Integer.valueOf(list.get(4)), (new SimpleDateFormat("yyyy/MM/dd")).parse(list.get(6)), "正常".equals(list.get(7)) ? 1 : 2);
            addBus(bus);
        }
        return new ResultData(200, "上传成功");
    }

    //excel数据的导出
    @RequestMapping("/excelExport")
    public void excelExport(HttpServletResponse response) throws IOException {
        //获取公交车数据
        List<BusLineDriver> list = busService.getBusList();
        //创建导出工具
        Workbook workbook = ExcelUtil.exportExcel(list);
        //告诉浏览器需要下载文件
        response.setHeader("Content-Disposition", "attachment;fileName=" + System.currentTimeMillis() + ".xlsx");
        //获取输出流
        ServletOutputStream outputStream = response.getOutputStream();
        //输出表格数据
        workbook.write(outputStream);
        //关闭流
        outputStream.close();
        workbook.close();
    }
    //通过公交车Id查询公交车名称
    @RequestMapping("/findDriverName")
    @ResponseBody
    public ResultData findDriverName (){
        List<IdAndName> idAndNames=busService.findAllIdAndName();
        Map<Integer,String> idAndName=new HashMap<>();
        for (IdAndName andName : idAndNames) {
            idAndName.put(andName.getId(),andName.getName());
        }
        return  new ResultData(200,"ok",idAndName);
    }

    //通过线路的Id查询线路的名称
    @RequestMapping("/findLineName")
    @ResponseBody
    public ResultData findLineName (){
        List<IdAndName> idAndNames=busService.findAllLineIdAndName();
        Map<Integer,String> idAndName=new HashMap<>();
        for (IdAndName andName : idAndNames) {
            idAndName.put(andName.getId(),andName.getName());
        }
        return  new ResultData(200,"ok",idAndName);
    }


}
