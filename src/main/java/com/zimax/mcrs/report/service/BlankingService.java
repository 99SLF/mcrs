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

        blanking.setCreateTime(new Date());
        blankingReportMapper.addBlanking(blanking);
    }

    /**
     * 查询所有下料报表信息
     */
    public List<Blanking> queryBlankings(String page,  String limit,
                                         String equipmentId, String axisName,
                                         String antennaLoc,String vehicleCode, String prodSFCId,
                                         String isEnd, String startProdTime,
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
        map.put("antennaLoc", antennaLoc);
        map.put("vehicleCode", vehicleCode);
        map.put("prodSFCId", prodSFCId);
        map.put("isEnd", isEnd);
        map.put("startProdTime", startProdTime);
        map.put("endProdTime", endProdTime);

        return blankingReportMapper.queryBlankings(map);

    }

    public int count(String equipmentId, String axisName,
                     String antennaLoc, String vehicleCode, String prodSFCId,
                     String isEnd, String startProdTime,
                     String endProdTime) {
        return blankingReportMapper.count(equipmentId,axisName,antennaLoc, vehicleCode ,prodSFCId,isEnd,startProdTime,endProdTime);
    }
}
