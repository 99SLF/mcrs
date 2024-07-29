package com.zimax.mcrs.report.mapper;

import com.zimax.mcrs.report.pojo.Blanking;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 下料报表
 *
 * @author 李伟杰
 * @date 2022/12/8 19:28
 */

public interface BlankingReportMapper {

    /**
     * 添加报表信息
     *
     * @param blanking 下料报表
     * @return
     */
    void addBlanking(Blanking blanking);

    /**
     * 查询记录数
     *
     * @param
     * @return
     */
    int count(@Param("resource") String resource, @Param("operation") String operation,
              @Param("axis") String axis, @Param("sfcPre") String sfcPre, @Param("processLot") String processLot,
              @Param("sfc") String sfc, @Param("qty") String qty,
              @Param("metre") String metre,
              @Param("diamRealityValue") String diamRealityValue, @Param("createdBy") String createdBy,
              @Param("updatedBy") String updatedBy, @Param("startTime") String startTime,
              @Param("endTime") String endTime    );

    /**
     * 查询所有下料报表信息
     *
     * @param
     * @return
     */
    List<Blanking> queryBlankings(Map map);
}
