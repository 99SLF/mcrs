package com.zimax.mcrs.monitor.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.monitor.pojo.AccessStatus;
import com.zimax.mcrs.monitor.service.AccessMonitorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 对外监测类型
 * @author 李伟杰
 * @date 2022/12/12 0:22
 */
@RestController
@RequestMapping("/AccessMonitor")
public class AccessMonitor {

    @Autowired
    private AccessMonitorService  accessMonitorService;
    /**
     * 记录接入状态信息
     *
     * @param accessStatus 接入状态
     */
    @PostMapping("/add")
    public Result<?> addAccessMonitor(@RequestBody AccessStatus accessStatus) {
        /**
         * @param 设备资源号,APPID,接入类型,接入状态,天线状态（非必填）,终端软件类型,终端软件运行状态,CPU使用率,内存使用量,发生时间
         * @return
         */
        accessMonitorService.addAccessMonitor(accessStatus);
        return Result.success();
    }




}
