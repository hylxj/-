package com.zlt.service;

import com.zlt.pojo.BarBean;
import com.zlt.pojo.BusCenter;

import java.util.List;

public interface CenBusService {
    /**
     * 查询每个车站工作人员数量
     * @return
     */
    List<BarBean> selectCenWorkerNum();

    /**
     * 查询总站信息
     */
    List<BusCenter> selectBusCenter();

    /**
     * 删除总站记录
     */
    void termDel(Integer id);

    /**
     * 搜索总站信息
     */
    List<BusCenter> termSearch(Integer id);

    /**
     * 添加站点信息
     */
    void busTerminusAdd(BusCenter busCenter);

    /**
     * 查询更新页面并有数据数据
     */
    BusCenter busTerminusUpdatePage(Integer id);
    /**
     * 更新查出来的数据
     */
    void busTerminusUpdate(BusCenter busCenter);

}
