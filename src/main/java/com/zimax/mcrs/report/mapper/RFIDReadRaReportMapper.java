package com.zimax.mcrs.report.mapper;
import com.zimax.mcrs.report.pojo.RFIDReadRa;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * RFID读取率报表
 * @author 李伟杰
 * @date 2022/12/8 19:29
 */
@Mapper
public interface RFIDReadRaReportMapper {
    /**
     * 添加报表信息
     * @param rfidReadRa RFID读取率报表
     * @return
     */
    void addRFIDReadRa(RFIDReadRa rfidReadRa);

    /**
     * 查询记录数
     * @param
     * @return
     */
    int count(@Param("equipmentId") String equipmentId, @Param("rfidId") String RFIDId,
              @Param("antennaId") String antennaId, @Param("readRate") String readRate,
              @Param("recordTime") String recordTime
    );

    /**
     * 查询所有上料报表信息
     * @param
     * @return
     */
    List<RFIDReadRa> queryRFIDs(Map map);
}

