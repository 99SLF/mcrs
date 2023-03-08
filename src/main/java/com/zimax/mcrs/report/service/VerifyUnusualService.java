package com.zimax.mcrs.report.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.report.mapper.RFIDReadRaReportMapper;
import com.zimax.mcrs.report.mapper.VerifyUnusualMapper;
import com.zimax.mcrs.report.pojo.CoilDiameterRecord;
import com.zimax.mcrs.report.pojo.RFIDReadRa;
import com.zimax.mcrs.report.pojo.VerifyUnusual;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author 施林丰
 * @Date:2023/3/4 13:38
 * @Description
 */
@Service
public class VerifyUnusualService {
    /**
     * 防串度记录报表
     */
    @Autowired
    private VerifyUnusualMapper verifyUnusualMapper;


    /**
     * 添加防串度读取率报表信息
     *
     * @param verifyUnusual 防串读取率报表
     */
    public void addVerifyUnusual(VerifyUnusual verifyUnusual) {
        verifyUnusualMapper.addVerifyUnusual(verifyUnusual);
    }

    public List<VerifyUnusual> queryVerifyUnusual(String page, String limit,
                                                  String resource, String axisName,
                                                  String rfidReader, String antenna,
                                                  String processLot, String tag,
                                                  String readNum, String sfcPre,
                                                  String sfc,
                                                  String startTime, String endTime,
                                                  String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "desc");
            map.put("field", "updatedTime");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("resource", resource);
        map.put("axisName", axisName);
        map.put("rfidReader", rfidReader);
        map.put("antenna", antenna);
        map.put("processLot", processLot);
        map.put("tag", tag);
        map.put("readNum", readNum);
        map.put("sfcPre", sfcPre);
        map.put("sfc", sfc);
        map.put("startTime", startTime);
        map.put("endTime", endTime);

        return verifyUnusualMapper.queryVerifyUnusual(map);

    }

    public int count( String resource, String axisName,
                      String rfidReader, String antenna,
                      String processLot, String tag,
                      String readNum, String sfcPre,
                      String sfc,
                      String startTime, String endTime) {
        return verifyUnusualMapper.count(resource,  axisName, rfidReader,  antenna, processLot,  tag, readNum,  sfcPre, sfc, startTime, endTime);
    }
}
