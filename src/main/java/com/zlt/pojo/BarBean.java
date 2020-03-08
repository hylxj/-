package com.zlt.pojo;

public class BarBean {
    private Integer value;
    private String name;

    public Integer getValue() {
        return value;
    }

    public void setValue(Integer value) {
        this.value = value;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "BarBean{" +
                "value=" + value +
                ", name='" + name + '\'' +
                '}';
    }
}
