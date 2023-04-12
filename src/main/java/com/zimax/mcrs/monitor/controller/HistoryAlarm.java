package com.zimax.mcrs.monitor.controller;

import com.zimax.mcrs.config.Result;

import com.zimax.mcrs.monitor.service.HistoryAlarmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author 李伟杰
 * @date 2023/4/11 9:14
 */
@RestController
@RequestMapping("/HistoryAlarm")
public class HistoryAlarm {


    @Autowired
    private HistoryAlarmService historyAlarmService;

    /**
     * 分页查询终端异常历史记录(监控模块历史显示)
     *
     * @param page              页记录数
     * @param limit             页码
     * @param equipmentId       设备资源号
     * @param appId             终端名称
     * @param warnGrade         预警等级
     * @param startTime/endTime 时间范围
     * @param order             排序方式
     * @param field             排序字段
     * @return 信息列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/historyAlarm/query")
    public Result<?> queryHistoryAlarm(String page, String limit,
                                       String equipmentId, String appId,
                                       String warnGrade,
                                       String startTime, String endTime,
                                       String order, String field) {
        List historyAlarm = historyAlarmService.queryHistoryAlarm(page, limit, equipmentId, appId, warnGrade, startTime, endTime, order, field);
        return Result.success(historyAlarm, historyAlarmService.count(equipmentId, appId, warnGrade, startTime, endTime));
    }

}
