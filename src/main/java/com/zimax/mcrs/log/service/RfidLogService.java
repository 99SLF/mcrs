package com.zimax.mcrs.log.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.log.mapper.PlcLogMapper;
import com.zimax.mcrs.log.mapper.RfidLogMapper;
import com.zimax.mcrs.log.pojo.PlcLog;
import com.zimax.mcrs.log.pojo.PlcLogVo;
import com.zimax.mcrs.log.pojo.RfidLog;
import com.zimax.mcrs.log.pojo.RfidLogVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * RFID日志
 *
 * @author 林俊杰
 * @date 2023/1/13
 */
@Service
public class RfidLogService {

    @Autowired
    private RfidLogMapper rfidLogMapper;

    @Autowired
    private AddOperationLog addOperationLog;


    /**
     * 查询所有RFID日志信息
     */
    public List<RfidLogVo> queryRfidLog(String limit, String page, String equipmentId, String equipmentName, String deviceName, String rfidId, String parameterName, String createName, String createTime, String order, String field) {
        if (equipmentId != null || equipmentName != null || deviceName != null || rfidId != null || parameterName != null || createName != null || createTime != null) {
            addOperationLog.addOperationLog(8);
        }
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "desc");
            map.put("field", "ll.create_time");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("equipmentId", equipmentId);
        map.put("equipmentName", equipmentName);
        map.put("deviceName", deviceName);
        map.put("rfidId", rfidId);
        map.put("parameterName", parameterName);
        map.put("createName", createName);
        map.put("createTime", createTime);
        return rfidLogMapper.queryAll(map);
    }

    /**
     * 查询记录
     */
    public int count(String equipmentId, String equipmentName, String deviceName, String rfidId, String parameterName, String createName, String createTime) {
        return rfidLogMapper.count(equipmentId, equipmentName, deviceName, rfidId, parameterName, createName, createTime);
    }

    /**
     * 添加Rfid交换日志
     *
     * @param rfidLog RFID交换日志
     */
    public void addRfidLog(RfidLog rfidLog) {
        rfidLog.setLogType("106");
        rfidLog.setCreateTime(new Date());
        rfidLogMapper.addRfidLog(rfidLog);
    }


    /**
     * 查询终端对应的PLC日志给终端
     */
    public List<RfidLogVo> csQuery(String APPId) {
        return rfidLogMapper.csQuery(APPId);
    }
}
