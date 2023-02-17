package com.zimax.mcrs.monitor.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.monitor.pojo.monDeviceStatus.MonitorDeviceHistory;
import com.zimax.mcrs.monitor.pojo.monDeviceStatus.MonitorDeviceStatus;
import com.zimax.mcrs.monitor.service.AccessMonitorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.Date;
import java.util.List;

/**
 * 对外监测类型
 *
 * @author 李伟杰
 * @date 2022/12/12 0:22
 */
@RestController
@RequestMapping("/AccessMonitor")
public class AccessMonitor {

    @Autowired
    private AccessMonitorService accessMonitorService;

//    /**
//     * 新增软件运行状态信息
//     *
//     *          * @param
//     *          * 设备资源号,APPID,终端名称，终端软件类型,终端软件运行状态,CPU使用率,内存使用量,误读率
//     *
//     *
//     * @param softwareRunStatus 软件运行状态
//     */
//    @PostMapping("/SoftwareRunStatus")
//    public Result<?> addSoftwareRunStatus(@RequestBody SoftwareRunStatus softwareRunStatus) {
//
//        accessMonitorService.addSoftwareRunStatus(softwareRunStatus);
//        return Result.success();
//    }
//
//
//    /**
//     * 新增设备接入状态信息
//     *
//     *          * @param
//     *          * 设备资源号,接入类型,接入状态,天线状态（非必填）
//     *
//     *
//     * @param equipmentStatus 设备运行状态
//     */
//    @PostMapping("/EquipmentStatus")
//    public Result<?> addEquipmentStatus(@RequestBody EquipmentStatus equipmentStatus) {
//
//        accessMonitorService.addEquipmentStatus(equipmentStatus);
//        return Result.success();
//    }
//
//
//
//    /**
//     * 新增终端异常预警信息
//     *
//     *          * @param
//     *          *  设备资源号,APPID,终端名称,使用工序,预警标题,预警类型，预警等级，预警内容，,发生时间,备注
//     *
//     *
//     * @param deviceAbn 终端异常预警信息
//     */
//    @PostMapping("/DeviceAbn")
//    public Result<?> addDeviceAbn(@RequestBody DeviceAbn deviceAbn) {
//
//        accessMonitorService.addDeviceAbn(deviceAbn);
//        return Result.success();
//    }


    /**
     * 对外获取终端设备，硬件软件的运行状态（表+++mon_device_history）
     */
    @PostMapping("/deviceStatus")
    public Result<?> addMonitorDeviceStatus(@RequestBody MonitorDeviceHistory monitorDeviceHistory) {


        String deviceName = monitorDeviceHistory.getDeviceName();
        String accessType = monitorDeviceHistory.getAccessType();
        String accessStatus = monitorDeviceHistory.getAccessStatus();
        String deviceSoftwareStatus = monitorDeviceHistory.getDeviceSoftwareStatus();
        String antennaStatus = monitorDeviceHistory.getAntennaStatus();
        String warningContent = monitorDeviceHistory.getWarningContent();
        String cpuRate = monitorDeviceHistory.getCpuRate();
        String storageRate = monitorDeviceHistory.getStorageRate();
        String errorRate = monitorDeviceHistory.getErrorRate();
        Date occurrenceTime = monitorDeviceHistory.getOccurrenceTime();
        String remarks = monitorDeviceHistory.getRemarks();

        //调试
        MonitorDeviceStatus monitorDeviceStatus = new MonitorDeviceStatus();
        monitorDeviceStatus.setDeviceName(deviceName);
        monitorDeviceStatus.setAccessType(accessType);
        monitorDeviceStatus.setAccessStatus(accessStatus);
        monitorDeviceStatus.setDeviceSoftwareStatus(deviceSoftwareStatus);
        monitorDeviceStatus.setAntennaStatus(antennaStatus);
        monitorDeviceStatus.setWarningContent(warningContent);
        monitorDeviceStatus.setCpuRate(cpuRate);
        monitorDeviceStatus.setStorageRate(storageRate);
        monitorDeviceStatus.setErrorRate(errorRate);
        monitorDeviceStatus.setOccurrenceTime(occurrenceTime);
        monitorDeviceStatus.setRemarks(remarks);
        //调用修改终端实时表的接口
        int i = accessMonitorService.updateMonitorDeviceStatus(monitorDeviceStatus);
        if (i == 0) {
            return Result.error("1", "终端未注册");
        }
        return Result.success();

    }


    @GetMapping("/deviceAndaccess")
    public Result<?> getEqiAndAccess() {
        return Result.success(accessMonitorService.getEqiAndAccess());
    }

    @GetMapping("/processAndeqi")
    public Result<?> queryProcessAndeqi() {
        return Result.success(accessMonitorService.queryProcessAndeqi());
    }

    @GetMapping("/queryProcessAndFactory")
    public Result<?> queryProcessAndFactory() {
        return Result.success(accessMonitorService.queryProcessAndFactory());
    }

}
