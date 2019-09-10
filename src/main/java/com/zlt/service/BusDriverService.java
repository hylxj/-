package com.zlt.service;

import com.zlt.pojo.BusDriver;

import java.util.List;

public interface BusDriverService {
    /**
     * 查询司机信息
     */
    List<BusDriver> selectDriver();

    /**
     * 搜索司机，模糊搜索
     */
    List<BusDriver> driverSel(String name);

    /**
     * 添加司机信息
     * @param busDriver
     */
    void driverAdd(BusDriver busDriver);

    /**
     * 批量删除
     */
    void driverDels(Long[] ids);

    /**
     * 编辑司机信息
     * 包含一条信息
     */
    BusDriver selectOneDriver(Integer id);

    /**
     * 将司机信息更新
     */
    void driverUpdate(BusDriver busDriver);

    /**
     * 删除数据
     */
    void driverDel(Integer id);
}
