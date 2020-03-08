package com.zlt.pojo;

import lombok.Data;

import java.util.Date;

@Data
public class BusLineDriver {
    private  String busId;
    private  String busPlate;
    private String busName;
    private String busdriverId;
    private String busdriverName;
    private String busLineId ;
    private String lineName;
    private Date busCreatetime;
    private  int busStatus;
}
