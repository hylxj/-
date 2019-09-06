package com.zlt.service;

import com.github.pagehelper.PageInfo;
import com.zlt.pojo.BusCen;
import com.zlt.pojo.ResultData;
import com.zlt.pojo.ResultTable;
import com.zlt.pojo.User;
import org.springframework.dao.DataAccessException;

import java.util.List;

/**
 * @author shushu
 * @date 2019-09-03-22:21
 */

public interface UserService {
    User findByUsername(String username);

    PageInfo<User> findAllUser(Integer page, Integer pageSize);

    ResultTable searchUserList(String key);

    List<BusCen> findAllBusCenName();

    void userAdd(User user)throws DataAccessException;

    User findAllById(Integer id);

    void userEdit(User user);

    void delUser(Integer id);

    void batchDelUser(Long[] userId);

    void updateLocked(Integer id, Integer isLocked);

    ResultData verifyOldPwd(String username,String password);

    void updatePwd(String username, String password);
}
