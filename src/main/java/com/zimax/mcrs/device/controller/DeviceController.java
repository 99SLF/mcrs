package com.zimax.mcrs.device.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.Device;
import com.zimax.mcrs.device.service.DeviceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 设备管理
 *
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
     * 初始化查询
     *
     * @param deviceVersion 设备版本号
     * @param userName      用户名名字
     * @param limit         记录数
     * @param page          页码
     * @return 角色列表
     */
    @GetMapping("/query")
    public Result<?> queryDevices(@RequestParam String deviceVersion, @RequestParam String userName, @RequestParam int limit, @RequestParam int page) {
        return Result.success();
    }

    /**
     * 查询设备
     *
     * @param deviceId 设备信息
     * @return 设备信息
     */
    @GetMapping("/find/{deviceId}")
    public Result<?> getDevice(@PathVariable("deviceId") int deviceId) {

        return Result.success();
    }

    /**
     * 添加设备
     *
     * @param device 设备信息
     */
    @RequestMapping("/add")
    public Result<?> addDevice(@RequestBody Device device) {
        return Result.success();
    }

    /**
     * 删除设备
     *
     * @param deviceId 设备数组
     */
    @DeleteMapping("/delete/{deviceId}")
    public Result<?> removeDevice(@PathVariable("deviceId") int deviceId) {
        return Result.success();
    }

    /**
     * 更新设备
     *
     * @param device 设备信息
     */
    @PutMapping("/update")
    public Result<?> updateDevice(@RequestBody Device device) {
        return Result.success();
    }


}
