package com.zlt.pojo;

import java.util.List;
import java.util.Map;

/**
 * 记录用户信息+权限的model模型
 * @author shushu
 * @date 2019-09-02-12:43
 */

public class AuthUserFunctionModel {
    private AuthUser authUser;
    private List<Map<String,Object>> authFunction;

    public AuthUserFunctionModel(AuthUser authUser, List<Map<String, Object>> authFunction) {
        this.authUser = authUser;
        this.authFunction = authFunction;
    }

    public AuthUser getAuthUser() {
        return authUser;
    }

    public void setAuthUser(AuthUser authUser) {
        this.authUser = authUser;
    }

    public List<Map<String, Object>> getAuthFunction() {
        return authFunction;
    }

    public void setAuthFunction(List<Map<String, Object>> authFunction) {
        this.authFunction = authFunction;
    }

    @Override
    public String toString() {
        return "AuthUserFunctionModel{" +
                "authUser=" + authUser +
                ", authFunction=" + authFunction +
                '}';
    }
}
