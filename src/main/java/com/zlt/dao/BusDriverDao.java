package com.zlt.dao;

import com.zlt.pojo.BusDriver;

import java.util.List;
import java.util.Map;

public interface BusDriverDao {
    /**
     * 查询司机信息表
     */
    List<BusDriver> selectDriver();

    /**
     * 查询司机，模糊搜索
     */
    List<BusDriver> driverSel(String name);

    /**
     * 添加司机信息
     */
    void driverAdd(BusDriver busDriver);

    /**
     * 批量删除
     * @param ids
     */
    void driverDels(Long[] ids);

    /**
     * 编辑司机信息
     * 包含一条数据
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
    /**
     * @Description: 通过司机姓名查询司机ID
     * @Param: [busdriverName]
     * @Return: void
    **/
    Map<String,Integer> findIdByname(String busdriverName);
}
