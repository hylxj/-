package com.zlt.pojo;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * 调度中心
 * @author shushu
 * @date 2019-09-04-16:27
 */
@Data
public class BusCen implements Serializable {
    private Integer id;
    private Integer parentId;
    private String title;
    private String buscenDistrict;
    private Integer buscenManagerId;
    private Integer buscenStatus;
    private Integer spread;
    private List<BusCen> children;
}
