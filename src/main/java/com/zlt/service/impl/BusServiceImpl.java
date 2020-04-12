package com.zlt.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zlt.dao.BusDao;

import com.zlt.pojo.*;
import com.zlt.service.BusService;
import com.zlt.service.FinanceService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 公交车的serviceImpl
 */
@Service
public class BusServiceImpl implements BusService {
    @Resource
    private BusDao busDao;

    @Resource
    private FinanceService financeService;


    //获取bus的所有数据
    @Override
    public TableData findAll(int page, int pageSize) {
        PageHelper.startPage(page,pageSize);
        List<BusLineDriver> buses = busDao.findAll();
        PageInfo<BusLineDriver> pageInfo = new PageInfo<>(buses);
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
        List<Map> buses = busDao.findByBusName(key);
        PageInfo<Map> pageInfo = new PageInfo<>(buses);
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
    public List<BusLineDriver> getBusList() {
        return busDao.getBusList();
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

    //通过线路的Id查询线路的名称
    @Override
    public List<IdAndName> findAllLineIdAndName() {
        return busDao.findAllLineIdAndName();
    }
    /**
     * @Description: 报修车辆信息的保存
     * @Param: [busId, busFixReason]
     * @Return: void
    **/
    @Override
    public void fixBus(int busId, String busFixReason) {
        Bus bus = new Bus();
        HarmBus harmBus = new HarmBus();
        harmBus.setBusId(busId);
        harmBus.setFixReason(busFixReason);
        harmBus.setFixTime(new Date());
        bus.setBusId(busId);
        bus.setBusStatus(2);
        busDao.updateBus(bus);
        busDao.insertHarmBus(harmBus);
    }

    @Override
    public TableData findFixBus(int page, int pageSize) {
        PageHelper.startPage(page,pageSize);
        List<Map> maps = busDao.findFixBus();
        PageInfo<Map> pageInfo = new PageInfo<>(maps);
        return new TableData(0,"查询数据成功",(int)pageInfo.getTotal(),pageInfo.getList());
    }

    @Override
    public Map findFixBusById(int id) {
        return busDao.findFixBusById(id);
    }

    @Override
    public void addFixBusLog(int busId,int fixId,String fixMoney) {
        Subject currentUser = SecurityUtils.getSubject();
        Object sessionUser = currentUser.getSession().getAttribute("userName");
        FixBusLog fixBusLog = new FixBusLog();
        fixBusLog.setFixMoney(fixMoney);
        fixBusLog.setFixLogTime(new Date());
        fixBusLog.setFixer((String)sessionUser);
        fixBusLog.setHarmId(fixId);
        Bus bus = new Bus();
        FundOut fundOut = new FundOut();
        fundOut.setType(1);
        fundOut.setFundOutMoney(fixMoney);
        fundOut.setFundOutTime(new Date());
        fundOut.setOperator((String) sessionUser);
        fundOut.setStatus(1);
        fundOut.setHarmId(fixId);
        financeService.insertOutFund(fundOut);
        bus.setBusStatus(3);
        bus.setBusId(busId);
        System.out.println(sessionUser);
        busDao.updateBus(bus);
        busDao.fixBusLog(fixBusLog);
    }

    @Override
    public TableData fixLogList(int page, int limit) {
        PageHelper.startPage(page,limit);
        List<Map> maps = busDao.fixLogList();
        PageInfo<Map> pageInfo = new PageInfo<>(maps);
        return new TableData(0,"查询数据成功",(int)pageInfo.getTotal(),pageInfo.getList());
    }

    //找到驾驶员的ID和名字
    @Override
    public List<IdAndName> findAllIdAndName() {
        return busDao.findAllIdAndName();
    }


}
