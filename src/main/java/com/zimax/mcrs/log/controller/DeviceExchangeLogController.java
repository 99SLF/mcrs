package com.zimax.mcrs.log.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.log.pojo.DeviceExchangeLog;
import com.zimax.mcrs.log.pojo.InterfaceLog;
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
     *
     * @param equipmentId           设备资源号
     * @param equipmentContinuePort 设备连接端口
     * @param processName           使用工序名称
     * @param operateName           依据USER_ID查询 USER_NAME
     * @param exchangeTime          交换时间
     * @param limit                 记录数
     * @param page                  页码
     * @param field                 排序字段
     * @param order                 排序方式
     * @return 设备列表
     */
    @GetMapping("/deviceExchangeLog/query")
    public Result<?> queryDeviceExchange(String limit, String page, String equipmentId, String equipmentContinuePort, String processName, String operateName, String exchangeTime, String order, String field) {
        List deviceExchangeLogs = deviceExchangeLogService.queryDeviceExchangeLog(limit, page, equipmentId, equipmentContinuePort, processName, operateName, exchangeTime, order, field);
        return Result.success(deviceExchangeLogs, deviceExchangeLogService.count(equipmentId, equipmentContinuePort, processName, operateName, exchangeTime));
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
     * 删除设备交换日志
     * @param deviceExchangeLogId 设备交换日志主键
     */
    @DeleteMapping("/deviceExchangeLog/delete/{deviceExchangeLogId}")
    public Result<?> removeDeviceExchangeLog(@PathVariable("deviceExchangeLogId") int deviceExchangeLogId) {
        deviceExchangeLogService.removeDeviceExchangeLog(deviceExchangeLogId);
        return Result.success();
    }

}
