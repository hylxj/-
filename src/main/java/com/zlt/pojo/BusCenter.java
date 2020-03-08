package com.zlt.pojo;

import java.util.Date;

public class BusCenter {
    private Integer buscenId;
    private String buscenName;
    private String buscenDistrict;
    private Integer buscenManagerid;
    private Date buscenCreatetime;
    private Integer buscenStatus;

    public Integer getBuscenId() {
        return buscenId;
    }

    public void setBuscenId(Integer buscenId) {
        this.buscenId = buscenId;
    }

    public String getBuscenName() {
        return buscenName;
    }

    public void setBuscenName(String buscenName) {
        this.buscenName = buscenName;
    }

    public String getBuscenDistrict() {
        return buscenDistrict;
    }

    public void setBuscenDistrict(String buscenDistrict) {
        this.buscenDistrict = buscenDistrict;
    }

    public Integer getBuscenManagerid() {
        return buscenManagerid;
    }

    public void setBuscenManagerid(Integer buscenManagerid) {
        this.buscenManagerid = buscenManagerid;
    }

    public Date getBuscenCreatetime() {
        return buscenCreatetime;
    }

    public void setBuscenCreatetime(Date buscenCreatetime) {
        this.buscenCreatetime = buscenCreatetime;
    }

    public Integer getBuscenStatus() {
        return buscenStatus;
    }

    public void setBuscenStatus(Integer buscenStatus) {
        this.buscenStatus = buscenStatus;
    }

    @Override
    public String toString() {
        return "BusCenter{" +
                "buscenId=" + buscenId +
                ", buscenName='" + buscenName + '\'' +
                ", buscenDistrict='" + buscenDistrict + '\'' +
                ", buscenManagerid=" + buscenManagerid +
                ", buscenCreatetime=" + buscenCreatetime +
                ", buscenStatus=" + buscenStatus +
                '}';
    }
}
