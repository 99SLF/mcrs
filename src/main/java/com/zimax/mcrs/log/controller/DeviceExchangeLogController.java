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
@RequestMapping("/log")
public class  DeviceExchangeLogController {

    @Autowired
    private DeviceExchangeLogService deviceExchangeLogService;


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
     * @param page 页码
     * @return 设备交换日志列表
     */
    @GetMapping("/deviceExchangeLog/query")
    public Result<?> select(@RequestParam int limit, @RequestParam int page) {
        return Result.success();
    }




}
