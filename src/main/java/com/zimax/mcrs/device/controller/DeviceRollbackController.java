package com.zimax.mcrs.device.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.service.DeviceRollbackService;
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
public class DeviceRollbackController {

    @Autowired
    private DeviceRollbackService deviceRollbackService;

    /**
     * 条件查询
     *
     * @param version      版本号
     * @param equipmentId 设备资源号
     * @param versionRollbackPeople 版本更改人
     * @param versionRollbackTime 版本更改时间
     * @param limit       记录数
     * @param page        页码
     * @param field       排序字段
     * @param order       排序方式
     * @return 终端列表
     */
    @GetMapping("/deviceRollback/query")
    public Result<?> queryDeviceUpgrade(String page, String limit, String equipmentId, String version, String versionRollbackPeople, String versionRollbackTime,String order, String field) {
        List deviceRollback = deviceRollbackService.queryDeviceRollback(page, limit, equipmentId, version,versionRollbackPeople,versionRollbackTime, order, field);
        return Result.success(deviceRollback, deviceRollbackService.count(equipmentId, version));
    }
}
