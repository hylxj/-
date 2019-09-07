package com.zlt.pojo;

import lombok.Data;

/**
 * @author shushu
 * @date 2019-09-07-11:44
 */
@Data
public class Role {
    private Integer roleId;
    private String roleName;
    private String roleDesc;
    private String available;
}
