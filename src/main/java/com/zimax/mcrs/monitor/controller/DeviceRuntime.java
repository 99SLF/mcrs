package com.zimax.mcrs.monitor.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.monitor.service.AccessMonitorService;
import com.zimax.mcrs.monitor.service.DeviceRuntimeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 终端运行状态
 * @author 李伟杰
 * @date 2022/12/3
 */
@RestController
@RequestMapping("/DeviceRuntime")
public class DeviceRuntime {

    @Autowired
    private DeviceRuntimeService deviceRuntimeService;

    /**
     * 分页查询终端运行状态
     *
     * @param page        页记录数
     * @param limit       页码
     * @param equipmentId 设备资源号
     * @param APPId       APPId
     * @param deviceSoftwareType   终端软件类型
     * @param deviceSoRunStatus      终端软件运行状态
     * @param order       排序方式
     * @param field       排序字段
     * @return 信息列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/query")
    public Result<?> queryDeviceRuntime(String page, String limit,
                                     String equipmentId, String APPId,
                                     String deviceSoftwareType, String deviceSoRunStatus,
                                     String order, String field) {

        List DeviceRuntime = deviceRuntimeService.queryDeviceRuntime(page, limit, equipmentId, APPId, deviceSoftwareType, deviceSoRunStatus,order, field);
        return Result.success(DeviceRuntime, deviceRuntimeService.countDR(equipmentId, APPId, deviceSoftwareType, deviceSoRunStatus));
    }
}
