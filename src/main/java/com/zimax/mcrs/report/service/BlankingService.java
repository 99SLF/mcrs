package com.zimax.mcrs.report.service;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.report.mapper.BlankingReportMapper;
import com.zimax.mcrs.report.pojo.Blanking;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.xml.crypto.Data;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/5 15:17
 */
@Service
public class BlankingService {

    @Autowired
    private BlankingReportMapper blankingReportMapper;

    /**
     * 添加下料报表信息
     * @param blanking 下料报表
     */
    public void addBlanking(Blanking blanking){
        blankingReportMapper.addBlanking(blanking);
    }

    /**
     * 查询所有下料报表信息
     */
    public List<Blanking> queryBlankings(String page, String limit,
                                         String resource, String operation,
                                         String axis, String sfcPre,
                                         String processLot, String sfc,
                                         String qty, String metre,
                                         String diamRealityValue, String createdBy,
                                         String updatedBy,
                                         String startTime, String endTime,
                                         String order, String field){
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "desc");
            map.put("field", "id");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("resource", resource);
        map.put("operation", operation);
        map.put("axis", axis);
        map.put("sfcPre", sfcPre);
        map.put("processLot", processLot);
        map.put("sfc", sfc);
        map.put("qty", qty);
        map.put("metre", metre);
        map.put("diamRealityValue", diamRealityValue);
        map.put("createdBy", createdBy);
        map.put("updatedBy", updatedBy);
        map.put("startTime", startTime);
        map.put("endTime", endTime);


        return blankingReportMapper.queryBlankings(map);

    }

    public int count(String resource, String operation,
                     String axis, String sfcPre,
                     String processLot, String sfc,
                     String qty, String metre,
                     String diamRealityValue, String createdBy,
                     String updatedBy,
                     String startTime, String endTime) {
        return blankingReportMapper.count(resource, operation, axis, sfcPre, processLot, sfc, qty, metre, diamRealityValue, createdBy, updatedBy, startTime, endTime);
    }
}
