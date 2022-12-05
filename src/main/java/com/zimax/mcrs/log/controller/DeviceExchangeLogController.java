package com.zimax.mcrs.log.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.log.service.DeviceExchangeLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

/**
 * 设备交换日志管理
 * @author 林俊杰
 * @date 2022/11/30
 */
@RestController
@ResponseBody
@RequestMapping("/deviceExchangeLog")
public class DeviceExchangeLogController {

    @Autowired
    private DeviceExchangeLogService deviceExchangeLogService;

    /**
     * 依据创建日期定时删除
     * @param createTime 设备交换日志ID数组
     */
    public void removeCreateTime(Date createTime) {


    }

    /**
     * 依据设备交换日志Id删除
     * @param deviceExchangeLogId 设备交换日志编号数组
     */
    @DeleteMapping("/delete/{deviceExchangeLogId}")
    public Result<?> removeDeviceExchangeLog (@PathVariable("deviceExchangeLogId")int deviceExchangeLogId) {
        return Result.success();
    }

    /**
     * 初始化查询
     * @param deviceId 设备id
     * @return deviceExchangeLog
     */
    @GetMapping("/find/{deviceId}")
    public Result<?> queryAll(@PathVariable("deviceId") int deviceId) {
        return null;
    }

    /**
     * 条件查询
     * @param page 页码
     * @return 设备交换日志列表
     */
    @GetMapping("/query")
    public Result<?> select(@RequestParam int limit, @RequestParam int page) {
        return Result.success();
    }




}
