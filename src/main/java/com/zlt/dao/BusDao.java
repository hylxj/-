package com.zlt.dao;


import com.zlt.pojo.Bus;
import com.zlt.pojo.BusLineDriver;
import com.zlt.pojo.IdAndName;

import java.util.List;

/**
 * 公交车bus的dao层
 */
public interface BusDao {
    //查询所有的bus
    List<BusLineDriver> findAll();
    //添加一个bus
    void saveBus(Bus bus);
    //通过公交车名字查询bus
    List<Bus> findByBusName(String key);
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
}
