package com.zimax.mcrs.device.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.Equipment;
import com.zimax.mcrs.device.service.EquipmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 设备管理
 *
 * @author 林俊杰
 * @date 2022/11/28
 */
@RestController
@RequestMapping("/equipment")
public class EquipmentController {

    @Autowired
    private EquipmentService equipmentService;

    /**
     * 查询
     *
     * @param equipmentId   设备资源号
     * @param equipmentName 设备名称
     * @param equipmentProperties 设备名称
     * @param limit         记录数
     * @param page          页码
     * @param field         排序字段
     * @param order         排序方式
     * @return 设备列表
     */
    @GetMapping("/equipment/query")
    public Result<?> query( String limit,  String page, String equipmentId, String equipmentName, String equipmentProperties,String order, String field) {
        List equipments = equipmentService.queryEquipments(limit, page, equipmentId, equipmentName,equipmentProperties ,order, field);
        return Result.success(equipments, equipmentService.count(equipmentId, equipmentName,equipmentProperties));
    }

    /**
     * 添加设备
     *
     * @param equipment 设备信息
     */
    @PostMapping("/equipment/add")
    public Result<?> addEquipment(@RequestBody Equipment equipment) {
        equipmentService.addEquipment(equipment);
        return Result.success();
    }

    /**
     * 删除设备
     *
     * @param equipmentInt 设备主键
     */
    @DeleteMapping("/equipment/delete/{equipmentInt}")
    public Result<?> removeEquipment(@PathVariable("equipmentInt") int equipmentInt) {
        equipmentService.removeEquipment(equipmentInt);
        return Result.success();
    }

    /**
     * 更新设备
     *
     * @param equipment 设备信息
     */
    @PostMapping("/equipment/update")
    public Result<?> updateEquipment(@RequestBody Equipment equipment) {
        System.out.println("============================");
        System.out.println(equipment);
        equipmentService.updateEquipment(equipment);
        return Result.success();
    }

    /**
     * 提供终端信息
     *
     */
    @GetMapping("/equipment/provide")
    public Result<?> provideDevice(){
        return Result.success();
    }


}
