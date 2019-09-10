package com.zlt.pojo;

import lombok.Data;

import java.io.Serializable;
@Data
public class IdAndName implements Serializable {
    private  int id;
    private String name;
}
