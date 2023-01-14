package com.zimax.mcrs.log.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.log.mapper.AbnLogMapper;
import com.zimax.mcrs.log.mapper.InterfaceLogMapper;
import com.zimax.mcrs.log.pojo.AbnLog;
import com.zimax.mcrs.log.pojo.AbnLogVo;
import com.zimax.mcrs.log.pojo.InterfaceLog;
import com.zimax.mcrs.log.pojo.InterfaceLogVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 接口日志
 * @author 林俊杰
 * @date 2023/1/4
 */
@Service
public class AbnLogService {

    @Autowired
    private AbnLogMapper abnLogMapper;


    /**
     * 查询所有异常日志信息
     * @param limit
     * @param page
     * @param equipmentId
     * @param deviceName
     * @param abnType
     * @param abnLevel
     * @param exchangeTime
     * @param order
     * @param field
     * @return
     */
    public List<AbnLogVo> queryAbnLog(String limit, String page, String equipmentId, String deviceName, String abnType, String abnLevel, String exchangeTime, String order, String field){
        ChangeString changeString = new ChangeString();
        Map<String,Object> map= new HashMap<>();
        if(order==null){
            map.put("order","desc");
            map.put("field","abn.exchange_time");
        }else{
            map.put("order",order);
            map.put("field",changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("equipmentId",equipmentId);
        map.put("deviceName",deviceName);
        map.put("abnType",abnType);
        map.put("abnLevel",abnLevel);
        map.put("exchangeTime",exchangeTime);
        return abnLogMapper.queryAll(map);
    }

    /**
     * 查询记录
     */
    public int count(String equipmentId, String deviceName, String abnType, String abnLevel, String exchangeTime) {
        return abnLogMapper.count(equipmentId,deviceName,abnType,abnLevel,exchangeTime);
    }


    /**
     * 检测设备是否存在
     *
     * @param equipmentInt 设备资源号
     */
    public int  checkEquipment(int equipmentInt) {
        return abnLogMapper.checkEquipment(equipmentInt);
    }

    /**
     * 添加异常日志
     * @param abnLog
     */
    public void addAbnLog(AbnLog abnLog) {
        abnLogMapper.addAbnLog(abnLog);
    }

    /**
     * 删除异常日志
     */
    public void removeAbnLog(int abnLogId) {
        abnLogMapper.removeAbnLog(abnLogId);
    }


}
