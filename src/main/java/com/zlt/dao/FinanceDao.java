package com.zlt.dao;

import com.zlt.pojo.Expense;
import com.zlt.pojo.Income;

import java.util.List;

public interface FinanceDao {
    /**
     * 查询收入明细表
     */
    List<Income> selectIncome();

    /**
     * 查询支出明细表
     * @return
     */
    List<Expense> selectExpense();

    /**
     * 插入数据到支出表
     * @return
     */
    void expenseAdd(Expense expense);

    /**
     * 插入数据到收入表
     * @return
     */
    void incomeAdd(Income income);

    /**
     * 查找收入表单条数据
     * @return
     */
    Income selectOneIncome(Integer id);

    /**
     * 更新数据
     */
    void incomeUpdate(Income income);

    /**
     * 删除收入数据
     */
    void incomeDel(Integer id);

    /**
     * 收入表查询
     */
    List<Income> incomeSel(String busPlate);

    /**
     * 收入表批量删除
     */
    void incomeDels(Long[] ids);

    /**
     * 支出表查询
     */
    Expense expenseSel(Integer expenseId);

    /**
     * 支出表批量删除
     */
    void expenseDels(Long[] ids);

    /**
     * 查询支出表 单条信息
     * @param id
     * @return
     */
    Expense selectOneExpense(Integer id);
    /**
     * 更新数据
     */
    void expenseUpdate(Expense expense);

    /**
     * 删除支出表数据
     */
    void expenseDel(Integer id);
}
