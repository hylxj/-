package com.zlt.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zlt.dao.BusDao;

import com.zlt.pojo.Bus;
import com.zlt.pojo.IdAndName;
import com.zlt.pojo.TableData;
import com.zlt.service.BusService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 公交车的serviceImpl
 */
@Service
public class BusServiceImpl implements BusService {
    @Autowired
    private BusDao busDao;



    //获取bus的所有数据
    @Override
    public TableData findAll(int page, int pageSize) {
        PageHelper.startPage(page,pageSize);
        List<Bus> buses = busDao.findAll();
        PageInfo<Bus> pageInfo = new PageInfo<>(buses);
        return new TableData(0,"查询数据成功",(int)pageInfo.getTotal(),pageInfo.getList());
    }
    //添加bus
    @Override
    public void saveBus(Bus bus) throws Exception {
        busDao.saveBus(bus);
    }
    //通过公交车名字查找车
    @Override
    public TableData findByBusName(String key,int page,int pageSize) {
        PageHelper.startPage(page,pageSize);
        List<Bus> buses = busDao.findByBusName(key);
        PageInfo<Bus> pageInfo = new PageInfo<>(buses);
        return new TableData(0,"查询数据成功",(int)pageInfo.getTotal(),pageInfo.getList());
    }
    //通过公交车的id删除公交车
    @Override
    public void delBus(Integer busId){
        busDao.delBus(busId) ;
    }
    //通过公交车的id数组批量删除公交车
    @Override
    public void delAllBus(long[] busIds) {
        busDao.delAllBus(busIds) ;
    }
    //修改车辆信息的保存
    @Override
    public void updateBus(Bus bus) {
        busDao.updateBus(bus);
    }
    //通过公交车id查找车
    @Override
    public Bus findByBusId(int id) {
        Bus bus = busDao.findByBusId(id);
        return bus;
    }
    //获取所有的公交车信息
    @Override
    public List<Bus> getBusList() {
        return busDao.findAll();
    }
    //查询所有驾驶员的姓名
    @Override
    public List<IdAndName> findDriverName() {
        return busDao.findDriverName();
    }
    //查询所有线路的名称
    @Override
    public List<IdAndName> findLineName() {
        return busDao.findLineName();
    }



}
