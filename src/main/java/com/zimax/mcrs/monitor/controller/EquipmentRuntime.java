package com.zimax.mcrs.monitor.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.monitor.service.AccessMonitorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 设备接入状态
 * @author 李伟杰
 * @date 2022/12/3
 */
@RestController
@RequestMapping("/EquipmentRuntime")
public class EquipmentRuntime {

    @Autowired
    private AccessMonitorService accessMonitorService;
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
        List EquipmentAccess = accessMonitorService.queryEquipmentAccessP(page, limit, equipmentId, accessStatus,order, field);
        return Result.success(EquipmentAccess, accessMonitorService.countEQP(equipmentId, accessStatus));
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
        List EquipmentAccess = accessMonitorService.queryEquipmentAccessR(page, limit, equipmentId, accessStatus,antennaStatus, order, field);
        return Result.success(EquipmentAccess, accessMonitorService.countEQR(equipmentId, accessStatus,antennaStatus));
    }
}
