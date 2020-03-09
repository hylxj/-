package com.zlt.service;

import com.github.pagehelper.PageInfo;
import com.zlt.pojo.BusCen;
import com.zlt.pojo.Role;

import java.util.List;

/**
 * @author huangyu
 * @date 2019-09-09-11:08
 */

public interface BusCenService {
    List<BusCen> treeLoad(Integer[] roleIds);

    PageInfo<BusCen> findAllBusCen(Integer page, Integer limit);

    void updateBusCen(BusCen busCen);

    PageInfo<BusCen> searchAllBusCen(Integer page, Integer limit, String key);

    void deleteByBusCenId(Integer buscenId);

    BusCen findBusCenById(Integer buscenId);

    void busCenAdd(BusCen busCen);

    List<Role> findRoleByBusCenId(Integer buscenId);

    void deleteRoleByBusCenId(Integer buscenId, Integer roleId);

    void insertBusCenRole(Integer buscenId, Integer roleId);
}
