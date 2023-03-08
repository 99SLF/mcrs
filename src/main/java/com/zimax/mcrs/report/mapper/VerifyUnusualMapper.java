package com.zimax.mcrs.report.mapper;

import com.zimax.mcrs.report.pojo.CoilDiameterRecord;
import com.zimax.mcrs.report.pojo.VerifyUnusual;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @Author 施林丰
 * @Date:2023/3/4 13:24
 * @Description
 */
@Mapper
public interface VerifyUnusualMapper {
    void addVerifyUnusual(VerifyUnusual verifyUnusual);

    int count(@Param("resource") String resource, @Param("axisName") String axisName,
              @Param("rfidReader") String rfidReader, @Param("antenna") String antenna,
              @Param("processLot") String processLot, @Param("tag") String tag, @Param("readNum") String readNum,
              @Param("sfcPre") String sfcPre, @Param("sfc") String sfc, @Param("startTime") String startTime, @Param("endTime") String endTime
    );

    List<VerifyUnusual> queryVerifyUnusual(Map map);
}
