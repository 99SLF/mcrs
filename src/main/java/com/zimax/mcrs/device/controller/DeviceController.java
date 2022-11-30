package com.zimax.mcrs.device.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.Device;
import com.zimax.mcrs.device.service.DeviceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 设备管理
 * @author 林俊杰
 * @date 2022/11/28
 */
@RestController
@ResponseBody
@RequestMapping("/device")
public class DeviceController {

    @Autowired
    private DeviceService deviceService;

    /**
     * 添加设备
     * @param device 设备信息
     */
    @RequestMapping("/add")
    public Result<?> addDevice(@RequestBody Device device){
        deviceService.addDevice(device);
        return  Result.success();
    }

    /**
     * 更新设备
     * @param device 设备信息
     */
    @PutMapping("/update")
    public Result<?> updateDevice(@RequestBody Device device) {
        deviceService.updateDevice(device);
        return Result.success();
    }

    /**
     * 查询设备
     * @param deviceId 设备信息
     * @return 设备信息
     */
    @GetMapping("/find/{deviceId}")
    public Result<?> getDevice(@PathVariable("deviceId") int deviceId) {

        return Result.success(deviceService.query(deviceId));
    }

    /**
     * 删除设备
     * @param deviceId 设备数组
     */
    @DeleteMapping("/delete/{deviceId}")
    public Result<?> removeDevice(@PathVariable("deviceId")int deviceId) {
        deviceService.deleteById(deviceId);
        return Result.success();
    }

    /**
     * 查询设备
     * @param deviceVersion 角色代码
     * @param userName 角色名字
     * @param limit 记录数
     * @param page 页码
     * @return 角色列表
     */
    @GetMapping("/query")
    public Result<?> queryDevice() {
        return Result.success(deviceService.queryAll());
    }

}
