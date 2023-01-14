package com.zimax.mcrs.log.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.log.pojo.AbnLog;
import com.zimax.mcrs.log.pojo.InterfaceLog;
import com.zimax.mcrs.log.service.AbnLogService;
import com.zimax.mcrs.log.service.InterfaceLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 异常日志管理
 * @author 林俊杰
 * @date 2023/1/4
 */
@RestController
@RequestMapping("/log")
public class AbnController {
    /**
     * 接口日志管理
     */
    @Autowired
    private AbnLogService abnLogService;


    /**
     *
     * @param equipmentId 设备资源号
     * @param deviceName 终端名称
     * @param abnType 预警类型
     * @param abnLevel 异常等级
     * @param exchangeTime 交互时间
     * @param limit         记录数
     * @param page          页码
     * @param field         排序字段
     * @param order         排序方式
     * @return
     */
    @GetMapping("/abnLog/query")
    public Result<?> query(String limit, String page, String equipmentId, String deviceName, String abnType, String abnLevel, String exchangeTime, String order, String field) {
        List abnLogs = abnLogService.queryAbnLog(limit, page, equipmentId, deviceName,abnType ,abnLevel,exchangeTime,order, field);
        return Result.success(abnLogs, abnLogService.count(equipmentId, deviceName,abnType ,abnLevel,exchangeTime));
    }



    /**
     * 检测设备是否存在
     *
     * @param equipmentInt 设备资源号
     */
    public Result<?> checkAbn(@RequestParam("equipmentInt") int equipmentInt) {
        if(abnLogService.checkEquipment(equipmentInt)>0){
            return Result.success();
        }else {
            return Result.error("1","设备不存在，请先注册设备");
        }

    }

    /**
     * 添加异常日志
     *
     * @param abnLog 异常日志信息
     */
    @PostMapping("/abnLog/add")
    public Result<?> addAbnLog(@RequestBody AbnLog abnLog) {
        //检测设备是否存在
        if(abnLogService.checkEquipment(abnLog.getEquipmentInt())>0){
            //设备存在，添加异常日志
            abnLogService.addAbnLog(abnLog);
            return Result.success();
        }else {
            //返回设备不存在信息
            return Result.error("1","设备不存在，请先注册设备");
        }
    }


    /**
     * 删除异常日志
     *
     * @param abnLogId 依据异常日志主键删除
     */
    @DeleteMapping("/abnLog/delete/{abnLogId}")
    public Result<?> removeAbnLog(@PathVariable("abnLogId") int abnLogId){
        abnLogService.removeAbnLog(abnLogId);
        return Result.success();
    }

}
