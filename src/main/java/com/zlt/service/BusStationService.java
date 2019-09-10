package com.zlt.service;

import com.zlt.pojo.BusStation;
import com.zlt.pojo.TableData;

/**
 * z站台管理业务层的接口
 */
public interface BusStationService {
    /**
     * 查询所有的站台信息
     * @param page
     * @param limit
     * @return
     */
    TableData findAll(int page, int limit);

    /***
     * 添加站台
     * @param staName
     */
    void saveStation(String staName);

    /**
     * 搜索站台
     * @param s
     * @param page
     * @param limit
     * @return
     */
    TableData findByStationName(String s, int page, int limit);

    /**
     * 删除单个站点
     * @param staId
     */
    void delStation(Integer staId);

    /**
     * 通过ID获取站台的信息
     * @param id
     * @return
     */
    BusStation findByStationId(int id);

    /**
     * 修改站点的保存
     * @param busStation
     */
    void updateStation(BusStation busStation);
}
