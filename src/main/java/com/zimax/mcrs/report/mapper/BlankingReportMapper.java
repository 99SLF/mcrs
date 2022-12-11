package com.zimax.mcrs.report.mapper;

import com.zimax.mcrs.report.pojo.Blanking;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 下料报表
 * @author 李伟杰
 * @date 2022/12/8 19:28
 */
@Mapper
public interface BlankingReportMapper {

    /**
     * 添加报表信息
     * @param blanking 下料报表
     * @return
     */
    void addBlanking(Blanking blanking);

    /**
     * 查询记录数
     * @param
     * @return
     */
    int count(@Param("equipmentId") String equipmentId, @Param("axisName") String axisName,
              @Param("antennaLoc") String antennaLoc, @Param("prodSFCId") String prodSFCId,
              @Param("isEnd") String isEnd, @Param("startProdTime") String startProdTime,
              @Param("endProdTime") String endProdTime
    );

    /**
     * 查询所有下料报表信息
     * @param
     * @return
     */
    List<Blanking> queryBlankings(Map map);
}
