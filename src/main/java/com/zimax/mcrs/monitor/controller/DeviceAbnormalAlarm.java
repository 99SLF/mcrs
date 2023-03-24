package com.zimax.mcrs.monitor.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.Equipment;
import com.zimax.mcrs.monitor.pojo.vo.GroupByDate;
import com.zimax.mcrs.monitor.pojo.vo.GroupByProduction;
import com.zimax.mcrs.monitor.service.AccessMonitorService;
import com.zimax.mcrs.monitor.service.DeviceAbnormalAlarmService;
import com.zimax.mcrs.warn.pojo.AlarmEvent;
import com.zimax.mcrs.warn.pojo.AlarmEventVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
     * 分页查询终端异常预警信息(监控内容显示)
     *
     * @param page         页记录数
     * @param limit        页码
     * @param equipmentId  设备资源号
     * @param equipmentName   设备名称
     * @param deviceName   终端名称
     * @param processName   使用工序
     * @param warnType  预警类型
     * @param warnGrade 预警等级
     * @param alarmEventContent 预警内容
     * @param occurrenceTime    发生时间
     * @param order        排序方式
     * @param field        排序字段
     * @return 信息列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/query")
    public Result<?> queryDeviceAbnormalAlarm(String page, String limit,
                                              String equipmentId,  String equipmentName, String deviceName,
                                              String processName,String warnType,
                                              String warnGrade,String occurrenceTime,
                                              String order, String field) {
        List DeviceAbnormalAlarms = deviceAbnormalAlarmService.queryDeviceAbnormalAlarm(page, limit, equipmentId, equipmentName,deviceName, processName, warnType, warnGrade, occurrenceTime, order, field);
        return Result.success(DeviceAbnormalAlarms, deviceAbnormalAlarmService.countAA(equipmentId, equipmentName,deviceName, processName, warnType, warnGrade, occurrenceTime));
    }


    @GetMapping("/getWarnByproduction")
    public Result<?> getWarnByproduction() {
        return Result.success(accessMonitorService.getWarnByproduction());
    }

    @GetMapping("/groupQueryBydate")
    public Result<?> groupQueryBydate() {
        List<GroupByDate> dateList = accessMonitorService.groupQueryBydate();
        return Result.success(dateList);
    }

    @GetMapping("/getWarnInfo")
    public Result<?> getWarnInfo() {
        return Result.success(accessMonitorService.getWarnInfo());
    }


    /**
     * @param
     * @return
     *通过预警事件编码查出预警标题，预警类型，预警等级，预警内容---warningContent
     * */
    @GetMapping("/findAlarmEvent")
    public Result<?> findAlarmEvent(String warningContent){

        Map<String,Object> maps = new HashMap<>();
        List<AlarmEventVo> alarmEvent = accessMonitorService.findAlarmEvent(warningContent);
        maps.put("data",alarmEvent);
        return Result.success(alarmEvent);

    }
}
