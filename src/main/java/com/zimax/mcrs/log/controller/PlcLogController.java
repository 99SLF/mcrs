package com.zimax.mcrs.log.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.log.pojo.LoginLog;
import com.zimax.mcrs.log.pojo.PlcLog;
import com.zimax.mcrs.log.service.LoginLogService;
import com.zimax.mcrs.log.service.PlcLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Plc日志管理
 * @author 林俊杰
 * @date 2023/1/13
 */
@RestController
@RequestMapping("/log")
public class PlcLogController {

    @Autowired
    private PlcLogService plcLogService;


    /**
     *  查询全部的plc交换日志
     *
     * @param limit  条数
     * @param page 页码
     * @param equipmentId 设备资源号
     * @param deviceName 终端名称
     * @param plcGroupName plc分组名称
     * @param groupType 分组类型
     * @param createTime 创建时间
     * @param order
     * @param field
     * @return
     */
    @GetMapping("/plcLog/query")
    public Result<?> query(String limit, String page, String equipmentId, String deviceName, String plcGroupName, String groupType, String createTime, String order, String field) {
        List plcLogList = plcLogService.queryPlcLog(limit,page, equipmentId, deviceName,plcGroupName ,groupType,createTime,order, field);
        return Result.success(plcLogList, plcLogService.count(equipmentId, deviceName,plcGroupName ,groupType,createTime));
    }

    /**
     * 添加登录日志
     *
     * @param plcLog Plc交换日志信息
     */
    @PostMapping("/plcLog/add")
    public Result<?> addPlcLog(@RequestBody PlcLog plcLog) {
        plcLogService.addPlcLog(plcLog);
        return Result.success();
    }


    /**
     * 删除Plc交换日志
     *
     * @param plcLogId 根据Plc交换日志主键删除
     */
    @DeleteMapping("/plcLog/delete/{plcLogId}")
    public Result<?> removePlcLog(@PathVariable("plcLogId") int plcLogId){
        plcLogService.removePlcLog(plcLogId);
        return Result.success();
    }

}
