package com.zlt.pojo;

import java.util.Date;

public class Expense {
    private Integer expenseId;
    private Double expenseSalary;
    private Double expenseFix;
    private Double expenseDaily;
    private Date expenseTime;
    private Integer expenseStaId;
    private Integer expenseHendler;
    private Double expanseTotal;

    public Integer getExpenseId() {
        return expenseId;
    }

    public void setExpenseId(Integer expenseId) {
        this.expenseId = expenseId;
    }

    public Double getExpenseSalary() {
        return expenseSalary;
    }

    public void setExpenseSalary(Double expenseSalary) {
        this.expenseSalary = expenseSalary;
    }

    public Double getExpenseFix() {
        return expenseFix;
    }

    public void setExpenseFix(Double expenseFix) {
        this.expenseFix = expenseFix;
    }

    public Double getExpenseDaily() {
        return expenseDaily;
    }

    public void setExpenseDaily(Double expenseDaily) {
        this.expenseDaily = expenseDaily;
    }

    public Date getExpenseTime() {
        return expenseTime;
    }

    public void setExpenseTime(Date expenseTime) {
        this.expenseTime = expenseTime;
    }

    public Integer getExpenseStaId() {
        return expenseStaId;
    }

    public void setExpenseStaId(Integer expenseStaId) {
        this.expenseStaId = expenseStaId;
    }

    public Integer getExpenseHendler() {
        return expenseHendler;
    }

    public void setExpenseHendler(Integer expenseHendler) {
        this.expenseHendler = expenseHendler;
    }

    public Double getExpanseTotal() {
        return expanseTotal;
    }

    public void setExpanseTotal(Double expanseTotal) {
        this.expanseTotal = expanseTotal;
    }

    @Override
    public String toString() {
        return "Expense{" +
                "expenseId=" + expenseId +
                ", expenseSalary=" + expenseSalary +
                ", expenseFix=" + expenseFix +
                ", expenseDaily=" + expenseDaily +
                ", expenseTime=" + expenseTime +
                ", expenseStaId=" + expenseStaId +
                ", expenseHendler=" + expenseHendler +
                ", expanseTotal=" + expanseTotal +
                '}';
    }
}
