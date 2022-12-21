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
    public List<DeviceExchangeLogVo> queryDeviceExchangeLog(String limit, String page, String equipmentId, String equipmentContinuePort, String processName,String operator, String exchangeTime, String order, String field){
        ChangeString changeString = new ChangeString();
        Map<String,Object> map= new HashMap<>();
        if(order==null){
            map.put("order","desc");
            map.put("field","exchange.exchange_time");
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
        map.put("operator",operator);
        map.put("exchangeTime",exchangeTime);
        return deviceExchangeLogMapper.queryAll(map);
    }

    /**
     * 查询记录
     */
    public int count(String equipmentId) {
        return deviceExchangeLogMapper.count(equipmentId);
    }

    /**
     * 添加设备交换日志
     */
    public void addDeviceExchangeLog(DeviceExchangeLog deviceExchangeLog){
        deviceExchangeLogMapper.addDeviceExchangeLog(deviceExchangeLog);
    }


    /**
     * 删除设备交换日志
     */
    public void removeDeviceExchangeLog(int deviceExchangeLogId){
        deviceExchangeLogMapper.removeDeviceExchangeLog(deviceExchangeLogId);
    }
}
