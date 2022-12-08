package com.zimax.mcrs.report.mapper;

import com.zimax.mcrs.report.pojo.RFIDReadRa;
import org.apache.ibatis.annotations.Mapper;

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
}

