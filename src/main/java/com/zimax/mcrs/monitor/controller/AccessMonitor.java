package com.zimax.mcrs.monitor.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.monitor.pojo.AccessStatus;
import com.zimax.mcrs.monitor.service.AccessMonitorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 对外监测类型
 * @author 李伟杰
 * @date 2022/12/12 0:22
 */
@RestController
@RequestMapping("/AccessMonitor")
public class AccessMonitor {

    @Autowired
    private AccessMonitorService  accessMonitorService;
    /**
     * 记录接入状态信息
     *
     * @param accessStatus 接入状态
     */
    @PostMapping("/add")
    public Result<?> addAccessMonitor(@RequestBody AccessStatus accessStatus) {

        /**
         * @param 设备资源号,APPID,接入类型,接入状态,天线状态（非必填）,终端软件类型,终端软件运行状态
         * @return
         */
        accessMonitorService.addAccessMonitor(accessStatus);
        return Result.success();
    }

    /**
     * 分页查询软件运行状态
     *
     * @param page        页记录数
     * @param limit       页码
     * @param equipmentId 设备资源号
     * @param APPId       APPId
     * @param deviceSoType   终端软件类型
     * @param deviceSoRuntime      终端软件运行状态
     * @param order       排序方式
     * @param field       排序字段
     * @return 上料报表信息列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/querySoRuntimes")
    public Result<?> querySoRuntimes(String page, String limit,
                                        String equipmentId, String APPId,
                                        String deviceSoType, String deviceSoRuntime,
                                        String order,String field) {
        List SoRuntimes = accessMonitorService.querySoRuntimes(page, limit, equipmentId, APPId, deviceSoType, deviceSoRuntime,order, field);
        return Result.success(SoRuntimes, accessMonitorService.countSO(equipmentId, APPId, deviceSoType, deviceSoRuntime));
    }

    /**
     * 分页查询设备接入状态
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
    @GetMapping("/queryEquipmentAccess")
    public Result<?> queryEquipmentAccess(String page, String limit,
                                        String equipmentId, String accessStatus,
                                        String antennaStatus,
                                        String order,String field) {
        List EquipmentAccess = accessMonitorService.queryEquipmentAccess(page, limit, equipmentId, accessStatus,antennaStatus, order, field);
        return Result.success(EquipmentAccess, accessMonitorService.countEQ(equipmentId, accessStatus,antennaStatus));
    }
}
