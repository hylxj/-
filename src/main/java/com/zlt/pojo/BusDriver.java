package com.zlt.pojo;

import lombok.Data;

import java.util.Date;
@Data
public class BusDriver {
    private Integer busdriverId;
    private String busdriverName;
    private Integer busdriverAge;
    private Integer busdriverSex;
    private String busdriverPhone;
    private Integer busdriverBusid;
    private Integer busdriverBelongid;
    private Date busdriverInitime;
    private Integer busdriverStatus;
    private String driverIdCard;

}
