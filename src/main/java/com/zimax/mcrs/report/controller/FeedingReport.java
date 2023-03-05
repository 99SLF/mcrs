package com.zimax.mcrs.report.controller;


import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.report.pojo.Feeding;
import com.zimax.mcrs.report.service.FeedingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

/**
 * 上料报表
 *
 * @author 李伟杰
 * @date 2022/12/5 10:58
 */
@RestController
@RequestMapping("/report")
public class FeedingReport {

    /**
     * 上料报表服务
     */
    @Autowired
    private FeedingService feedingService;

    /**
     * 记录上料报表信息
     *
     * @param feeding 上料报表信息
     */
    @PostMapping("/feeding/add")
    public Result<?> addFeeding(@RequestBody Feeding feeding) {
        feedingService.addFeeding(feeding);
        return Result.success();
    }


    /**
     * 分页查询所有用户
     *
     * @param page          页记录数
     * @param limit         页码
     * @param resource   设备资源号
     * @param axis      轴名称
     * @param sfcPre        来料SFC编码
     * @param processLotPre    载具码
     * @param startTime 开始时间
     * @param endTime   结束时间
     * @param order         排序方式
     * @param field         排序字段
     * @return 上料报表信息列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/feeding/query")
    public Result<?> queryFeedings(String page, String limit,
                                   String resource, String axis,
                                   String sfcPre, String processLotPre,
                                   String startTime,
                                   String endTime,
                                   String order, String field) {
        List feedings = feedingService.queryFeedings(page, limit, resource, axis, sfcPre, processLotPre, startTime, endTime, order, field);
        return Result.success(feedings, feedingService.count(resource, axis, sfcPre, processLotPre, startTime, endTime));
    }
}
