package com.zlt.service;

import com.zlt.pojo.*;

import java.util.List;
import java.util.Map;

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
/**
 * @Description: 报修车辆信息的保存
 * @Param: [busId, busFixReason]
 * @Return: void
**/
    void fixBus(int busId, String busFixReason);
    /**
     * @Description: 查询维修信息
     * @Param: []
     * @Return: com.zlt.pojo.TableData
    **/
    TableData findFixBus(int page, int pageSize);
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
    void addFixBusLog(int busId,int fixId,String fixMoney);
    /**
     * @Description: 查询维修记录
     * @Param: [page, limit]
     * @Return: com.zlt.pojo.TableData
    **/
    TableData fixLogList(int page, int limit);
    /**
     * @Description: 获取导出的车辆信息
     * @Param: []
     * @Return: java.util.List<com.zlt.pojo.BusLineDriver>
    **/
    List<BusLineDriver> getExportBus(long [] busIds);
    /**
     * @Description:添加Excel导入的数据
     * @Param: [bus]
     * @Return: void
    **/
    String addUploadBus(UploadBus bus) ;

    void delFixBus(int busId);
}
