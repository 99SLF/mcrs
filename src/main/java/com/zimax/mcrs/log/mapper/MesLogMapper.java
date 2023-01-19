package com.zimax.mcrs.log.mapper;


import com.zimax.mcrs.log.pojo.*;
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
public interface MesLogMapper {

    /**
     * 查询所有的MES交换日志
     * @return
     */
    List<MesLogVo> queryAll(Map map);

    /**
     * 计数
     * @return
     */
    int count(
            @Param("equipmentName") String equipmentName,
            @Param("deviceName") String deviceName,
            @Param("mesIpAddress") String mesIpAddress,
            @Param("equipmentContinuePort") String equipmentContinuePort,
            @Param("createTime") String createTime
            );

    /**
     * 添加Mes交换日志
     *
     * @return
     */
    void addMesLog(MesLog mesLog);


}
