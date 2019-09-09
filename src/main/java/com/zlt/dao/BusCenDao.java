package com.zlt.dao;

import com.zlt.pojo.BusCen;
import com.zlt.pojo.Role;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author shushu
 * @date 2019-09-09-10:37
 */

public interface BusCenDao {
    List<BusCen> findAllBusCenByRole(Integer[] roleIds);

    List<BusCen> findAllBusCen();

    List<BusCen> searchAllBusCen(String title);

    void deleteByBusCenId(Integer buscenId);

    void insertBusCen(BusCen busCen);

    void updateBusCen(BusCen busCen);

    BusCen findBusCenById(Integer buscenId);

    List<Role> findRoleByBusCenId(Integer buscenId);

    void deleteRoleByBusCenId(@Param("roleId") Integer roleId, @Param("buscenId") Integer buscenId);

    void insertBusCenRole(@Param("roleId") Integer roleId,@Param("buscenId") Integer buscenId);
}
