package com.zlt.dao;

import com.zlt.pojo.Account;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 账户dao接口
 */
public interface AccountDao {

    //查询所有账户
    @Select("select * from account")
    List<Account> findAll();

    //保存账户信息
    @Insert("insert into account (name,money) values(#{name},#{money})")
    void savaAccount(Account account);
}
