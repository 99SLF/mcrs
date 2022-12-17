package com.zimax.mcrs.device.controller;


import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.Device;
import com.zimax.mcrs.device.service.DeviceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * 终端管理
 *
 * @author 林俊杰
 * @date 2022/11/30
 */
@RestController
@ResponseBody
@RequestMapping("/equipment")
public class DeviceController {

    @Autowired
    private DeviceService deviceService;

    /**
     * 注册终端
     *
     * @param device 终端
     */
    @PostMapping("/device/registrationDevice")
    public Result<?> registrationDevice(@RequestBody Device device) throws Exception {
        deviceService.registrationDevice(device);
        return Result.success();
    }

    /**
     * 注销终端
     *
     * @param deviceId 依据deviceId来注销终端
     */
    @DeleteMapping("/device/logoutDevice/{deviceId}")
    public Result<?> logoutTerminal(@PathVariable("deviceId") int deviceId) {

        deviceService.logoutDevice(deviceId);
        return Result.success();
    }


    /**
     * 修改终端
     *
     * @param device 终端
     */
    @PostMapping("/device/update")
    public Result<?> updateDevice(@RequestBody Device device) {
        deviceService.updateDevice(device);
        return Result.success();
    }

    /**
     * 条件查询
     *
     * @param APPId       APPId
     * @param equipmentId 设备资源号
     * @param limit       记录数
     * @param page        页码
     * @param field       排序字段
     * @param order       排序方式
     * @return 终端列表
     */
    @GetMapping("/device/query")
    public Result<?> queryDevice(String page, String limit, String equipmentId, String APPId, String order, String field) {
        List devices = deviceService.queryDevices(page, limit, equipmentId, APPId, order, field);
        return Result.success(devices, deviceService.count(equipmentId, APPId));
    }

    /**
     * 查询数据给监控
     */
    @GetMapping("/device/monitor")
    public Result toMonitor(String equipmentId, String APPId){
        List devices = deviceService.toMonitor();
        return  Result.success(devices,deviceService.count(equipmentId,APPId));
    }


    /**
     * 批量删除终端信息
     *
     * @param deviceIds 用户操作编号数组
     */
    @DeleteMapping("device/batchDelete")
    public Result<?> deleteDevices(@RequestBody Integer[] deviceIds) {
        deviceService.deleteDevices(Arrays.asList(deviceIds));
        return Result.success();

    }

}
