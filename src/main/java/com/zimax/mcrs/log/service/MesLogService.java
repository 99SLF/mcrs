package com.zimax.mcrs.log.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.log.mapper.MesLogMapper;
import com.zimax.mcrs.log.mapper.RfidLogMapper;
import com.zimax.mcrs.log.pojo.*;
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
public class MesLogService {

    @Autowired
    private MesLogMapper mesLogMapper;

    @Autowired
    private AddOperationLog addOperationLog;

    /**
     * 查询所有RFID日志信息
     */
    public List<MesLogVo> queryMesLog(String limit, String page, String logStatus, String equipmentId, String equipmentName, String deviceName, String mesIpAddress, String createName, String createTime, String order, String field) {

        if (logStatus != null || equipmentId != null || equipmentName != null || deviceName != null || mesIpAddress != null || createName != null || createTime != null) {
            addOperationLog.addOperationLog(5);
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
        map.put("logStatus", logStatus);
        map.put("equipmentId", equipmentId);
        map.put("equipmentName", equipmentName);
        map.put("deviceName", deviceName);
        map.put("mesIpAddress", mesIpAddress);
        map.put("createName", createName);
        map.put("createTime", createTime);
        return mesLogMapper.queryAll(map);
    }

    /**
     * 查询记录
     */
    public int count(String logStatus, String equipmentId, String equipmentName, String deviceName, String mesIpAddress, String createName, String createTime) {
        return mesLogMapper.count(logStatus, equipmentId, equipmentName, deviceName, mesIpAddress, createName, createTime);
    }

    /**
     * 添加Mes交换日志
     *
     * @param mesLog mes交换日志
     */
    public void addMesLog(MesLog mesLog) {
        mesLog.setLogType("107");
        mesLog.setCreateTime(new Date());
        mesLogMapper.addMesLog(mesLog);
    }

    /**
     * 查询终端对应的PLC日志给终端
     */
    public List<MesLogVo> csQuery(String APPId) {
        return mesLogMapper.csQuery(APPId);
    }

}
