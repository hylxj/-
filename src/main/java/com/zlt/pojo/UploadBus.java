package com.zlt.pojo;

import lombok.Data;

import java.util.Date;

/**
 * @ClassName UploadBus
 * @Description: TODO
 * @Author huangyu
 * @Date 2020/5/20
 **/
@Data
public class UploadBus {
    private String busPlate;
    private String busName;
    private String busdriverName;
    private  String lineName;
    private Date busCreateTime;
    private int busStatus;

    public UploadBus() {
    }

    public UploadBus(String busPlate, String busName, String busdriverName, String lineName, Date busCreateTime, int busStatus) {
        this.busPlate = busPlate;
        this.busName = busName;
        this.busdriverName = busdriverName;
        this.lineName = lineName;
        this.busCreateTime = busCreateTime;
        this.busStatus = busStatus;
    }
}
