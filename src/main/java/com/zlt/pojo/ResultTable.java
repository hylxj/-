package com.zlt.pojo;

import java.io.Serializable;

/**
 * @author shushu
 * @date 2019-09-03-22:15
 */

public class ResultTable implements Serializable {
    private Integer code;
    private String msg;
    private Integer count;
    private Object data;

    public ResultTable() {
    }

    public ResultTable(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public ResultTable(Integer code, String msg, Integer count, Object data) {
        this.code = code;
        this.msg = msg;
        this.count = count;
        this.data = data;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "ResultTable{" +
                "code=" + code +
                ", msg='" + msg + '\'' +
                ", count=" + count +
                ", data=" + data +
                '}';
    }
}
