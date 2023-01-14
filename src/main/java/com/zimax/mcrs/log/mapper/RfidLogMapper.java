package com.zimax.mcrs.log.mapper;


import com.zimax.mcrs.log.pojo.PlcLog;
import com.zimax.mcrs.log.pojo.PlcLogVo;
import com.zimax.mcrs.log.pojo.RfidLog;
import com.zimax.mcrs.log.pojo.RfidLogVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * rfid日志操作
 * @author 林俊杰
 * @date 2023/1/13
 */
@Mapper
public interface RfidLogMapper {

    /**
     * 查询所有的rfid交换日志
     * @return
     */
    List<RfidLogVo> queryAll(Map map);

    /**
     * 计数
     * @return
     */
    int count(
            @Param("equipmentId") String equipmentId,
            @Param("deviceName") String deviceName,
            @Param("rfidId") String rfidId,
            @Param("equipmentIp") String equipmentIp,
            @Param("equipmentContinuePort") String equipmentContinuePort,
            @Param("createTime") String createTime
            );

    /**
     * 添加Rfid交换日志
     *
     * @return
     */
    void addRfidLog(RfidLog rfidLog);

    /**
     * 删除日志
     */
     void removeRfidLog(int rfidLogId);


}
