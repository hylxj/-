package com.zlt.pojo;

import java.io.Serializable;

/**
 * @author shushu
 * @date 2019-09-03-15:29
 */

public class User implements Serializable {
    private Integer id;
    private String username;
    private String password;
    private String salt;
    private Integer locked;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public Integer getLocked() {
        return locked;
    }

    public void setLocked(Integer locked) {
        this.locked = locked;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", salt='" + salt + '\'' +
                ", locked=" + locked +
                '}';
    }
}
