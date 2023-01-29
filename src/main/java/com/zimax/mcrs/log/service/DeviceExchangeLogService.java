package com.zimax.mcrs.log.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.log.mapper.DeviceExchangeLogMapper;
import com.zimax.mcrs.log.pojo.DeviceExchangeLog;
import com.zimax.mcrs.log.pojo.DeviceExchangeLogVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 设备交换日志服务
 * @author 林俊杰
 * @date 2022/11/30
 */
@Service
public class DeviceExchangeLogService {

    @Autowired
    private DeviceExchangeLogMapper deviceExchangeLogMapper;


    /**
     * 查询所有的设备交换日志
     * @return DeviceExchangeLog
     */
    public List<DeviceExchangeLogVo> queryDeviceExchangeLog(String limit, String page, String equipmentId, String equipmentContinuePort, String processName,String operateName, String equipmentExchangeTime, String order, String field){
        ChangeString changeString = new ChangeString();
        Map<String,Object> map= new HashMap<>();
        if(order==null){
            map.put("order","desc");
            map.put("field","ll.equipment_exchange_time");
        }else{
            map.put("order",order);
            map.put("field",changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("equipmentId",equipmentId);
        map.put("equipmentContinuePort",equipmentContinuePort);
        map.put("processName",processName);
        map.put("operateName",operateName);
        map.put("equipmentExchangeTime",equipmentExchangeTime);
        return deviceExchangeLogMapper.queryAll(map);
    }

    /**
     * 查询记录
     */
    public int count(String equipmentId, String equipmentContinuePort, String processName, String operateName, String equipmentExchangeTime) {
        return deviceExchangeLogMapper.count(equipmentId,equipmentContinuePort,processName,operateName,equipmentExchangeTime);
    }

    /**
     * 添加设备交换日志
     */
    public void addDeviceExchangeLog(DeviceExchangeLog deviceExchangeLog){
        deviceExchangeLog.setLogType("104");
        deviceExchangeLog.setCreateTime(new Date());
        deviceExchangeLogMapper.addDeviceExchangeLog(deviceExchangeLog);
    }

}
