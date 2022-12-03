package com.zimax.mcrs.device.controller;


import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.Device;
import com.zimax.mcrs.device.service.DeviceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 终端管理
 * @author 林俊杰
 * @date 2022/11/30
 */
@RestController
@ResponseBody
@RequestMapping("/device")
public class DeviceController {

    @Autowired
    private DeviceService deviceService;

    /**
     * 注册终端
     * @param device 终端
     */
    @RequestMapping("/registrationDevice")
    public Result<?> registrationDevice(@RequestBody Device device) {
        deviceService.registrationDevice(device);
        return  Result.success();
    }

    /**
     * 注销终端
     * @param APPID 依据APPDId来注销终端
     */
    @DeleteMapping("/logoutTerminal/{APPId}")
    public Result<?> logoutTerminal(@PathVariable("APPId")int APPID) {
//        terminalService.logoutById(APPID);
        return Result.success();
    }

    /**
     * 查询终端
     * @param APPID 依据APPDId来查询终端
     */
    @GetMapping("/find/{APPId}")
    public Result<?> getTerminalAPPId(@PathVariable("APPId") int APPID) {

        return Result.success(deviceService.queryAPPId(APPID));
    }

    /**
     * 查询终端
     * @param equipmentId 依据设备资源号来查询终端
     */
    @GetMapping("/find/{equipmentId}")
    public Result<?> getTerminalDeviceId(@PathVariable("equipmentId") int equipmentId) {

        return Result.success(deviceService.queryEquipmentId(equipmentId));
    }

    /**
     * 查询终端
     * @param deviceSoftwareType 依据设备软件类型来查询终端
     */
    @GetMapping("/find/{deviceSoftwareType}")
    public Result<?> getDeviceType(@PathVariable("deviceSoftwareType") String deviceSoftwareType) {


        return Result.success();
    }

    /**
     * 初始化查询
     * @param APPId APPId
     * @param equipmentId 设备资源号
     * @param limit 记录数
     * @param page 页码
     */
    @GetMapping("/query}")
    public Result<?> queryDevice(int APPId, int equipmentId, int page, int limit) {

        return Result.success(deviceService.queryAll());
    }
}
