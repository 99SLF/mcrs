package com.zimax.mcrs.report.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.report.mapper.CoilDiameterRecordMapper;
import com.zimax.mcrs.report.pojo.CoilDiameterRecord;
import com.zimax.mcrs.report.pojo.Feeding;
import com.zimax.mcrs.report.pojo.RFIDReadRa;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author 施林丰
 * @Date:2023/3/4 13:29
 * @Description
 */
@Service
public class CoilDiameterRecordService {
    @Autowired
    CoilDiameterRecordMapper coilDiameterRecordMapper;
    /**
     * 添加报表记录信息
     *
     * @param coilDiameterRecord 记录报表
     */
    public void addCoilDiameterRecord(CoilDiameterRecord coilDiameterRecord) {
        coilDiameterRecordMapper.addCoilDiameterRecord(coilDiameterRecord);
    }

    public List<CoilDiameterRecord> queryCoilDiameterRecord(String page, String limit,
                                                    String resource, String sfcPreData,
                                                    String uDiamRealityValue, String rAxisName,
                                                    String rProcessLotPre, String sfcData,
                                                    String rDiamRealityValue, String isLastVolume,
                                                    String unwindIsOver, String remark,
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
        map.put("sfcPreData", sfcPreData);
        map.put("uDiamRealityValue", uDiamRealityValue);
        map.put("rAxisName", rAxisName);
        map.put("rProcessLotPre", rProcessLotPre);
        map.put("sfcData", sfcData);
        map.put("rDiamRealityValue", rDiamRealityValue);
        map.put("isLastVolume", isLastVolume);
        map.put("unwindIsOver", unwindIsOver);
        map.put("remark", remark);
        map.put("startTime", startTime);
        map.put("endTime", endTime);

        return coilDiameterRecordMapper.queryCoilDiameterRecord(map);

    }

    public int count( String resource, String sfcPreData,
                      String uDiamRealityValue, String rAxisName,
                      String rProcessLotPre, String sfcData,
                      String rDiamRealityValue, String isLastVolume,
                      String unwindIsOver, String remark,
                      String startTime, String endTime) {
        return coilDiameterRecordMapper.count(resource,  sfcPreData, uDiamRealityValue,  rAxisName, rProcessLotPre,  sfcData, rDiamRealityValue,  isLastVolume, unwindIsOver,  remark, startTime, endTime);
    }
}
