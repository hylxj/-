package com.zlt.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zlt.pojo.Expense;
import com.zlt.pojo.Income;
import com.zlt.pojo.ResultData;
import com.zlt.pojo.ResultTable;
import com.zlt.service.FinanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;
@Controller
public class FinanceController {
    @Autowired
    private FinanceService financeService;

    /**
     * 请求收入页面
     * @return
     */
    @RequestMapping("/incomePage")
    public String IncomePage(){
        return "finance/income";
    }
    /**
     * 收入表
     * @return
     */
    @RequestMapping("/income")
    @ResponseBody
    public ResultTable getIncome(Integer page,Integer limit){
        PageHelper.startPage(page,limit);
        List<Income> incomes = financeService.selectIncome();
        PageInfo<Income> pageInfo = new PageInfo<>(incomes);
        ResultTable resultTable = new ResultTable(0,"",(int)pageInfo.getTotal(),pageInfo.getList());
        return resultTable;
    }


    /**
     * 请求支出页面
     * @return
     */
    @RequestMapping("/expensePage")
    public String ExpensePage(){
        return "finance/expense";
    }
    /**
     * 支出表
     * @return
     */
    @RequestMapping("/expense")
    @ResponseBody
    public ResultTable getExpense(Integer page,Integer limit){
        PageHelper.startPage(page,limit);
        List<Expense> expenses = financeService.selectExpense();
        PageInfo<Expense> pageInfo = new PageInfo<>(expenses);
        ResultTable resultTable = new ResultTable(0,"",(int)pageInfo.getTotal(),pageInfo.getList());
        return resultTable;
    }

    /**
     * 请求添加支出页面
     * @return
     */
    @RequestMapping("/expenseAddPage")
    public String expenseAddPage(){
        return "finance/expenseAdd";
    }
    /**
     * 添加支出
     * @return
     */
    @RequestMapping("/expenseAdd")
    @ResponseBody
    public ResultData expenseAdd(Expense expense){
        financeService.expenseAdd(expense);
        ResultData resultData = new ResultData(0,"");
        return resultData;
    }


    /**
     * 请求添加收入页面
     * @return
     */
    @RequestMapping("/incomeAddPage")
    public String incomeAddPage(){
        return "finance/incomeAdd";
    }
    /**
     * 添加收入
     * @return
     */
    @RequestMapping("/incomeAdd")
    @ResponseBody
    public ResultData incomeAdd(Income income){
        financeService.incomeAdd(income);
        ResultData resultData = new ResultData(0,"");
        return resultData;
    }

    /**
     * 编辑界面，先查找数据到页面
     * 请求添加收入页面
     * @return
     */
    @RequestMapping("/incomeUpdatePage")
    public String incomeUpdatePage(Integer id, Model model){
        Income income = financeService.selectOneIncome(id);
        model.addAttribute("income",income);
        return "finance/incomeUpdate";
    }
    /**
     * 将数据更新
     */
    @RequestMapping("/incomeUpdate")
    @ResponseBody
    public ResultData incomeUpdate(Income income){
        financeService.incomeUpdate(income);
        ResultData resultData = new ResultData(0,"");
        return  resultData;
    }

    /**
     * 删除选中的数据
     */
    @RequestMapping("/incomeDel")
    @ResponseBody
    public String incomeDel(Integer id){
        System.out.println(id);
        financeService.incomeDel(id);
        return "finance/income";
    }

    /**
     * 收入表查询
     */
    @RequestMapping("/incomeSel")
    @ResponseBody
    public ResultTable incomeSel(String busPlate){
        List<Income> incomes = financeService.incomeSel(busPlate);
        ResultTable resultTable = new ResultTable(0,"",incomes.size(),incomes);
        return resultTable;
    }

    /**
     * 收入表批量删除
     */
    @RequestMapping("incomeDels")
    @ResponseBody
    public String incomeDels(@RequestParam("ids[]") Long[] ids){
        financeService.incomeDels(ids);
        return "finance/income";
    }

    /**
     * 支出查询
     */
    @RequestMapping("/expenseSel")
    @ResponseBody
    public ResultTable expenseSel(Integer expenseId){
        Expense expense = financeService.expenseSel(expenseId);
        List<Expense> expenses=new ArrayList<>();
        expenses.add(expense);
        ResultTable resultTable = new ResultTable(0,"",1,expenses);
        return resultTable;
    }

    /**
     * 支出表批量删除
     */
    @RequestMapping("expenseDels")
    @ResponseBody
    public String expenseDels(@RequestParam("ids[]") Long[] ids){
        for (long i:ids){
            System.out.println("-------------->"+i);
        }
        financeService.expenseDels(ids);
        return "finance/expense";
    }

    /**
     * 编辑界面，先查找数据到页面
     * 请求添加支出页面
     * @return
     */
    @RequestMapping("/expenseUpdatePage")
    public String expenseUpdatePage(Integer id, Model model){
        Expense expense = financeService.selectOneExpense(id);
        model.addAttribute("expense",expense);
        return "finance/expenseUpdate";
    }
    /**
     * 将数据更新
     */
    @RequestMapping("/expenseUpdate")
    @ResponseBody
    public ResultData expenseUpdate(Expense expense){
        financeService.expenseUpdate(expense);
        ResultData resultData = new ResultData(0,"");
        return  resultData;
    }

    /**
     * 删除支出表数据
     */
    @RequestMapping("/expenseDel")
    @ResponseBody
    public String expenseDel(Integer id){
        financeService.expenseDel(id);
        return "finance/expense";
    }


}
