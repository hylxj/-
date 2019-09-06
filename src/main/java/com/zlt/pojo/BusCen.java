package com.zlt.pojo;

import java.io.Serializable;

/**
 * @author shushu
 * @date 2019-09-04-16:27
 */

public class BusCen implements Serializable {
    private Integer buscenId;
    private String buscenName;

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

    @Override
    public String toString() {
        return "BusCen{" +
                "buscenId=" + buscenId +
                ", buscenName='" + buscenName + '\'' +
                '}';
    }
}
