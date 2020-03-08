package com.zlt.pojo;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @author shushu
 * @date 2019-09-03-15:29
 */
@Data
public class User implements Serializable {

    private Integer id;
    private String username;
    private String password;
    private String salt;
    private Integer locked;
    private Date birthday;
    private String realName;
    private byte [] icon;
    private Integer sex;
    private String phone;
    private Integer type;
    private Integer belongId;
    private String userDesc;
    private String userStatus;

}
