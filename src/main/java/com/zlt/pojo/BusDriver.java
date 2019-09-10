package com.zlt.pojo;

import java.util.Date;

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

    public Integer getBusdriverId() {
        return busdriverId;
    }

    public void setBusdriverId(Integer busdriverId) {
        this.busdriverId = busdriverId;
    }

    public String getBusdriverName() {
        return busdriverName;
    }

    public void setBusdriverName(String busdriverName) {
        this.busdriverName = busdriverName;
    }

    public Integer getBusdriverAge() {
        return busdriverAge;
    }

    public void setBusdriverAge(Integer busdriverAge) {
        this.busdriverAge = busdriverAge;
    }

    public Integer getBusdriverSex() {
        return busdriverSex;
    }

    public void setBusdriverSex(Integer busdriverSex) {
        this.busdriverSex = busdriverSex;
    }

    public String getBusdriverPhone() {
        return busdriverPhone;
    }

    public void setBusdriverPhone(String busdriverPhone) {
        this.busdriverPhone = busdriverPhone;
    }

    public Integer getBusdriverBusid() {
        return busdriverBusid;
    }

    public void setBusdriverBusid(Integer busdriverBusid) {
        this.busdriverBusid = busdriverBusid;
    }

    public Integer getBusdriverBelongid() {
        return busdriverBelongid;
    }

    public void setBusdriverBelongid(Integer busdriverBelongid) {
        this.busdriverBelongid = busdriverBelongid;
    }

    public Date getBusdriverInitime() {
        return busdriverInitime;
    }

    public void setBusdriverInitime(Date busdriverInitime) {
        this.busdriverInitime = busdriverInitime;
    }

    public Integer getBusdriverStatus() {
        return busdriverStatus;
    }

    public void setBusdriverStatus(Integer busdriverStatus) {
        this.busdriverStatus = busdriverStatus;
    }

    @Override
    public String toString() {
        return "BusDriver{" +
                "busdriverId=" + busdriverId +
                ", busdriverName='" + busdriverName + '\'' +
                ", busdriverAge=" + busdriverAge +
                ", busdriverSex=" + busdriverSex +
                ", busdriverPhone='" + busdriverPhone + '\'' +
                ", busdriverBusid=" + busdriverBusid +
                ", busdriverBelongid=" + busdriverBelongid +
                ", busdriverInitime=" + busdriverInitime +
                ", busdriverStatus=" + busdriverStatus +
                '}';
    }
}
