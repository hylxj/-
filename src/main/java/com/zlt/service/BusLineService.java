package com.zlt.service;

import com.zlt.pojo.*;

import java.util.List;

/**
 * 公交车路线管理
 */
public interface BusLineService {
    //列表显示所有线路数据
    TableData findAll(int page, int limit);
    //通过线路名称查询线路信息
    TableData findByLineName(String key, int page, int limit);
    //删除单条路线
    void delLine(Integer lineId);
    //添加路线
    void saveLine(String lineName, String lineTime, String linePrice, int[] station);
    //通过线路id查找线路
    BusLine findByLineId(int id);
    //修改的线路信息的保存
    void updateLine(BusLine line);
    //通过线路名称查询站台信息
    List<LineStaView> findStaByLineName(String lineName);
    //获取所有的站台信息
    List<BusStation> findAllStation();
}
