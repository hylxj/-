package com.zlt.service;

import com.zlt.pojo.Expense;
import com.zlt.pojo.Income;

import java.util.List;

public interface FinanceService {
    /**
     * 查询收入表信息
     * @return
     */
    List<Income> selectIncome();

    /**
     * 查询支出表信息
     * @return
     */
    List<Expense> selectExpense();

    /**
     * 插入数据到支出表
     */
    void expenseAdd(Expense expense);

    /**
     * 插入数据到收入表
     * @param income
     */
    void incomeAdd(Income income);

    /**
     * 查找收入表单条数据
     * @param id
     */
    Income selectOneIncome(Integer id);

    /**
     * 更新收入表数据
     */
    void incomeUpdate(Income income);

    /**
     * 删除收入表数据
     * @param id
     */
    void incomeDel(Integer id);

    /**
     * 收入表查询
     * @param busPlate
     * @return
     */
    List<Income> incomeSel(String busPlate);

    /**
     * 收入表批量删除
     * @param ids
     */
    void incomeDels(Long[] ids);

    /**
     * 支出表查询
     * @param expenseId
     * @return
     */
    Expense expenseSel(Integer expenseId);

    /**
     * 支出表批量删除
     * @param ids
     */
    void expenseDels(Long[] ids);

    /**
     * 查找支出表 单条数据
     * @param id
     */
    Expense selectOneExpense(Integer id);
    /**
     * 将支出表数据更新
     */
    void expenseUpdate(Expense expense);

    /**
     * 删除支出表数据
     */
    void expenseDel(Integer id);

}
