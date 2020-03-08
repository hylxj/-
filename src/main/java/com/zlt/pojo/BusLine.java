package com.zlt.pojo;

import java.io.Serializable;
import java.util.Date;

public class BusLine implements Serializable {
    private  int lineId;
    private  String lineName;
    private  String lineTime;
    private int linePrice;
    private Date lineCreatetime;
    private int lineStatus;

    public BusLine() {
    }

    public BusLine(int lineId, String lineName, String lineTime, int linePrice, Date lineCreatetime, int lineStatus) {
        this.lineId = lineId;
        this.lineName = lineName;
        this.lineTime = lineTime;
        this.linePrice = linePrice;
        this.lineCreatetime = lineCreatetime;
        this.lineStatus = lineStatus;
    }

    public int getLineId() {
        return lineId;
    }

    public void setLineId(int lineId) {
        this.lineId = lineId;
    }

    public String getLineName() {
        return lineName;
    }

    public void setLineName(String lineName) {
        this.lineName = lineName;
    }

    public String getLineTime() {
        return lineTime;
    }

    public void setLineTime(String lineTime) {
        this.lineTime = lineTime;
    }

    public int getLinePrice() {
        return linePrice;
    }

    public void setLinePrice(int linePrice) {
        this.linePrice = linePrice;
    }

    public Date getLineCreatetime() {
        return lineCreatetime;
    }

    public void setLineCreatetime(Date lineCreatetime) {
        this.lineCreatetime = lineCreatetime;
    }

    public int getLineStatus() {
        return lineStatus;
    }

    public void setLineStatus(int lineStatus) {
        this.lineStatus = lineStatus;
    }

    @Override
    public String toString() {
        return "BusLine{" +
                "lineId=" + lineId +
                ", lineName='" + lineName + '\'' +
                ", lineTime='" + lineTime + '\'' +
                ", linePrice=" + linePrice +
                ", lineCreatetime=" + lineCreatetime +
                ", lineStatus=" + lineStatus +
                '}';
    }
}
