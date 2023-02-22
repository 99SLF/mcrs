package com.zimax.mcrs.monitor.controller;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.zimax.components.websocket.Util;
import com.zimax.components.websocket.WebSocket;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.monitor.pojo.monDeviceStatus.MonitorDeviceAlarm;
import com.zimax.mcrs.monitor.pojo.monDeviceStatus.MonitorDeviceHistory;
import com.zimax.mcrs.monitor.pojo.monDeviceStatus.MonitorDeviceStatus;
import com.zimax.mcrs.monitor.service.AccessMonitorService;
import lombok.SneakyThrows;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.Date;
import java.util.List;

/**
 * 对外监测类型
 *
 * @author 李伟杰
 * @date 2022/12/12 0:22
 */
@RestController
@RequestMapping("/AccessMonitor")
public class AccessMonitor {

    @Autowired
    private AccessMonitorService accessMonitorService;

//    /**
//     * 新增软件运行状态信息
//     *
//     *          * @param
//     *          * 设备资源号,APPID,终端名称，终端软件类型,终端软件运行状态,CPU使用率,内存使用量,误读率
//     *
//     *
//     * @param softwareRunStatus 软件运行状态
//     */
//    @PostMapping("/SoftwareRunStatus")
//    public Result<?> addSoftwareRunStatus(@RequestBody SoftwareRunStatus softwareRunStatus) {
//
//        accessMonitorService.addSoftwareRunStatus(softwareRunStatus);
//        return Result.success();
//    }
//
//
//    /**
//     * 新增设备接入状态信息
//     *
//     *          * @param
//     *          * 设备资源号,接入类型,接入状态,天线状态（非必填）
//     *
//     *
//     * @param equipmentStatus 设备运行状态
//     */
//    @PostMapping("/EquipmentStatus")
//    public Result<?> addEquipmentStatus(@RequestBody EquipmentStatus equipmentStatus) {
//
//        accessMonitorService.addEquipmentStatus(equipmentStatus);
//        return Result.success();
//    }
//
//
//
//    /**
//     * 新增终端异常预警信息
//     *
//     *          * @param
//     *          *  设备资源号,APPID,终端名称,使用工序,预警标题,预警类型，预警等级，预警内容，,发生时间,备注
//     *
//     *
//     * @param deviceAbn 终端异常预警信息
//     */
//    @PostMapping("/DeviceAbn")
//    public Result<?> addDeviceAbn(@RequestBody DeviceAbn deviceAbn) {
//
//        accessMonitorService.addDeviceAbn(deviceAbn);
//        return Result.success();
//    }


    /**
     * 对外获取终端设备，硬件软件的运行状态（表+++mon_device_history）
     */
    @SneakyThrows
    @PostMapping("/deviceStatus")
    public Result<?> addMonitorDeviceStatus(@RequestBody MonitorDeviceStatus monitorDeviceStatus) {

        //调用修改终端实时表的接口
        int i = accessMonitorService.updateMonitorDeviceStatus(monitorDeviceStatus);
        if (i == 0) {
            return Result.error("1", "终端未注册");
        }
        String accessStatus = monitorDeviceStatus.getAccessStatus();
        String deviceSoftwareStatus =monitorDeviceStatus.getDeviceSoftwareStatus();
        String antennaStatus =monitorDeviceStatus.getAntennaStatus();
        String appId = monitorDeviceStatus.getAppId();
        String warningContent = monitorDeviceStatus.getWarningContent();

        //创建Jackson的核心对象， ObjectMapper
        ObjectMapper mapper = new ObjectMapper();
        //100是运行状态和接入状态都是正常的，异常就传具体的异常值
        if (!accessStatus.equals("101") || !deviceSoftwareStatus.equals("101") || !warningContent.equals("101") || !antennaStatus.equals("101")){
            MonitorDeviceAlarm  monitorDeviceAlarm = new MonitorDeviceAlarm();
            monitorDeviceAlarm.setAppId(appId);
            monitorDeviceAlarm.setWarningContent(warningContent);
            monitorDeviceAlarm.setAccessStatus(accessStatus);
            monitorDeviceAlarm.setDeviceSoftwareStatus(deviceSoftwareStatus);
            monitorDeviceAlarm.setAntennaStatus(antennaStatus);
            accessMonitorService.addDeviceAlarm(monitorDeviceAlarm);

            //将java对象转成json字符串
            String json = mapper.writeValueAsString(monitorDeviceStatus);
            //将所有信息打包发到终端状态
            WebSocket.push("device_status",json);
            WebSocket.push("software_runtime_status",json);
            WebSocket.push("plc",json);
            WebSocket.push("rfid",json);
            WebSocket.push("device_abnormal_warn",json);



            return Result.success("01","异常添加成功");

        }else {

            //将java对象转成json字符串
            String json = mapper.writeValueAsString(monitorDeviceStatus);
            //将所有信息打包发到终端状态
            WebSocket.push("device_status",json);
            WebSocket.push("software_runtime_status",json);
            WebSocket.push("plc",json);
            WebSocket.push("rfid",json);

            return Result.success("0","终端暂无异常");
        }



    }



    @GetMapping("/deviceAndaccess")
    public Result<?> getEqiAndAccess() {
        return Result.success(accessMonitorService.getEqiAndAccess());
    }

    @GetMapping("/processAndeqi")
    public Result<?> queryProcessAndeqi() {
        return Result.success(accessMonitorService.queryProcessAndeqi());
    }

    @GetMapping("/queryProcessAndFactory")
    public Result<?> queryProcessAndFactory() {
        return Result.success(accessMonitorService.queryProcessAndFactory());
    }



}
