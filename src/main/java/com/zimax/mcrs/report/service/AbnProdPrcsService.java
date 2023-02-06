package com.zimax.mcrs.report.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.report.mapper.AbnProdPrcsReportMapper;
import com.zimax.mcrs.report.pojo.AbnProdPrcs;
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
public class AbnProdPrcsService {
    @Autowired
    private AbnProdPrcsReportMapper abnProdPrcsReportMapper;

    /**
     * 添加上料报表信息
     * @param abnProdPrcs 上料报表
     */
    public void addAbnProdPrcs(AbnProdPrcs abnProdPrcs){

        abnProdPrcs.setCreateTime(new Date());
        abnProdPrcsReportMapper.addAbnProdPrcs(abnProdPrcs);
    }



    /**
     * 查询所有上料报表信息
     */
    public List<AbnProdPrcs> queryAbnProdPrcses(String page, String limit,
                                                String siteId, String rollId,
                                                String equipmentId, String axisName,
                                                String vehicleCode, String prodSFCId,
                                                String endEANumber, String isEnd,
                                                String performStep, String createTime,
                                                String updateTime,
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
        map.put("siteId", siteId);
        map.put("rollId", rollId);
        map.put("equipmentId", equipmentId);
        map.put("axisName", axisName);
        map.put("vehicleCode", vehicleCode);
        map.put("prodSFCId", prodSFCId);
        map.put("endEANumber", endEANumber);
        map.put("isEnd", isEnd);
        map.put("performStep", performStep);
        map.put("createTime", createTime);
        map.put("updateTime", updateTime);
        return abnProdPrcsReportMapper.queryAbnProdPrcses(map);

    }

    public int count(String siteId, String rollId,
                     String equipmentId, String axisName,
                     String vehicleCode, String prodSFCId,
                     String endEANumber, String isEnd,
                     String performStep, String createTime,
                     String updateTime) {
        return abnProdPrcsReportMapper.count(siteId, rollId, equipmentId, axisName, vehicleCode, prodSFCId,
                endEANumber, isEnd, performStep, createTime, updateTime);
    }
}
