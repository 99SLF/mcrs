package com.zimax.mcrs.log.mapper;


import com.zimax.mcrs.log.pojo.PlcLog;
import com.zimax.mcrs.log.pojo.PlcLogVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Plc日志操作
 * @author 林俊杰
 * @date 2023/1/13
 */
@Mapper
public interface PlcLogMapper {

    /**
     * 查询所有的plc日志日志
     * @return
     */
    List<PlcLogVo> queryAll(Map map);

    /**
     * 计数
     * @return
     */
    int count(
            @Param("equipmentId") String equipmentId,
            @Param("deviceName") String deviceName,
            @Param("plcGroupName") String plcGroupName,
            @Param("groupType") String groupType,
            @Param("createTime") String createTime
            );

    /**
     * 添加Plc交换日志
     *
     * @return
     */
    void addPlcLog(PlcLog plcLog);

    /**
     * 删除日志
     */
     void removePlcLog(int plcLogId);


}
