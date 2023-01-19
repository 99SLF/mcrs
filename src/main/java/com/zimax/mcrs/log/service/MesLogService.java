package com.zimax.mcrs.log.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.log.mapper.MesLogMapper;
import com.zimax.mcrs.log.mapper.RfidLogMapper;
import com.zimax.mcrs.log.pojo.MesLog;
import com.zimax.mcrs.log.pojo.MesLogVo;
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
 * @author 林俊杰
 * @date 2023/1/13
 */
@Service
public class MesLogService {

    @Autowired
    private MesLogMapper mesLogMapper;


    /**
     * 查询所有RFID日志信息
     */
    public List<MesLogVo> queryMesLog(String limit, String page, String equipmentName, String deviceName, String mesIpAddress, String equipmentContinuePort, String createTime, String order, String field){
        ChangeString changeString = new ChangeString();
        Map<String,Object> map= new HashMap<>();
        if(order==null){
            map.put("order","desc");
            map.put("field","ll.create_time");
        }else{
            map.put("order",order);
            map.put("field",changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("equipmentName",equipmentName);
        map.put("deviceName",deviceName);
        map.put("mesIpAddress",mesIpAddress);
        map.put("equipmentContinuePort",equipmentContinuePort);
        map.put("createTime",createTime);
        return mesLogMapper.queryAll(map);
    }

    /**
     * 查询记录
     */
    public int count( String equipmentName, String deviceName, String mesIpAddress,String equipmentContinuePort, String createTime) {
        return mesLogMapper.count(equipmentName,deviceName,mesIpAddress,equipmentContinuePort,createTime);
    }

    /**
     * 添加Mes交换日志
     * @param mesLog mes交换日志
     */
    public void addMesLog(MesLog mesLog) {
        mesLog.setLogType("107");
        mesLog.setCreateTime(new Date());
        mesLogMapper.addMesLog(mesLog);
    }


}
