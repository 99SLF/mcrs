package com.zimax.mcrs.log.service;

import com.zimax.mcrs.log.mapper.DeviceExchangeLogMapper;
import com.zimax.mcrs.log.pojo.DeviceExchangeLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

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
     * 设备交换日志定期删除
     *
     */
    public void removeDeviceExchangeLog(){

    }

    /**
     * 设备交换日志删除
     * @param deviceExchangeLogId
     */
    public void removeById(int deviceExchangeLogId){

    }

    /**
     * 设备交换日志初始化查询
     * @return DeviceExchangeLog
     */
    public List<DeviceExchangeLog> queryAll(){
        return null;
    }

    /**
     * 设备交换日志条件查询
     * @return DeviceExchangeLog
     */
    public DeviceExchangeLog  query(int deviceId){
        return null;
    }



}
