package com.zimax.mcrs.monitor.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.monitor.pojo.vo.GroupByDate;
import com.zimax.mcrs.monitor.pojo.vo.GroupByProduction;
import com.zimax.mcrs.monitor.service.AccessMonitorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 终端告警信息
 *
 * @author 李伟杰
 * @date 2022/12/3 0:22
 */
@RestController
@RequestMapping("/DeviceAbnormalAlarm")
public class DeviceAbnormalAlarm {

    @Autowired
    private AccessMonitorService accessMonitorService;

    /**
     * 分页查询终端告警信息状态
     *
     * @param page         页记录数
     * @param limit        页码
     * @param equipmentId  设备资源号
     * @param warningTitle 告警标题
     * @param warningType  告警类型
     * @param warningLevel 告警等级
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
                                              String equipmentId, String warningTitle,
                                              String warningType, String warningLevel,
                                              String occurTime,
                                              String order, String field) {
        List DeviceAbnormalAlarms = accessMonitorService.queryDeviceAbnormalAlarm(page, limit, equipmentId, warningTitle, warningType, warningLevel, occurTime, order, field);
        return Result.success(DeviceAbnormalAlarms, accessMonitorService.countAA(equipmentId, warningTitle, warningType, warningLevel,occurTime));
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
