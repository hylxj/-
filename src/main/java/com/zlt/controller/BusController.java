package com.zlt.controller;

import cn.hutool.core.lang.UUID;
import com.zlt.pojo.Bus;
import com.zlt.pojo.IdAndName;
import com.zlt.pojo.ResultData;
import com.zlt.pojo.TableData;
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
import java.util.List;


/**
 * 公交车管理
 */
@Controller
@RequestMapping("bus")
public class BusController {
    @Autowired
    private BusService busService;

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
        System.out.println(driverName.toString());
        System.out.println(lineName.toString());
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
            return new ResultData(200, "添加成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultData(3000, "添加失败");
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
        Bus bus = busService.findByBusId(id);
        ModelAndView mv = new ModelAndView("bus/editBus");
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

    //文件上传
    @RequestMapping("/fileUpload")
    @ResponseBody
    public ResultData fileUpload(HttpServletRequest request, MultipartFile upload) throws IOException, ParseException {
        String path = request.getSession().getServletContext().getRealPath("/loads/");//指定文件上传到服务器的位置
        File file = new File(path);//
        if (!file.exists()) {//目录不存在，则创建目录
            file.mkdirs();
        }
        String fileName = upload.getOriginalFilename();//获取文件的文件的名字
        String ext = fileName.substring(fileName.lastIndexOf("."));
        if (".xlsx.xls".indexOf(ext) == -1) {
            return new ResultData(600, "上传文件格式不对");
        }
        String uuid = UUID.randomUUID().toString().replace("-", "");//设置文件上传名字唯一
        fileName = uuid + "_" + fileName;
        upload.transferTo(new File(path, fileName));//把文件写入服务器
        File file1 = new File(path, fileName);
        //数据导入
        FileInputStream inputStream = new FileInputStream(file1);
        List<List<String>> lists = ExcelUtil.parseExcel(inputStream);
        for (List<String> list : lists) {
            Bus bus = new Bus(list.get(0), list.get(1), Integer.valueOf(list.get(2)), Integer.valueOf(list.get(3)), (new SimpleDateFormat("yyyy/MM/dd")).parse(list.get(4)), "正常".equals(list.get(5)) ? 1 : 2);
            System.out.println(bus);
            addBus(bus);
        }
        return new ResultData(200, "上传成功");
    }

    //excel数据的导出
    @RequestMapping("/excelExport")
    public void excelExport(HttpServletResponse response) throws IOException {
        //获取公交车数据
        List<Bus> list = busService.getBusList();
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
}