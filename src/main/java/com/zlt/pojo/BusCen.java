package com.zlt.pojo;

import lombok.Data;

import java.io.Serializable;

/**
 * 调度中心
 * @author shushu
 * @date 2019-09-04-16:27
 */
@Data
public class BusCen implements Serializable {
    private Integer buscenId;
    private String buscenName;
}
