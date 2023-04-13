package com.zimax.mcrs.log.mapper;

import com.zimax.mcrs.log.pojo.LogFile;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @Author 施林丰
 * @Date:2023/3/31 14:29
 * @Description
 */
@Mapper
public interface LogFileMapper {
    /**
     * 添加日志文件信息
     * @param logFile 报表信息
     * @return
     */
    void addLogFile(LogFile logFile);

    /**
     * 查询日志文件信息
     * @param
     * @return
     */
    List<LogFile> queryLogFile(Map map);

    /**
     * 更新日志文件信息
     * @param
     * @return
     */
    void updateLogFile(LogFile logFile);
    int count(@Param("logType") String logType,
              @Param("equipmentId") String equipmentId,
              @Param("logTime") String logTime);
}
