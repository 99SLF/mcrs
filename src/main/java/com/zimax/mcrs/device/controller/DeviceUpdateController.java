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

     * @param deviceVersion 版本号
     * @param deviceSoftwareType 终端软件类型
     * @param limit         记录数
     * @param page          页码
     * @return
     */
    @RequestMapping("/query")
    public Result query(@RequestParam int deviceVersion, @RequestParam String deviceSoftwareType, @RequestParam int limit, @RequestParam int page) {
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
     * 下载
     * @return
     */
    @RequestMapping("download")
    public void download(){

    }

    /**
     * 删除终端更新信息
     *
     * @param deviceUpdateId 设备数组
     */
    @DeleteMapping("/delete/{deviceUpdateId}")
    public Result<?> removeEquipment(@PathVariable("deviceUpdateId") int deviceUpdateId) {
        return Result.success();
    }


}
