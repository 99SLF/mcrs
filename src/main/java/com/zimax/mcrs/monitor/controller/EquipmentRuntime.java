package com.zimax.mcrs.monitor.controller;

import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfo;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfo;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.Equipment;
import com.zimax.mcrs.monitor.service.AccessMonitorService;
import com.zimax.mcrs.monitor.service.EquipmentRuntimeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 设备接入状态
 * @author 李伟杰
 * @date 2022/12/3
 */
@RestController
@RequestMapping("/EquipmentRuntime")
public class EquipmentRuntime {

    @Autowired
    private EquipmentRuntimeService equipmentRuntimeService;
    /**
     * 分页查询plc设备接入状态
     *
     * @param page        页记录数
     * @param limit       页码
     * @param equipmentId 设备资源号
     * @param accessStatus       接入状态
     * @param order       排序方式
     * @param field       排序字段
     * @return 信息列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/PLC/queryEquipmentAccessP")
    public Result<?> queryEquipmentAccessP(String page, String limit,
                                          String equipmentId, String accessStatus,
                                          String order, String field) {
        List EquipmentAccess = equipmentRuntimeService.queryEquipmentAccessP(page, limit, equipmentId, accessStatus,order, field);
        return Result.success(EquipmentAccess, equipmentRuntimeService.countEQP(equipmentId, accessStatus));
    }

    /**
     * @param
     * @return
     *通过appId查询出设备资源号(plc和rfid通用)
     * */
    @GetMapping("/findEquipmentId")
    public Result<?> findEquipmentId(String appId){

        Map<String,Object> maps = new HashMap<>();
        List<Equipment> Equipment = equipmentRuntimeService.findEquipmentId(appId);
        maps.put("data",Equipment);
        return Result.success(Equipment);

    }
    /**
     * 分页查询RFID设备接入状态
     *
     * @param page        页记录数
     * @param limit       页码
     * @param equipmentId 设备资源号
     * @param accessStatus       接入状态
     * @param accessStatus       天线状态
     * @param order       排序方式
     * @param field       排序字段
     * @return 上料报表信息列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/RFID/queryEquipmentAccessR")
    public Result<?> queryEquipmentAccessR(String page, String limit,
                                          String equipmentId, String accessStatus,
                                          String antennaStatus,
                                          String order, String field) {
        List EquipmentAccess = equipmentRuntimeService.queryEquipmentAccessR(page, limit, equipmentId, accessStatus,antennaStatus, order, field);
        return Result.success(EquipmentAccess, equipmentRuntimeService.countEQR(equipmentId, accessStatus,antennaStatus));
    }
}
