package com.zimax.mcrs.device.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.service.DeviceUpdateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

import static net.sf.jsqlparser.parser.feature.Feature.limit;

/**
 * 终端更新管理
 * @author 林俊杰
 * @date 2022/12/1
 */
@RestController
@ResponseBody
@RequestMapping("/deviceUpdate")
public class DeviceUpdateController {

    @Autowired
    private DeviceUpdateService deviceUpdateService;

    /**
     * 查询全部的设备更新信息
     * @param deviceUpdateId 终端更新编码
     * @param clientAddress 客户端地址
     * @param serverAddress 服务器地址
     * @param repeatName 文件是否重名
     * @param scopeApplication 适用范围
     * @param deviceVersion 版本号
     * @param updatePeople 更新人
     * @param updateTime 更新时间
     * @param limit         记录数
     * @param page          页码
     * @return
     */
    @RequestMapping("/query")
    public Result query(@RequestParam int deviceUpdateId, @RequestParam String clientAddress, @RequestParam String serverAddress, @RequestParam String repeatName, @RequestParam String scopeApplication, @RequestParam String deviceVersion, @RequestParam String updatePeople, @RequestParam Date updateTime, @RequestParam int limit, @RequestParam int page) {
        return Result.success();
    }

    /**
     * 初始化查询
     * @return
     */
    @GetMapping("/find/{deviceUpdateId}")
    public Result<?> queryAll(@PathVariable("deviceUpdateId") int deviceUpdateId) {

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
