package com.zlt.dao;

import com.zlt.pojo.BusLine;
import com.zlt.pojo.BusStation;
import com.zlt.pojo.LineSta;
import com.zlt.pojo.LineStaView;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 公交车线路管理
 */
public interface BusLineDao {
    //查询所有的公交车线路信息
    List<BusLine> findAll();
    //通过查询线路的名称查询线路的信息
    List<BusLine> findByLineName(String s);
    //通过线路的id删除线路
    void delLine(Integer lineId);
    //添加路线
    void saveLine(BusLine busLine);
    //通过线路id查找线路
    BusLine findByLineId(int id);
    //修改线路信息的保存
    void updateLine(BusLine line);
    //通过线路名称查询站台信息
    List<LineStaView> findStaByLineName(String lineName);
    //查询所有的站台信息
    List<BusStation> findAllStation();
    //保存线路的站台
    void saveLineSta(List<LineSta> lineStas);
    /**
     * @Description: 根据线路名称查询ID
     * @Param: [lineName]
     * @Return: java.util.List<java.lang.Integer>
    **/
    Map<String,Integer> findIdByName(String lineName);
}
