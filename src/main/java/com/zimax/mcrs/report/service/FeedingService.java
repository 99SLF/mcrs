package com.zimax.mcrs.report.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.report.mapper.FeedingReportMapper;
import com.zimax.mcrs.report.pojo.Feeding;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/5 15:17
 */
@Service
public class FeedingService {

    /**
     * 上料报表
     */
    @Autowired
    private FeedingReportMapper feedingReportMapper;


    /**
     * 添加上料报表信息
     *
     * @param feeding 上料报表
     */
    public void addFeeding(Feeding feeding) {
        feedingReportMapper.addFeeding(feeding);
    }


    /**
     * 查询所有上料报表信息
     */
    public List<Feeding> queryFeedings(String page, String limit,
                                       String resource, String operation,
                                       String actionType, String axis,
                                       String sfcPre, String processLotPre,
                                       String qty, String sfc, String isFinish,
                                       String diamRealityValue,
                                       String createdBy, String updatedBy,
                                       String startTime, String endTime,
                                       String order, String field){
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "desc");
            map.put("field", "createdTime");
        } else {
            map.put("order", order);
            map.put("field", field);
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("resource", resource);
        map.put("operation", operation);
        map.put("actionType", actionType);
        map.put("axis", axis);
        map.put("sfcPre", sfcPre);
        map.put("processLotPre", processLotPre);
        map.put("qty", qty);
        map.put("sfc", sfc);
        map.put("isFinish", isFinish);
        map.put("diamRealityValue", diamRealityValue);
        map.put("createdBy", createdBy);
        map.put("updatedBy", updatedBy);
        map.put("startTime", startTime);
        map.put("endTime", endTime);
        return feedingReportMapper.queryFeedings(map);

    }

    public int count( String resource, String operation,
                      String actionType, String axis,
                      String sfcPre, String processLotPre,
                      String qty, String sfc, String isFinish, String diamRealityValue,
                      String createdBy, String updatedBy,
                      String startTime, String endTime) {
        return feedingReportMapper.count(resource, operation, actionType, axis, sfcPre, processLotPre, qty, sfc, isFinish,diamRealityValue, createdBy, updatedBy,startTime, endTime);
    }
}
