package com.zlt.service.impl;

import com.zlt.dao.BusDriverDao;
import com.zlt.pojo.BusDriver;
import com.zlt.service.BusDriverService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BusDriverServiceImpl implements BusDriverService {
    @Autowired
    private BusDriverDao busDriverDao;

    /**
     * 查询司机信息
     * @return
     */
    @Override
    public List<BusDriver> selectDriver() {
        List<BusDriver> busDrivers = busDriverDao.selectDriver();
        return busDrivers;
    }

    /**
     * 搜索司机，模糊搜索
     */
    @Override
    public List<BusDriver> driverSel(String name) {
        List<BusDriver> busDrivers = busDriverDao.driverSel("%"+name+"%");
        return busDrivers;
    }

    /**
     * 添加司机信息
     */
    @Override
    public void driverAdd(BusDriver busDriver) {
        busDriverDao.driverAdd(busDriver);
    }

    /**
     * 批量删除
     */
    @Override
    public void driverDels(Long[] ids) {
        busDriverDao.driverDels(ids);
    }

    /**
     * 编辑司机信息
     * 包含一条数据
     */
    @Override
    public BusDriver selectOneDriver(Integer id) {
        BusDriver busDriver = busDriverDao.selectOneDriver(id);
        System.out.println("----------------------------------------"+busDriver);
        return busDriver;
    }

    /**
     * 将司机信息更新
     */
    @Override
    public void driverUpdate(BusDriver busDriver) {
        busDriverDao.driverUpdate(busDriver);
    }

    /**
     * 删除数据
     */
    @Override
    public void driverDel(Integer id) {
        busDriverDao.driverDel(id);
    }
}
