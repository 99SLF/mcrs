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

        feeding.setCreateTime(String.valueOf(new Date()));
        feedingReportMapper.addFeeding(feeding);
    }


    /**
     * 查询所有上料报表信息
     */
    public List<Feeding> queryFeedings(String page, String limit,
                                       String equipmentId, String axisName,
                                       String inSFCId, String prodSFCId,
                                       String vehicleCode, String startProdTime,
                                       String endProdTime,
                                       String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "desc");
            map.put("field", "create_time");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("equipmentId", equipmentId);
        map.put("axisName", axisName);
        map.put("inSFCId", inSFCId);
        map.put("prodSFCId", prodSFCId);
        map.put("vehicleCode", vehicleCode);
        map.put("startProdTime", startProdTime);
        map.put("endProdTime", endProdTime);
        return feedingReportMapper.queryFeedings(map);

    }

    public int count(String equipmentId, String axisName,
                     String inSFCId, String prodSFCId,
                     String vehicleCode, String startProdTime,
                     String endProdTime) {
        return feedingReportMapper.count(equipmentId, axisName, inSFCId, prodSFCId, vehicleCode, startProdTime, endProdTime);
    }
}
