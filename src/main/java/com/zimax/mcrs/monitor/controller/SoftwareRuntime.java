package com.zimax.mcrs.monitor.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.monitor.service.AccessMonitorService;
import com.zimax.mcrs.monitor.service.SoftwareRuntimeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 软件运行状态
 * @author 李伟杰
 * @date 2022/12/3
 */
@RestController
@RequestMapping("/SoftwareRuntime")
public class SoftwareRuntime {

    @Autowired
    private SoftwareRuntimeService softwareRuntimeService;

    /**
     * 分页查询软件运行状态(监控模块显示)
     *
     * @param page        页记录数
     * @param limit       页码
     * @param equipmentId 设备资源号
     * @param deviceName       终端名称
     * @param deviceSoType   终端软件类型
     * @param deviceSoRunStatus      终端软件运行状态
     * @param order       排序方式
     * @param field       排序字段
     * @return 信息列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/querySoRuntimes")
    public Result<?> querySoRuntimes(String page, String limit,
                                     String equipmentId, String equipmentName,String deviceName,
                                     String deviceSoType, String deviceSoRunStatus,
                                     String order, String field) {
        List SoRuntimes = softwareRuntimeService.querySoRuntimes(page, limit, equipmentId,equipmentName, deviceName, deviceSoType, deviceSoRunStatus,order, field);
        return Result.success(SoRuntimes, softwareRuntimeService.countSO(equipmentId,equipmentName, deviceName, deviceSoType, deviceSoRunStatus));
    }
}
