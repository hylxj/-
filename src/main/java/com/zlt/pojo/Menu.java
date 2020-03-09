package com.zlt.pojo;

import lombok.Data;

import java.util.List;

/**
 * @author huangyu
 * @date 2019-09-08-10:27
 */
@Data
public class Menu {
    private Integer menuId;
    private Integer parentId;
    private String title;
    private String icon;
    private String href;
    private Integer spread;
    private Integer available;
    private List<Menu> children;
}
