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
    private int fixId;

}
