package com.zlt.utils;

import com.zlt.pojo.BusLineDriver;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author:Teacher黄
 * @date:Created at 2019/07/08
 */
public class ExcelUtil {

    /**
     * 解析excel的数据
     * @param inputStream : 对应excel的表格的输入流
     * @throws IOException
     */
    public static List<List<String>> parseExcel(FileInputStream inputStream) throws IOException {
        // 返回的数据
        List<List<String>> data = new ArrayList<>();

        Workbook workbook = new XSSFWorkbook(inputStream);
        // 2.获取sheet1的对象,从0开始
        Sheet sheetAt = workbook.getSheetAt(0);
        // 3.获取最大的行数
        int lastRowNum = sheetAt.getLastRowNum();
        // 4.从指定行开始遍历
        // 从第二行开始,下标从0开始
        for (int i = 1; i <= lastRowNum ; i++) {
            // 行数据
            List<String> rowData = new ArrayList<>();
            // 获取当前行对象
            Row row = sheetAt.getRow(i);
            // 获取行的最大列
            short lastCellNum = row.getLastCellNum();
            // 从指定的列开始遍历列,列下标0开始
            for (int j = 0; j < lastCellNum ; j++) {

                // 获取单元格对象
                Cell cell = row.getCell(j);
                String value = "";
                // 读取数据
                if(cell != null){
                    // 验证单元格的类型
                    switch (cell.getCellType()) {
                        case NUMERIC:
                            if(HSSFDateUtil.isCellDateFormatted(cell)){
                                Date date = cell.getDateCellValue();
                                value = new SimpleDateFormat("yyyy/MM/dd").format(date);
                            }else {
                                value = new BigDecimal(cell.getNumericCellValue()).toPlainString();
                            }
                            // 表格中返回的数字类型是科学计数法因此不能直接转换成字符串格式
                            break;
                        case FORMULA:
                            // 和数字类似
                            value = new BigDecimal(cell.getNumericCellValue()).toPlainString();
                        case STRING:
                            value = cell.getStringCellValue();
                            break;
                        case BLANK:
                            value = "";
                            break;
                        case BOOLEAN:
                            value = Boolean.toString(cell.getBooleanCellValue());
                            break;
                        case ERROR:
                            value = "error";
                            break;
                        default:
                            value = "undefined";
                            break;
                    }
                }
                rowData.add(value);
            }
            data.add(rowData);
        }
        return data;
    }


    /**
     * 创建excel表格
     * @param busList
     * @return
     */
    public static Workbook exportExcel(List<BusLineDriver> busList){
        // 1. 创建workbook对象
        Workbook workbook = new XSSFWorkbook();
        // 2. 创建sheet
        Sheet sheet = workbook.createSheet("公交车列表");
        // 3. 创建表头
        // 创建行
        Row row = sheet.createRow(0);
        // 依次创建列
        row.createCell(0).setCellValue("车牌号");
        row.createCell(1).setCellValue("公交车名称");
        row.createCell(2).setCellValue("驾驶员");
        row.createCell(3).setCellValue("线路");
        row.createCell(4).setCellValue("公交车服役时间");
        row.createCell(5).setCellValue("公交车的状态");
        // 遍历数据创建对应的行
        int create = 1;
        for (BusLineDriver bus : busList) {
            Row row1 = sheet.createRow(create);
            // 依次创建列
            row1.createCell(0).setCellValue(bus.getBusPlate());
            row1.createCell(1).setCellValue(bus.getBusName());
            row1.createCell(2).setCellValue(bus.getBusdriverName());
            row1.createCell(3).setCellValue(bus.getLineName());
            row1.createCell(4).setCellValue((new SimpleDateFormat("yyyy/MM/dd").format(bus.getBusCreatetime())));
            row1.createCell(5).setCellValue(bus.getBusStatus() == 1 ? "正常" : "维修");
            // 行数+1
            create++;
        }

        return workbook;
    }

}
