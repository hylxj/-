package com.zlt.pojo;

import lombok.Data;

import java.util.Date;

/**
 * @ClassName FundOut
 * @Description: 支出记录
 * @Author huangyu
 * @Date 2020/4/6
 * @Version V1.0
 **/
@Data
public class FundOut {
    private  int fundOutId;
    private int type;
    private Date fundOutTime;
    private String fundOutMoney;
    private int status;
    private String operator;
    private String department;

    public int getFundOutId() {
        return fundOutId;
    }

    public void setFundOutId(int fundOutId) {
        this.fundOutId = fundOutId;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public Date getFundOutTime() {
        return fundOutTime;
    }

    public void setFundOutTime(Date fundOutTime) {
        this.fundOutTime = fundOutTime;
    }

    public String getFundOutMoney() {
        return fundOutMoney;
    }

    public void setFundOutMoney(String fundOutMoney) {
        this.fundOutMoney = fundOutMoney;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public int getHarmId() {
        return harmId;
    }

    public void setHarmId(int harmId) {
        this.harmId = harmId;
    }

    private int harmId;

}
