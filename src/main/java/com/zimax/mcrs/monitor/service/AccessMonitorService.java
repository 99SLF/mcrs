package com.zimax.mcrs.monitor.service;

import com.zimax.mcrs.monitor.pojo.AccessStatus;
import com.zimax.mcrs.monitor.mapper.AccessMonitorMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author 李伟杰
 * @date 2022/12/12 0:27
 */
@Service
public class AccessMonitorService {
    @Autowired
    private AccessMonitorMapper accessMonitorMapper;
    /**
     * 添加监控信息
     * @param accessStatus 监控信息
     */
    public void addAccessMonitor(AccessStatus accessStatus){

        accessMonitorMapper.addAccessMonitor(accessStatus);
    }
}
