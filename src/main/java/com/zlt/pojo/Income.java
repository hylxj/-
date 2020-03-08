package com.zlt.pojo;

import java.util.Date;

public class Income {
    private int incomeId;
    private String busPlate;
    private Date incomeTime;
    private double incomeCash;
    private double incomeOnline;
    private double incomeCard;
    private double incomedayTotal;

    public int getIncomeId() {
        return incomeId;
    }

    public void setIncomeId(int incomeId) {
        this.incomeId = incomeId;
    }

    public String getBusPlate() {
        return busPlate;
    }

    public void setBusPlate(String busPlate) {
        this.busPlate = busPlate;
    }

    public Date getIncomeTime() {
        return incomeTime;
    }

    public void setIncomeTime(Date incomeTime) {
        this.incomeTime = incomeTime;
    }

    public double getIncomeCash() {
        return incomeCash;
    }

    public void setIncomeCash(double incomeCash) {
        this.incomeCash = incomeCash;
    }

    public double getIncomeOnline() {
        return incomeOnline;
    }

    public void setIncomeOnline(double incomeOnline) {
        this.incomeOnline = incomeOnline;
    }

    public double getIncomeCard() {
        return incomeCard;
    }

    public void setIncomeCard(double incomeCard) {
        this.incomeCard = incomeCard;
    }

    public double getIncomedayTotal() {
        return incomedayTotal;
    }

    public void setIncomedayTotal(double incomedayTotal) {
        this.incomedayTotal = incomedayTotal;
    }

    @Override
    public String toString() {
        return "Income{" +
                "incomeId=" + incomeId +
                ", busPlate=" + busPlate +
                ", incomeTime=" + incomeTime +
                ", incomeCash=" + incomeCash +
                ", incomeOnline=" + incomeOnline +
                ", incomeCard=" + incomeCard +
                ", incomedayTotal=" + incomedayTotal +
                '}';
    }
}
