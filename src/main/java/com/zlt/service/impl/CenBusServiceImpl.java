package com.zlt.service.impl;

import com.zlt.dao.CenBusDao;
import com.zlt.pojo.BarBean;
import com.zlt.pojo.BusCenter;
import com.zlt.service.CenBusService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class CenBusServiceImpl implements CenBusService {
    @Autowired
    private CenBusDao cenBusDao;

    /**
     * 返回总站工作人员
     * @return
     */
    @Override
    public List<BarBean> selectCenWorkerNum() {
        List<BarBean> barBeans = cenBusDao.selectCenWorkerNum();
        return barBeans;
    }

    /**
     * 返回总站的数据
     * @return
     */
    @Override
    public List<BusCenter> selectBusCenter(){
        List<BusCenter> busCenters = cenBusDao.selectBusCenter();
        return busCenters;
    }

    /**
     * 删除公交总站信息
     */
    @Override
    public void termDel(Integer id) {
        cenBusDao.termDel(id);
    }

    /**
     * 搜索总站信息
     */
    @Override
    public List<BusCenter> termSearch(Integer id) {
        List<BusCenter> busCenters = cenBusDao.termSearch("%"+String.valueOf(id)+"%");
        return busCenters;
    }

    /**
     * 添加站点信息
     * @param busCenter
     */
    @Override
    public void busTerminusAdd(BusCenter busCenter) {
        cenBusDao.busTerminusAdd(busCenter);
    }

    /**
     * 查询更新页面并有数据数据
     */
    @Override
    public BusCenter busTerminusUpdatePage(Integer id) {
        BusCenter busCenter = cenBusDao.busTerminusUpdatePage(id);
        return busCenter;
    }
    /**
     * 将查出来的数据更新
     */
    @Override
    public void busTerminusUpdate(BusCenter busCenter) {
        cenBusDao.busTerminusUpdate(busCenter);
    }
}
