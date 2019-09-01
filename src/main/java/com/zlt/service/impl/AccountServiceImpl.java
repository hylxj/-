package com.zlt.service.impl;

import com.zlt.dao.AccountDao;
import com.zlt.pojo.Account;
import com.zlt.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("accountService")
public class AccountServiceImpl implements AccountService {

    @Autowired
    private AccountDao accountDao;

    @Override
    public List<Account> findAll() {
        System.out.println("业务层，查询所有账户...");
        return accountDao.findAll();
    }

    @Override
    public void savaAccount(Account account) {
        accountDao.savaAccount(account);
        System.out.println("业务层，保存账户...");
    }
}
