package com.zlt.pojo;

import lombok.Data;

import java.io.Serializable;

/**
 * 角色
 */
@Data
public class SysRole implements Serializable {

    private String id;
    private String name;
    private String content;
    private Integer available;

}