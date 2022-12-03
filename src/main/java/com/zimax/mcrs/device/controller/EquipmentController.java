package com.zimax.mcrs.device.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.Equipment;
import com.zimax.mcrs.device.service.EquipmentService;
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
@RequestMapping("/equipment")
public class EquipmentController {

    @Autowired
    private EquipmentService equipmentService;

    /**
     * 初始化查询
     *
     * @param equipmentId 设备资源号
     * @param equipmentName 设备名称
     * @param limit         记录数
     * @param page          页码
     * @return 角色列表
     */
    @GetMapping("/query")
    public Result<?> queryEquipment(@RequestParam int equipmentId, @RequestParam String equipmentName, @RequestParam int limit, @RequestParam int page) {
        return Result.success();
    }

    /**
     * 查询设备
     *
     * @param equipmentId 设备信息
     * @return 设备信息
     */
    @GetMapping("/find/{equipmentId}")
    public Result<?> getEquipment(@PathVariable("equipmentId") int equipmentId) {

        return Result.success();
    }

    /**
     * 添加设备
     *
     * @param equipment 设备信息
     */
    @RequestMapping("/add")
    public Result<?> addEquipment(@RequestBody Equipment equipment) {
        return Result.success();
    }

    /**
     * 删除设备
     *
     * @param equipmentId 设备数组
     */
    @DeleteMapping("/delete/{equipmentId}")
    public Result<?> removeEquipment(@PathVariable("equipmentId") int equipmentId) {
        return Result.success();
    }

    /**
     * 更新设备
     *
     * @param equipment 设备信息
     */
    @PutMapping("/update")
    public Result<?> updateEquipment(@RequestBody Equipment equipment) {
        return Result.success();
    }


}
