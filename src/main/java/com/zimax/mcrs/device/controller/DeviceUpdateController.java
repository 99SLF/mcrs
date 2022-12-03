package com.zimax.mcrs.device.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.service.DeviceUpdateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 终端更新管理
 * @author 林俊杰
 * @date 2022/12/1
 */
@RestController
@ResponseBody
@RequestMapping("/terminalRenew")
public class DeviceUpdateController {

    @Autowired
    private DeviceUpdateService deviceUpdateService;

    /**
     * 查询全部的设备更新信息
     * @param terminalRenewId 设备更新编号
     * @param limit 记录数
     * @param page 页码
     * @return
     */
    @RequestMapping("/query")
    public Result queryAll(@RequestParam int terminalRenewId, int limit, int page) {
        return Result.success();
    }

    /**
     * 上传
     * @return
     */
    @RequestMapping("upload")
    public void upload(){

    }

    /**
     * 导出设备更新信息
     * @param terminalRenewId 设备更新编号
     * @return
     */
    @RequestMapping("/print/{terminalRenewId}")
    public void printTerminalRenew(@PathVariable("terminalRenewId") int terminalRenewId){

    }

    /**
     * 升级终端
     * @param terminalRenewId 设备更新编号
     * @return
     */
    @RequestMapping("upgrade")
    public void upgradeTerminalRenew(@PathVariable("PathVariable") int terminalRenewId){

    }

    /**
     * 回退终端
     * @param deviceUpdateId 设备更新编号
     * @return
     */
    @RequestMapping("follback")
    public void rollBackTerminalRenew(@PathVariable("deviceUpdateId") int deviceUpdateId){

    }

    /**
     * 依据终端更新编码查询
     * @param deviceUpdateId 设备更新编号
     * @return
     */
    @RequestMapping("queryDeviceUpdateId")
    public void queryTerminalRenewId(@PathVariable("deviceUpdateId") int deviceUpdateId){

    }


}
