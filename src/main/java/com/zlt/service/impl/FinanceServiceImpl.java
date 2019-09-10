package com.zlt.service.impl;

import com.zlt.dao.FinanceDao;
import com.zlt.pojo.Expense;
import com.zlt.pojo.Income;
import com.zlt.service.FinanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 *
 */
@Service
public class FinanceServiceImpl implements FinanceService {

    @Autowired
    private FinanceDao financeDao;

    /**
     * 查询收入信息
     * @return
     */
    @Override
    public List<Income> selectIncome() {
        List<Income> income = financeDao.selectIncome();
        return income;
    }

    /**
     * 查询支出信息
     */
    @Override
    public List<Expense> selectExpense(){
        List<Expense> expenses = financeDao.selectExpense();
        return expenses;
    }

    /**
     * 插入数据到支出表
     */
    @Override
    public void expenseAdd(Expense expense){
        financeDao.expenseAdd(expense);
    }

    /**
     * 插入数据到收入表
     */
    @Override
    public void incomeAdd(Income income){
        financeDao.incomeAdd(income);
    }

    /**
     * 将单条数据插入编辑表
     */
    @Override
    public Income selectOneIncome(Integer id){
        Income income = financeDao.selectOneIncome(id);
        return income;
    }

    /**
     * 更新数据到数据表
     */
    @Override
    public void incomeUpdate(Income income){
        financeDao.incomeUpdate(income);
    }

    /**
     * 删除收入表数据
     */
    @Override
    public void incomeDel(Integer id){
        financeDao.incomeDel(id);
    }

    /**
     * 收入表查询
     */
    @Override
    public List<Income> incomeSel(String busPlate){
        List<Income> incomes = financeDao.incomeSel("%"+ busPlate +"%");
        return incomes;
    }

    /**
     * 收入表批量删除
     */
    @Override
    public void incomeDels(Long[] ids){
        financeDao.incomeDels(ids);
    }

    /**
     * 支出表查询
     */
    @Override
    public Expense expenseSel(Integer expenseId) {
        Expense expenses = financeDao.expenseSel(expenseId);
        return expenses;
    }

    /**
     * 支出表批量删除
     */
    @Override
    public void expenseDels(Long[] ids) {
        financeDao.expenseDels(ids);
    }

    /**
     * 查询支出表 单条记录插入编辑表
     * @param id
     * @return
     */
    @Override
    public Expense selectOneExpense(Integer id) {
        Expense expense = financeDao.selectOneExpense(id);
        return expense;
    }

    /**
     * 更新支出表数据
     * @param expense
     */
    @Override
    public void expenseUpdate(Expense expense) {
        financeDao.expenseUpdate(expense);
    }

    /**
     * 删除支出表数据
     */
    @Override
    public void expenseDel(Integer id) {
        financeDao.expenseDel(id);
    }


}
