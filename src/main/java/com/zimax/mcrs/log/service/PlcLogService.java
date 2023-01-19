package com.zimax.mcrs.log.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.log.mapper.PlcLogMapper;
import com.zimax.mcrs.log.pojo.PlcLog;
import com.zimax.mcrs.log.pojo.PlcLogVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * plc日志
 * @author 林俊杰
 * @date 2023/1/13
 */
@Service
public class PlcLogService {

    @Autowired
    private PlcLogMapper plcLogMapper;


    /**
     * 查询所有plc日志信息
     */
    public List<PlcLogVo> queryPlcLog(String limit, String page, String equipmentName, String deviceName, String plcGroupName, String groupType, String createTime, String order, String field){
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
        map.put("plcGroupName",plcGroupName);
        map.put("groupType",groupType);
        map.put("createTime",createTime);
        return plcLogMapper.queryAll(map);
    }

    /**
     * 查询记录
     */
    public int count( String equipmentName, String deviceName, String plcGroupName, String groupType, String createTime) {
        return plcLogMapper.count(equipmentName,deviceName,plcGroupName,groupType,createTime);
    }
//
//
////    /**
////     * 检测设备是否存在
////     *
////     * @param equipmentInt 设备资源号
////     */
////    public int  checkEquipment(int equipmentInt) {
////        return interfaceLogMapper.checkEquipment(equipmentInt);
////    }
////
    /**
     * 添加Plc日志
     * @param plcLog plc交换日志
     */
    public void addPlcLog(PlcLog plcLog) {
        plcLog.setLogType("105");
        plcLog.setCreateTime(new Date());
        plcLogMapper.addPlcLog(plcLog);
    }



}
