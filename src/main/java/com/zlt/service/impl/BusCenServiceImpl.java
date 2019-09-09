package com.zlt.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zlt.dao.BusCenDao;
import com.zlt.pojo.BusCen;
import com.zlt.pojo.Role;
import com.zlt.service.BusCenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @author shushu
 * @date 2019-09-09-11:10
 */
@Service
public class BusCenServiceImpl implements BusCenService {
    @Autowired
    private BusCenDao busCenDao;

    /**
     * 加载菜单树
     * @param roleIds
     * @return
     */
    @Override
    public List<BusCen> treeLoad(Integer[] roleIds) {
        List<BusCen> busCens= busCenDao.findAllBusCenByRole(roleIds);
        List<BusCen> treeBusCens=new ArrayList<>();
        for (BusCen busCen : busCens) {
            if (busCen.getParentId()==null){
                treeBusCens.add(findChildren(busCen,busCens));
            }
        }
        return treeBusCens;
    }

    /**
     * 递归查找子节点
     * @param busCen
     * @param busCens
     * @return
     */
    private BusCen findChildren(BusCen busCen, List<BusCen> busCens) {
        for (BusCen item : busCens) {
            if (busCen.getId()==item.getParentId()){
                if (busCen.getChildren()==null){
                    busCen.setChildren(new ArrayList<>());
                }
                busCen.getChildren().add(findChildren(item,busCens));
            }
        }
        return busCen;
    }

    @Override
    public PageInfo<BusCen> findAllBusCen(Integer page, Integer limit) {
        PageHelper.startPage(page,limit);
        List<BusCen> busCens = busCenDao.findAllBusCen();
        return new PageInfo<>(busCens);
    }

    @Override
    public void updateBusCen(BusCen busCen) {
        busCenDao.updateBusCen(busCen);
    }

    @Override
    public PageInfo<BusCen> searchAllBusCen(Integer page, Integer limit, String key) {
        char[] chars = key.toCharArray();
        String busCenName="%";
        for (char c:chars){
            busCenName+=c+"%";
        }
        PageHelper.startPage(page,limit);
        List<BusCen> busCens = busCenDao.searchAllBusCen(busCenName);
        return new PageInfo<>(busCens);
    }

    @Override
    public void deleteByBusCenId(Integer buscenId) {
        busCenDao.deleteByBusCenId(buscenId);
    }

    @Override
    public BusCen findBusCenById(Integer buscenId) {
        return busCenDao.findBusCenById(buscenId);
    }

    @Override
    public void busCenAdd(BusCen busCen) {
        busCenDao.insertBusCen(busCen);
    }

    @Override
    public List<Role> findRoleByBusCenId(Integer buscenId) {
        return busCenDao.findRoleByBusCenId(buscenId);
    }

    @Override
    public void deleteRoleByBusCenId(Integer buscenId, Integer roleId) {
        busCenDao.deleteRoleByBusCenId(roleId,buscenId);
    }

    @Override
    public void insertBusCenRole(Integer buscenId, Integer roleId) {
        busCenDao.insertBusCenRole(roleId,buscenId);
    }
}
