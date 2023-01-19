package com.zimax.mcrs.log.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.log.pojo.MesLog;
import com.zimax.mcrs.log.pojo.RfidLog;
import com.zimax.mcrs.log.service.MesLogService;
import com.zimax.mcrs.log.service.RfidLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Mes日志管理
 * @author 林俊杰
 * @date 2023/1/13
 */
@RestController
@RequestMapping("/log")
public class MesLogController {

    @Autowired
    private MesLogService mesLogService;


    /**
     *  查询全部的Mes交换日志
     *
     * @param limit  条数
     * @param page 页码
     * @param equipmentName 设备名称
     * @param deviceName 终端名称
     * @param mesIpAddress mes连接IP
     * @param equipmentContinuePort 设备连接端口
     * @param createTime 创建时间
     * @param order
     * @param field
     * @return
     */
    @GetMapping("/mesLog/query")
    public Result<?> query(String limit, String page, String equipmentName, String deviceName, String mesIpAddress, String equipmentContinuePort, String createTime, String order, String field) {
        List mesLogsList = mesLogService.queryMesLog(limit, page, equipmentName, deviceName, mesIpAddress, equipmentContinuePort, createTime, order, field);
        return Result.success(mesLogsList, mesLogService.count(equipmentName, deviceName,mesIpAddress ,equipmentContinuePort,createTime));
    }

    /**
     * 添加Mes交换日志
     *
     * @param mesLog Plc交换日志信息
     */
    @PostMapping("/mesLog/add")
    public Result<?> addMesLog(@RequestBody MesLog mesLog) {
        mesLogService.addMesLog(mesLog);
        return Result.success();
    }


}
