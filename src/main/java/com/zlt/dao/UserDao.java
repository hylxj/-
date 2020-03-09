package com.zlt.dao;

import com.zlt.pojo.BusCen;
import com.zlt.pojo.Role;
import com.zlt.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author huangyu
 * @date 2019-09-03-22:23
 */

public interface UserDao {
    User findByUsername(String username);

    List<User> findAllUser();

    List<User> searchUserList(String key);

    List<BusCen> findAllBusCenName();

    void insertUser(User user);

    User findAllById(Integer id);

    void userEdit(User user);

    void delUser(Integer id);

    void batchDelUser(Long[] userId);

    void updateLocked(@Param("id") Integer id,@Param("isLocked") Integer isLocked);

    void changePwd(@Param("username") String username,@Param("newPwd") String newPwd);

    void saveIcon(@Param("id") Integer id, @Param("icon") byte [] filename);

    List<Role> findRolesByUserId(Integer id);

    List<User> listByType(Integer type);
}
