package com.zimax.mcrs.basic.accPointResMaintain.equipTypeMaintain.controller;

import com.zimax.mcrs.basic.accPointResMaintain.equipTypeMaintain.pojo.EquipTypeInfo;
import com.zimax.mcrs.basic.accPointResMaintain.equipTypeMaintain.service.EquipService;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 设备信息维护
 * @author 李伟杰
 * @date 2022/12/19 14:18
 */
@RestController
@ResponseBody
@RequestMapping("/EquipController")
public class EquipController {

    /**
     * 设备信息维护
     */
    @Autowired
    private EquipService equipService;

    /**
     * 设备信息维护
     *
     * @param equipTypeInfo 设备信息
     */
    @PostMapping("/add")
    public Result<?> addEquipInfo(@RequestBody EquipTypeInfo equipTypeInfo) {
        equipService.addEquipInfo(equipTypeInfo);
        return Result.success();
    }
}
