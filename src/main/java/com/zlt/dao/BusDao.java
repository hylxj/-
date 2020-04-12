package com.zlt.dao;


import com.zlt.pojo.*;

import java.util.List;
import java.util.Map;

/**
 * 公交车bus的dao层
 */
public interface BusDao {
    //查询所有的bus
    List<BusLineDriver> findAll();
    //添加一个bus
    void saveBus(Bus bus);
    //通过公交车名字查询bus
    List<Map> findByBusName(String key);
    //通过公交车的id删除公交车
    void delBus(Integer busId);
    //通过公交车的id数组批量删除公交车
    void delAllBus(long[] busIds);
    //修改车辆信息的保存
    void updateBus(Bus bus);
    //通过公交车id查询bus
    Bus findByBusId(int id);
    //查找驾驶员的姓名
    List<IdAndName> findDriverName();
    //查找线路的名称
    List<IdAndName> findLineName();
    //找到驾驶员的ID和名字
    List<IdAndName> findAllIdAndName();
    //通过线路的Id查询线路的名称
    List<IdAndName> findAllLineIdAndName();
    //获得buslinedriver视图
    List<BusLineDriver> getBusList();
    /**
     * @Description:  添加报修车辆信息
     * @Param: [harmBus]
     * @Return: void
    **/
    void insertHarmBus(HarmBus harmBus);
    /**
     * @Description: 分页查询维修的车辆
     * @Param: []
     * @Return: java.util.List<java.util.Map>
    **/
    List<Map> findFixBus();
    /**
     * @Description: 查询维修车辆信息
     * @Param: [id]
     * @Return: com.zlt.pojo.HarmBus
    **/
    Map findFixBusById(int id);
    /**
     * @Description: 添加维修车辆信息记录
     * @Param: [fixBusLog]
     * @Return: void
    **/
    void fixBusLog(FixBusLog fixBusLog);
    /**
     * @Description: 查询维修记录
     * @Param: []
     * @Return: java.util.List<java.util.Map>
    **/
    List<Map> fixLogList();
}
