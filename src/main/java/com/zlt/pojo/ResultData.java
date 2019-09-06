package com.zlt.pojo;

import lombok.Data;

import java.io.Serializable;

/**
 * @author shushu
 * @date 2019-08-30-16:45
 */
@Data
public class ResultData implements Serializable {
    private Integer code;
    private String msg;
    private Object data;

    public ResultData(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public ResultData(Integer code, String msg, Object data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }
}
