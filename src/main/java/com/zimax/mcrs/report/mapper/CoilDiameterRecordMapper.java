package com.zimax.mcrs.report.mapper;

import com.zimax.mcrs.report.pojo.CoilDiameterRecord;
import com.zimax.mcrs.report.pojo.RFIDReadRa;
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
public interface CoilDiameterRecordMapper {
    void addCoilDiameterRecord(CoilDiameterRecord coilDiameterRecord);


    int count(@Param("resource") String resource, @Param("sfcPreData") String sfcPreData,
              @Param("uDiamRealityValue") String uDiamRealityValue, @Param("rAxisName") String rAxisName,
              @Param("rProcessLotPre") String rProcessLotPre, @Param("sfcData") String sfcData, @Param("rDiamRealityValue") String rDiamRealityValue,
              @Param("isLastVolume") String isLastVolume,@Param("unwindIsOver") String unwindIsOver, @Param("remark") String remark,
              @Param("startTime") String startTime, @Param("endTime") String endTime
    );

    List<CoilDiameterRecord> queryCoilDiameterRecord(Map map);
}
