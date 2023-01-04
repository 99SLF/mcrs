package com.zimax.mcrs.monitor.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.monitor.pojo.DeviceAbn;
import com.zimax.mcrs.monitor.pojo.EquipmentStatus;
import com.zimax.mcrs.monitor.pojo.SoftwareRunStatus;
import com.zimax.mcrs.monitor.service.AccessMonitorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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
     * 新增软件运行状态信息
     *
     *          * @param
     *          * 设备资源号,APPID,终端名称，终端软件类型,终端软件运行状态,CPU使用率,内存使用量,误读率
     *
     *
     * @param softwareRunStatus 软件运行状态
     */
    @PostMapping("/SoftwareRunStatus")
    public Result<?> addSoftwareRunStatus(@RequestBody SoftwareRunStatus softwareRunStatus) {

        accessMonitorService.addSoftwareRunStatus(softwareRunStatus);
        return Result.success();
    }


    /**
     * 新增设备接入状态信息
     *
     *          * @param
     *          * 设备资源号,接入类型,接入状态,天线状态（非必填）
     *
     *
     * @param equipmentStatus 设备运行状态
     */
    @PostMapping("/EquipmentStatus")
    public Result<?> addEquipmentStatus(@RequestBody EquipmentStatus equipmentStatus) {

        accessMonitorService.addEquipmentStatus(equipmentStatus);
        return Result.success();
    }



    /**
     * 新增终端异常预警信息
     *
     *          * @param
     *          *  设备资源号,APPID,终端名称,使用工序,预警标题,预警类型，预警等级，预警内容，,发生时间,备注
     *
     *
     * @param deviceAbn 终端异常预警信息
     */
    @PostMapping("/DeviceAbn")
    public Result<?> addDeviceAbn(@RequestBody DeviceAbn deviceAbn) {

        accessMonitorService.addDeviceAbn(deviceAbn);
        return Result.success();
    }

}
