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
    public void deleteCreateTime(Date createTime) {
        deviceExchangeLogService.deleteDeviceExchangeLog();
    }

    /**
     * 依据设备交换日志Id删除
     * @param deviceExchangeLogId 设备交换日志编号数组
     */
    @DeleteMapping("/delete/{deviceExchangeLogId}")
    public Result<?> deleteDeviceExchangeLog (@PathVariable("deviceExchangeLogId")int deviceExchangeLogId) {
        deviceExchangeLogService.deleteById(deviceExchangeLogId);
        return Result.success();
    }

    /**
     * 依据设备Id查询
     * @param deviceId 设备id
     * @return deviceExchangeLog
     */
    @GetMapping("/find/{deviceId}")
    public Result<?> getDeviceId(@PathVariable("deviceId") int deviceId) {

        return Result.success(deviceExchangeLogService.queryDeviceId(deviceId));
    }

    /**
     * 依据用户名称查询
     * @param userName 用户名称
     * @return deviceExchangeLog
     */
    @GetMapping("/find/{userName}")
    public Result<?> getUserName(@PathVariable("userName") String userName) {

        return Result.success(deviceExchangeLogService.queryUserName(userName));
    }

    /**
     * 依据设备交换内容查询
     * @param exchangeContent 设备交换内容
     * @return deviceExchangeLog
     */
    @GetMapping("/find/{exchangeContent}")
    public Result<?> getDeviceExchangeLog(@PathVariable("exchangeContent") String exchangeContent) {

        return Result.success(deviceExchangeLogService.queryExchangeContent(exchangeContent));
    }

    /**
     * 依据设备交换创建日期查询
     * @param exchangeTime 创建日期
     * @return deviceExchangeLog
     */
    @GetMapping("/find/{exchangeTime}")
    public Result<?> getExchangeTime(@PathVariable("exchangeTime") Date exchangeTime) {

        return Result.success(deviceExchangeLogService.queryExchangeTime(exchangeTime));
    }

    /**
     * 初始化查询
     * @param limit 记录数
     * @param page 页码
     * @return 设备交换日志列表
     */
    @GetMapping("/find")
    public Result<?> queryAll(int limit, int page) {
        return Result.success(deviceExchangeLogService.queryAll());
    }




}
