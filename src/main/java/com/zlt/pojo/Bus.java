package com.zlt.pojo;

import java.io.Serializable;
import java.util.Date;

public class Bus implements Serializable {
    private int busId;
    private String busPlate;
    private String busName;
    private int busDriverId;
    private int busLineId;
    private Date busCreateTime;
    private int busStatus;

    public Bus() {
    }

    public Bus(String busPlate, String busName, int busDriverId, int busLineId, Date busCreateTime, int busStatus) {
        this.busPlate = busPlate;
        this.busName = busName;
        this.busDriverId = busDriverId;
        this.busLineId = busLineId;
        this.busCreateTime = busCreateTime;
        this.busStatus = busStatus;
    }

    public Bus(int busId, String busPlate, String busName, int busDriverId, int busLineId, Date busCreateTime, int busStatus) {
        this.busId = busId;
        this.busPlate = busPlate;
        this.busName = busName;
        this.busDriverId = busDriverId;
        this.busLineId = busLineId;
        this.busCreateTime = busCreateTime;
        this.busStatus = busStatus;
    }

    public int getBusId() {
        return busId;
    }

    public void setBusId(int busId) {
        this.busId = busId;
    }

    public String getBusPlate() {
        return busPlate;
    }

    public void setBusPlate(String busPlate) {
        this.busPlate = busPlate;
    }

    public String getBusName() {
        return busName;
    }

    public void setBusName(String busName) {
        this.busName = busName;
    }

    public int getBusDriverId() {
        return busDriverId;
    }

    public void setBusDriverId(int busDriverId) {
        this.busDriverId = busDriverId;
    }

    public int getBusLineId() {
        return busLineId;
    }

    public void setBusLineId(int busLineId) {
        this.busLineId = busLineId;
    }

    public Date getBusCreateTime() {
        return busCreateTime;
    }

    public void setBusCreateTime(Date busCreateTime) {
        this.busCreateTime = busCreateTime;
    }

    public int getBusStatus() {
        return busStatus;
    }

    public void setBusStatus(int busStatus) {
        this.busStatus = busStatus;
    }

    @Override
    public String toString() {
        return "Bus{" +
                "busId=" + busId +
                ", busPlate='" + busPlate + '\'' +
                ", busName='" + busName + '\'' +
                ", busDriverId=" + busDriverId +
                ", busLineId=" + busLineId +
                ", busCreateTime=" + busCreateTime +
                ", busStatus=" + busStatus +
                '}';
    }
}
