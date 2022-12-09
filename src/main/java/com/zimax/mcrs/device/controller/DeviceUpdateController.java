package com.zimax.mcrs.device.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.service.DeviceUpdateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

import static net.sf.jsqlparser.parser.feature.Feature.limit;

/**
 * 终端更新管理
 *
 * @author 林俊杰
 * @date 2022/12/1
 */
@RestController
@ResponseBody
@RequestMapping("/equipment")
public class DeviceUpdateController {

    @Autowired
    private DeviceUpdateService deviceUpdateService;

    /**
     * 查询全部的设备更新信息
     *
     * 查询角色
     * @param equipmentId 设备资源号
     * @param version 版本号
     * @param limit 记录数
     * @param page 页码
     * @param field 排序字段
     * @param order 排序方式
     * @return 更新列表
     */
    @GetMapping("/deviceUpdate/query")
    public Result queryDeviceUpdate(@RequestParam int page, @RequestParam int limit, String equipmentId, String version, String order, String field) {
        List deviceUpdates = deviceUpdateService.queryDeviceUpdate(page,limit,equipmentId,version,order,field);
        return Result.success(deviceUpdates, deviceUpdateService.count(equipmentId,version));
    }


    /**
     * 下载
     *
     * @return
     */
    @RequestMapping("download")
    public void download() {

    }

    /**
     * 删除终端更新信息
     *
     * @param deviceUpdateId 设备数组
     */
    @DeleteMapping("/deviceUpdate/delete/{deviceUpdateId}")
    public Result<?> removeEquipment(@PathVariable("deviceUpdateId") int deviceUpdateId) {
        return Result.success();
    }


}
