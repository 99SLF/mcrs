package com.zimax.mcrs.device.controller;


import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.components.websocket.WebSocket;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.Device;
import com.zimax.mcrs.device.service.DeviceService;
import com.zimax.mcrs.log.service.OperationLogService;
import com.zimax.mcrs.monitor.pojo.monDeviceStatus.MonitorDeviceStatus;
import com.zimax.mcrs.monitor.service.AccessMonitorService;
import com.zimax.mcrs.update.service.UpdateConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * 终端管理
 *
 * @author 林俊杰,李伟杰
 * @date 2022/11/30
 */
@RestController
@ResponseBody
@RequestMapping("/equipment")
public class DeviceController {

    @Autowired
    private DeviceService deviceService;

    @Autowired
    private OperationLogService operationLogService;

    //监控
    @Autowired
    private AccessMonitorService accessMonitorService;
    //删除配置文件
    @Autowired
    private UpdateConfigService updateConfigService;

    /**
     * 注册终端
     *
     * @param device 终端
     */
    @PostMapping("/device/registrationDevice")
    public Result<?> registrationDevice(@RequestBody Device device) {
        IUserObject useObject = DataContextManager.current().getMUODataContext().getUserObject();
        device.setRegisterStatus("102");
        device.setVersion("1.0");
        device.setCreator(useObject.getUserId());
        device.setCreateTime(new Date());

        //当终端注册的时候，在终端状态表中生成一条该终端名称的终端状态初始化信息(监控信息)
        String APPId = device.getAPPId();
        MonitorDeviceStatus monitorDeviceStatus = new MonitorDeviceStatus();
        monitorDeviceStatus.setAppId(APPId);
        accessMonitorService.addMonitorDeviceReal(monitorDeviceStatus);

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

        //根据终端主键获取终端信息（名称）
        String appId= deviceService.getDeviceName(deviceId).getAPPId();
        //通过终端名称修改实时终端监控表
        accessMonitorService.deleteDeviceStatus(appId);
        deviceService.logoutDevice(deviceId);
        updateConfigService.delConfigurationFileByAppId(appId);
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
     * @param deviceSoftwareType 终端软件类型
     * @param deviceName         终端名称
     * @param limit              记录数
     * @param page               页码
     * @param field              排序字段
     * @param order              排序方式
     * @return 终端列表
     */
    @GetMapping("/device/query")
    public Result<?> queryDevice(String page, String limit, String equipmentId, String deviceSoftwareType, String enable, String deviceName, String processName, String factoryName,
                                 String version, String needUpdate, String registerStatus, String programInstallationPath, String createTime, String order, String field) {
        List devices = deviceService.queryDevices(page, limit, equipmentId, deviceSoftwareType, enable, deviceName, processName, factoryName, version, needUpdate, registerStatus, programInstallationPath, createTime, order, field);
        return Result.success(devices, deviceService.counts(equipmentId, deviceSoftwareType, enable, deviceName, processName, factoryName, version, needUpdate, registerStatus, programInstallationPath, createTime));
    }

    /**
     * 查询数据给监控
     */
    @GetMapping("/device/monitor")
    public Result toMonitor(String equipmentId, String APPId) {
        List devices = deviceService.toMonitor();
        return Result.success(devices, deviceService.count(equipmentId, APPId));
    }


    /**
     * 批量删除终端信息
     *
     * @param deviceIds 设备主键数组
     */
    @DeleteMapping("/device/batchDelete")
    public Result<?> deleteDevices(@RequestBody Integer[] deviceIds) {
        deviceService.deleteDevices(Arrays.asList(deviceIds));

        return Result.success();

    }

    @GetMapping("/device/count")
    public Result<?> queryCount(String equipmentId, String APPId) {
        return Result.success(deviceService.count(equipmentId, APPId));
    }


    /**
     * 检测APPId是否存在
     *
     * @param APPId 设备资源号
     */
    @GetMapping("/device/check/isExist")
    public Result<?> check(@RequestParam("APPId") String APPId) {
        if (deviceService.checkAPPId(APPId) > 0) {
            return Result.error("1", "当前APPId已存在，请重新选择正确的设备和终端软件类型");
        } else {
            return Result.success();
        }

    }


    /**
     * 检测是否存在终端软件类型对应的更新包
     *
     * @param deviceSoftwareType 终端软件类型
     */
    @GetMapping("/device/checkDST/isExist")
    public Result<?> checkDeviceSoftwareType(@RequestParam("deviceSoftwareType") String deviceSoftwareType) {
        if (deviceService.checkDeviceSoftwareType(deviceSoftwareType) > 0) {
            return Result.success();
        } else {
            return Result.error("1", "当前终端软件类型不存在更新包，请上传更新包后重新注册");
        }

    }

    /**
     * 查询当前选择设备是否被注册
     *
     * @param equipmentInt 设备主键
     * @return
     */
    @GetMapping("/device/checkEquipment/isExist")
    public Result<?> checkEquipment(@RequestParam("equipmentInt") int equipmentInt) {
        System.out.println(equipmentInt);
        if (deviceService.checkEquipment(equipmentInt) > 0) {
            return Result.error("1", "当前选择设备已被注册，请重新选择未注册设备");
        } else {
            return Result.success();
        }
    }

}
