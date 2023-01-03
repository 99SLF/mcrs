package com.zimax.mcrs.monitor.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.monitor.pojo.vo.GroupByDate;
import com.zimax.mcrs.monitor.pojo.vo.GroupByProduction;
import com.zimax.mcrs.monitor.service.AccessMonitorService;
import com.zimax.mcrs.monitor.service.DeviceAbnormalAlarmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 终端异常预警信息
 *
 * @author 李伟杰
 * @date 2022/12/3 0:22
 */
@RestController
@RequestMapping("/DeviceAbnormalAlarm")
public class DeviceAbnormalAlarm {

    @Autowired
    private DeviceAbnormalAlarmService deviceAbnormalAlarmService;

    @Autowired
    private AccessMonitorService accessMonitorService;

    /**
     * 分页查询终端异常预警信息
     *
     * @param page         页记录数
     * @param limit        页码
     * @param equipmentId  设备资源号
     * @param deviceName 终端名称
     * @param useProcess  使用工序
     * @param warningType 预警类型
     * @param warningLevel 预警等级
     * @param occurTime    发生时间
     * @param order        排序方式
     * @param field        排序字段
     * @return 信息列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/query")
    public Result<?> queryDeviceAbnormalAlarm(String page, String limit,
                                              String equipmentId, String deviceName,
                                              String useProcess, String warningType,
                                              String warningLevel,
                                              String occurTime,
                                              String order, String field) {
        List DeviceAbnormalAlarms = deviceAbnormalAlarmService.queryDeviceAbnormalAlarm(page, limit, equipmentId, deviceName, useProcess, warningType, warningLevel, occurTime, order, field);
        return Result.success(DeviceAbnormalAlarms, deviceAbnormalAlarmService.countAA(equipmentId, deviceName, useProcess, warningType,warningLevel, occurTime));
    }








    @GetMapping("/groupQueryByproduction")
    public Result<?> groupQueryByproduction() {
        List<GroupByProduction>groupByProductionList = accessMonitorService.groupQueryByproduction();
        return Result.success(groupByProductionList);
    }
    @GetMapping("/groupQueryBydate")
    public Result<?> groupQueryBydate() {
        List<GroupByDate>dateList = accessMonitorService.groupQueryBydate();
        return Result.success(dateList);
    }
}
