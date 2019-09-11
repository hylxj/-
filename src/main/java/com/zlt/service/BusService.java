package com.zlt.service;

import com.zlt.pojo.Bus;
import com.zlt.pojo.BusLineDriver;
import com.zlt.pojo.IdAndName;
import com.zlt.pojo.TableData;

import java.util.List;

/**
 * bus的service
 */
public interface BusService {
    //获取bus的所有数据
    TableData findAll(int page, int pageSize);
    //添加bus
    void saveBus(Bus bus) throws Exception;
    //通过公交车名字查找车
    TableData findByBusName(String key, int page, int pageSize);
    //通过公交车的id删除公交车
    void delBus(Integer busId);
    //通过公交车的id数组批量删除公交车
    void delAllBus(long[] busIds);
    //修改车辆信息的保存
    void updateBus(Bus bus);
    //通过公交车id查找车
    Bus findByBusId(int id);
    //获取公交车所有的信息
    List<BusLineDriver> getBusList();
    //查询所有的驾驶员姓名
    List<IdAndName> findDriverName();
    //查询所有的线路名称
    List<IdAndName> findLineName();
    //找到驾驶员的ID和名字
    List<IdAndName> findAllIdAndName();
    //通过线路的Id查询线路的名称
    List<IdAndName> findAllLineIdAndName();
}
