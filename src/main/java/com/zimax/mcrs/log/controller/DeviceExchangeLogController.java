package com.zimax.mcrs.log.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.log.pojo.DeviceExchangeLog;
import com.zimax.mcrs.log.pojo.DeviceExchangeLogVo;
import com.zimax.mcrs.log.pojo.InterfaceLog;
import com.zimax.mcrs.log.pojo.LoginLogVo;
import com.zimax.mcrs.log.service.DeviceExchangeLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

/**
 * 设备交换日志管理
 *
 * @author 林俊杰
 * @date 2022/11/30
 */
@RestController
@ResponseBody
@RequestMapping("/log")
public class DeviceExchangeLogController {

    @Autowired
    private DeviceExchangeLogService deviceExchangeLogService;

    /**
     * 查询
     * @param limit 条数
     * @param page 页码
     * @param logStatus 日志状态
     * @param equipmentId 设备资源号
     * @param equipmentName 设备名称
     * @param matrixName 基地名称
     * @param factoryName 工厂名称
     * @param processName 工序名称
     * @param operationType 操作类型
     * @param equipmentContinuePort 设备连接端口
     * @param operateName 操作人名称
     * @param equipmentExchangeTime 设备交换时间
     * @param order
     * @param field
     * @return
     */
    @GetMapping("/deviceExchangeLog/query")
    public Result<?> queryDeviceExchange(String limit, String page, String logStatus, String equipmentId,String equipmentName,String matrixName, String factoryName, String processName, String operationType,String equipmentContinuePort, String operateName, String equipmentExchangeTime, String order, String field) {
        List deviceExchangeLogs = deviceExchangeLogService.queryDeviceExchangeLog(limit, page, logStatus,equipmentId,equipmentName,matrixName,factoryName, processName,operationType,equipmentContinuePort,operateName,equipmentExchangeTime, order, field);
        return Result.success(deviceExchangeLogs, deviceExchangeLogService.count(logStatus,equipmentId,equipmentName,matrixName,factoryName, processName,operationType,equipmentContinuePort,operateName,equipmentExchangeTime));
    }

    /**
     * 添加设备交换日志
     * @param deviceExchangeLog 设备交换日志
     */
    @PostMapping("/deviceExchangeLog/add")
    public Result<?> addDeviceExchangeLog(@RequestBody DeviceExchangeLog deviceExchangeLog) {
        deviceExchangeLogService.addDeviceExchangeLog(deviceExchangeLog);
        return Result.success();
    }

    /**
     * 使用POST方式查询日志给CS端
     */
    @PostMapping("/deviceExchangeLog/CSquery")
    public Result<?> csQuery(@RequestBody DeviceExchangeLogVo deviceExchangeLogVo) {
        List deviceExchangeLogs = deviceExchangeLogService.csQuery(deviceExchangeLogVo.getAPPId());
        return Result.success(deviceExchangeLogs);
    }

}
