package com.zimax.mcrs.log.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.log.pojo.PlcLog;
import com.zimax.mcrs.log.pojo.RfidLog;
import com.zimax.mcrs.log.service.PlcLogService;
import com.zimax.mcrs.log.service.RfidLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Rfid日志管理
 * @author 林俊杰
 * @date 2023/1/13
 */
@RestController
@RequestMapping("/log")
public class RfidLogController {

    @Autowired
    private RfidLogService rfidLogService;


    /**
     *  查询全部的rfid交换日志
     *
     * @param limit  条数
     * @param page 页码
     * @param equipmentId 设备资源号
     * @param deviceName 终端名称
     * @param rfidId RFID-ID
     * @param equipmentIp 设备连接IP
     * @param equipmentContinuePort 设备连接端口
     * @param createTime 创建时间
     * @param order
     * @param field
     * @return
     */
    @GetMapping("/rfidLog/query")
    public Result<?> query(String limit, String page, String equipmentId, String deviceName, String rfidId, String equipmentIp,String equipmentContinuePort, String createTime, String order, String field) {
        List rfidLogList = rfidLogService.queryRfidLog(limit,page, equipmentId, deviceName,rfidId ,equipmentIp,equipmentContinuePort,createTime,order, field);
        return Result.success(rfidLogList, rfidLogService.count(equipmentId, deviceName,rfidId ,equipmentIp,equipmentContinuePort,createTime));
    }

    /**
     * 添加登录日志
     *
     * @param rfidLog Plc交换日志信息
     */
    @PostMapping("/rfidLog/add")
    public Result<?> addRfidLog(@RequestBody RfidLog rfidLog) {
        rfidLogService.addRfidLog(rfidLog);
        return Result.success();
    }


    /**
     * 删除Rfid交换日志
     *
     * @param rfidLogId 根据rfid交换日志主键删除
     */
    @DeleteMapping("/rfidLog/delete/{rfidLogId}")
    public Result<?> removeRfidLog(@PathVariable("rfidLogId") int rfidLogId){
        rfidLogService.removeRfidLog(rfidLogId);
        return Result.success();
    }

}
