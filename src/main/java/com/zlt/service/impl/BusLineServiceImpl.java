package com.zlt.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zlt.dao.BusLineDao;
import com.zlt.pojo.*;
import com.zlt.service.BusLineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * 公交车路线管理
 */
@Service
public class BusLineServiceImpl implements BusLineService {
    @Autowired
    private BusLineDao busLineDao;
    //返回路线信息
    @Override
    public TableData findAll(int page, int limit) {
        PageHelper.startPage(page,limit);
        List<BusLine> busLines = busLineDao.findAll();
        PageInfo<BusLine> pageInfo = new PageInfo<>(busLines);
        System.out.println("========"+pageInfo.getList());
        return new TableData(0,"查询数据成功",(int)pageInfo.getTotal(),pageInfo.getList());
    }
    //通过查询线路名称获取线路信息
    @Override
    public TableData findByLineName(String key, int page, int limit) {
        PageHelper.startPage(page,limit);
        List<BusLine> busLines = busLineDao.findByLineName(key);
        PageInfo<BusLine> pageInfo = new PageInfo<>(busLines);
        System.out.println("============="+pageInfo.getList());
        return new TableData(0,"搜索数据成功",(int)pageInfo.getTotal(),pageInfo.getList());
    }
    //通过线路的id删除线路
    @Override
    public void delLine(Integer lineId) {
        busLineDao.delLine(lineId);
    }
    //添加路线
    @Override
    public void saveLine(String lineName,String lineTime,String linePrice,int [] station) {
        BusLine busLine = new BusLine();
        int lineId = (int)System.currentTimeMillis(); //添加线路时用随机
        System.out.println("========================service id"+lineId);
        busLine.setLineId(lineId);
        busLine.setLineName(lineName);
        busLine.setLineTime(lineTime);
        busLine.setLinePrice(Integer.parseInt(linePrice));
        List<LineSta> lineStas = new ArrayList<>();
        for(int i=1;i<=station.length;i++){
            LineSta lineSta = new LineSta();
            lineSta.setLineId(lineId);
            lineSta.setStaId(station[i-1]);
            lineSta.setOrderId(i);
            lineStas.add(lineSta);
        }
        busLineDao.saveLineSta(lineStas);
        busLineDao.saveLine(busLine);
    }
    //通过线路id查找线路
    @Override
    public BusLine findByLineId(int id) {
        return busLineDao.findByLineId(id);
    }
    //修改的线路信息的保存
    @Override
    public void updateLine(BusLine line) {
         busLineDao.updateLine(line);
    }
    //通过线路名称查询站台信息
    @Override
    public List<LineStaView> findStaByLineName(String lineName) {
        return busLineDao.findStaByLineName(lineName);
    }
    //获取所有的站台信息
    @Override
    public List<BusStation> findAllStation() {
        return busLineDao.findAllStation();
    }


}
