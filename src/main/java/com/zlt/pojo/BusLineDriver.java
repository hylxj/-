package com.zlt.pojo;

import lombok.Data;

import java.util.Date;

@Data
public class BusLineDriver {
    private  String busPlate;
    private String busName;
    private String busdriverName;
    private String lineName;
    private Date busCreatetime;
    private  int busStatus;
}
