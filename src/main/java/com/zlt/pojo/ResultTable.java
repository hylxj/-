package com.zlt.pojo;

import lombok.Data;

import java.io.Serializable;

/**
 * @author shushu
 * @date 2019-09-03-22:15
 */
@Data
public class ResultTable implements Serializable {
    private Integer code;
    private String msg;
    private Integer count;
    private Object data;

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
}
