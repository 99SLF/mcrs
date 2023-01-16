package com.zimax.mcrs.log.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.zimax.mcrs.log.pojo.DeviceExchangeLog;
import com.zimax.mcrs.log.pojo.DeviceExchangeLogVo;
import com.zimax.mcrs.log.pojo.InterfaceLogVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 设备交换日志
 * @author 林俊杰
 * @date 2022/11/30
 */
@Mapper
public interface DeviceExchangeLogMapper extends BaseMapper<DeviceExchangeLog> {

    /**
     * 查询所有的设备交换日志
     * @return
     */
    List<DeviceExchangeLogVo> queryAll(Map map);

    /**
     * 计数
     * @return
     */
    int count(@Param("equipmentId") String equipmentId,
              @Param("equipmentContinuePort") String equipmentContinuePort,
              @Param("processName") String processName,
              @Param("operateName") String operateName,
              @Param("exchangeTime")String exchangeTime);

    /**
     * 设备交换日志添加
     * @param deviceExchangeLog
     */
    void addDeviceExchangeLog(DeviceExchangeLog deviceExchangeLog);

    /**
     * 设备交换日志删除
     */
    void removeDeviceExchangeLog(int deviceExchangeLogId);


}
