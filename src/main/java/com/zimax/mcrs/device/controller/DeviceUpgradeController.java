package com.zimax.mcrs.device.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.service.DeviceUpgradeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

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
public class DeviceUpgradeController {

    @Autowired
    private DeviceUpgradeService deviceUpgradeService;

    /**
     * 条件查询
     *
     * @param upgradeVersion  升级版本号
     * @param equipmentId 设备资源号
     * @param limit       记录数
     * @param page        页码
     * @param field       排序字段
     * @param order       排序方式
     * @return 终端列表
     */
    @GetMapping("/deviceUpgrade/query")
    public Result<?> queryDeviceUpgrade(String page, String limit, String equipmentId, String upgradeVersion, String versionUpdater, String versionUpdateTime,String order, String field) {
        List deviceUpgrade = deviceUpgradeService.queryDeviceUpgrades(page, limit, equipmentId, upgradeVersion,versionUpdater,versionUpdateTime, order, field);
        return Result.success(deviceUpgrade, deviceUpgradeService.count(equipmentId, upgradeVersion));
    }
}
