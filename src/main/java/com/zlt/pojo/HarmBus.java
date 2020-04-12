package com.zlt.pojo;


import lombok.Data;

import java.util.Date;

/**
 * @ClassName HarmBus
 * @Description: 损坏的车辆
 * @Author huangyu
 * @Date 2020/4/5
 * @Version V1.0
 **/
@Data
public class HarmBus {
    private int fixId;
    private int busId;
    private String fixReason;
    private Date fixTime;
}
