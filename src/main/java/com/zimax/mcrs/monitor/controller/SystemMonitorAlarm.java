package com.zimax.mcrs.monitor.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.monitor.service.AccessMonitorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 查询系统监测预警
 * @author 李伟杰
 * @date 2022/12/3
 */
@RestController
@RequestMapping("/SystemMonitorAlarm")
public class SystemMonitorAlarm {

    @Autowired
    private AccessMonitorService accessMonitorService;

    /**
     * 分页查询系统监测预警
     *
     * @param page        页记录数
     * @param limit       页码
     * @param warningTitle 预警标题
     * @param warningType       预警类型
     * @param warningLevel   预警等级
     * @param occurTime      发生时间
     * @param order       排序方式
     * @param field       排序字段
     * @return 信息列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/query")
    public Result<?> querySystemMonitorAlarm(String page, String limit,
                                     String warningTitle, String warningType,
                                     String warningLevel, String occurTime,
                                     String order, String field) {
        List SystemMonitorAlarm = accessMonitorService.querySystemMonitorAlarm(page, limit, warningTitle, warningType, warningLevel, occurTime,order, field);
        return Result.success(SystemMonitorAlarm, accessMonitorService.countSys(warningTitle, warningType, warningLevel, occurTime));
    }
}
