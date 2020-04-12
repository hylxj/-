package com.zlt.pojo;


import lombok.Data;

import java.util.Date;

/**
 * @ClassName FixBusLog
 * @Description: 车辆维修记录
 * @Author huangyu
 * @Date 2020/4/6
 * @Version V1.0
 **/
@Data
public class FixBusLog {
    private int fixLogId;
    private int harmId;
    private String fixer;
    private Date fixLogTime;
    private String fixMoney;
}
