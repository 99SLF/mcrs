package com.zimax.mcrs.log.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.log.pojo.PlcLog;
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
     * 查询
     * @param limit 条数
     * @param page 页码
     * @param equipmentId 设备资源号
     * @param equipmentName 设备名称
     * @param deviceName 终端名称
     * @param plcGroupName PLC组别名称
     * @param groupType 组别类型
     * @param tagName 标签名称
     * @param createName 创建人
     * @param createTime 创建时间
     * @param order
     * @param field
     * @return
     */
    @GetMapping("/plcLog/query")
    public Result<?> query(String limit, String page, String equipmentId,String equipmentName,String deviceName,String plcGroupName,
                           String groupType,String tagName,String createName,String createTime, String order, String field) {
        List plcLogList = plcLogService.queryPlcLog(limit,page, equipmentId,equipmentName,deviceName,plcGroupName,groupType,tagName,createName,createTime,order, field);
        return Result.success(plcLogList, plcLogService.count(equipmentId,equipmentName,deviceName,plcGroupName,groupType,tagName,createName,createTime));
    }

    /**
     * 添加PLC交换日志
     *
     * @param plcLog Plc交换日志信息
     */
    @PostMapping("/plcLog/add")
    public Result<?> addPlcLog(@RequestBody PlcLog plcLog) {
        plcLogService.addPlcLog(plcLog);
        return Result.success();
    }

}
