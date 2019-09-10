package com.zlt.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zlt.dao.BusStationDao;
import com.zlt.pojo.BusStation;
import com.zlt.pojo.TableData;
import com.zlt.service.BusStationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 站台管理的业务层
 */
@Service
public class BusStationServiceImpl  implements BusStationService {
    @Autowired
    private BusStationDao busStationDao;
    /**
     * 查询所有的站台信息
     * @param page
     * @param limit
     * @return
     */
    @Override
    public TableData findAll(int page, int limit) {
        PageHelper.startPage(page,limit);
        List <BusStation> list= busStationDao.findAll();
        PageInfo <BusStation> pageInfo = new PageInfo<>(list);
        return new TableData(0,"查询数据成功",(int)pageInfo.getTotal(),pageInfo.getList());
    }

    /**
     * 增加站台
     * @param staName
     */
    @Override
    public void saveStation(String staName) {
        busStationDao.saveStation(staName);
    }

    /**
     * 通过站台名称查询站点
     * @param s
     * @param page
     * @param limit
     * @return
     */
    @Override
    public TableData findByStationName(String s, int page, int limit) {
        PageHelper.startPage(page,limit);
        List<BusStation> list = busStationDao.findByStationName(s);
        PageInfo<BusStation> pageInfo = new PageInfo<>(list);
        return new TableData(0,"查询数据成功",(int)pageInfo.getTotal(),pageInfo.getList());
    }

    /**
     * 删除单个站点
     * @param staId
     */
    @Override
    public void delStation(Integer staId) {
        busStationDao.delStation(staId);
    }

    /**
     * 通过id查询站台的信息
     * @param id
     * @return
     */
    @Override
    public BusStation findByStationId(int id) {
        return busStationDao.findByStationId(id);
    }

    /**
     * 修改站点的保存
     * @param busStation
     */
    @Override
    public void updateStation(BusStation busStation) {
        busStationDao.updateStation(busStation);
    }
}
