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
    public void deleteDeviceExchangeLog(){

    }

    /**
     * 设备交换日志删除
     * @param deviceExchangeLogId
     */
    public void deleteById(int deviceExchangeLogId){
        deviceExchangeLogMapper.deleteById(deviceExchangeLogId);
    }

    /**
     * 设备交换日志初始化查询
     * @return DeviceExchangeLog
     */
    public List<DeviceExchangeLog> queryAll(){
        return deviceExchangeLogMapper.selectList(null);
    }

    /**
     * 设备交换日志查询
     * @param deviceId 设备id查询
     * @return DeviceExchangeLog
     */
    public DeviceExchangeLog  queryDeviceId(int deviceId){
        return deviceExchangeLogMapper.selectById(deviceId);
    }

    /**
     * 设备交换日志查询
     * @param userName 用户名称查询
     * @return DeviceExchangeLog
     */
    public List<DeviceExchangeLog>  queryUserName(String userName){
        return deviceExchangeLogMapper.selectList(null);
    }

    /**
     * 设备交换日志查询
     * @param exchangeContent 设备交换日志内容查询
     * @return DeviceExchangeLog
     */
    public List<DeviceExchangeLog>  queryExchangeContent(String exchangeContent){
        return deviceExchangeLogMapper.selectList(null);
    }

    /**
     * 设备交换日志查询
     * @param exchangeTime 设备交互时间查询
     * @return DeviceExchangeLog
     */
    public List<DeviceExchangeLog>  queryExchangeTime(Date exchangeTime){
        return deviceExchangeLogMapper.selectList(null);
    }

}
