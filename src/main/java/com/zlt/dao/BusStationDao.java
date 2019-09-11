package com.zlt.dao;

import com.zlt.pojo.BusLine;
import com.zlt.pojo.BusStation;

import java.util.List;

/**
 * 站台管理的持久层
 */
public interface BusStationDao {
    /**
     * 查询所有的站台信息
     * @return
     */
    List<BusStation> findAll();

    /**
     * 添加站台
     * @param staName
     */
    void saveStation(String staName);

    /**
     * 通过站台名称查询站台
     * @param s
     * @return
     */
    List<BusStation> findByStationName(String s);

    /**
     * 删除单个站点
     * @param staId
     */
    void delStation(Integer staId);

    /**
     * 通过id查询站台信息
     * @param id
     * @return
     */
    BusStation findByStationId(int id);

    /**
     * 修改站点信息的配置
     * @param busStation
     */
    void updateStation(BusStation busStation);

    /**
     * 查看经过站台的线路
     * @param staId
     * @return
     */
    List<BusLine> findLines(int staId);
}
