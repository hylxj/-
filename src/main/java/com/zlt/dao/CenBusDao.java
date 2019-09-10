package com.zlt.dao;

import com.zlt.pojo.BarBean;
import com.zlt.pojo.BusCenter;

import java.util.List;

public interface CenBusDao {
    /**
     * 查询每个车站工作人员数量
     * @return
     */
    List<BarBean> selectCenWorkerNum();

    /**
     * 查询总站信息
     * @return
     */
    List<BusCenter> selectBusCenter();

    /**
     * 删除总站信息
     */
    void termDel(Integer id);

    /**
     *搜索总站信息
     */
    List<BusCenter> termSearch(String id);

    /**
     * 添加总站信息
     */
    void busTerminusAdd(BusCenter busCenter);

    /**
     * 查询更新页面并有数据
     */
    BusCenter busTerminusUpdatePage(Integer id);

    /**
     * 将查询出来的数据更新
     * @param busCenter
     */
    void busTerminusUpdate(BusCenter busCenter);

}
