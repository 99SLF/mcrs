package com.zimax.mcrs.report.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.report.mapper.RFIDReadRaReportMapper;
import com.zimax.mcrs.report.pojo.RFIDReadRa;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/5 15:18
 */

@Service
public class RFIDReadRaService {

    /**
     * RFID读取率报表
     */
    @Autowired
    private RFIDReadRaReportMapper rfidReadRaReportMapper;


    /**
     * 添加RFID读取率报表信息
     *
     * @param rfidReadRa RFID读取率报表
     */
    public void addRFIDReadRa(RFIDReadRa rfidReadRa) {

        rfidReadRaReportMapper.addRFIDReadRa(rfidReadRa);
    }

    /**
     * 查询所有RFID报表信息
     */
    public List<RFIDReadRa> queryRFIDs(String page, String limit,
                                       String equipmentId, String RFIDId,
                                       String antennaId, String readRate,
                                       String recordTime, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "desc");
            map.put("field", "record_time");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("equipmentId", equipmentId);
        map.put("RFIDId", RFIDId);
        map.put("antennaId", antennaId);
        map.put("readRate", readRate);
        map.put("recordTime", recordTime);

        return rfidReadRaReportMapper.queryRFIDs(map);

    }

    public int count(String equipmentId, String RFIDId,
                     String antennaId, String readRate,
                     String recordTime) {
        return rfidReadRaReportMapper.count(equipmentId, RFIDId, antennaId, readRate, recordTime);
    }
}
