package com.zimax.mcrs.monitor.mapper;

import com.zimax.mcrs.monitor.pojo.AccessStatus;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author 李伟杰
 * @date 2022/12/12 0:32
 */
@Mapper
public interface AccessMonitorMapper {
    /**
     * 添加监控信息
     * @param accessStatus 监控信息
     * @return
     */
    void addAccessMonitor(AccessStatus accessStatus);
}
