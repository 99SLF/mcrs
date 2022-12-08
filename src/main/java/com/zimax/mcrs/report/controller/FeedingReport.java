package com.zimax.mcrs.report.controller;


import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.report.pojo.Feeding;
import com.zimax.mcrs.report.service.FeedingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 上料报表
 * @author 李伟杰
 * @date 2022/12/5 10:58
 */
@RestController
@RequestMapping("/report")
public class FeedingReport {

    /**
     *上料报表服务
     */
    @Autowired
    private FeedingService feedingService;

    /**
     * 记录上料报表信息
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
     * @param page     页记录数
     * @param limit    页码
     * @param equipmentId   设备资源号
     * @param axisName 轴名称
     * @param inSFCId 来料SFC编码
     * @param prodSFCId 生产SFC编码
     * @param vehicleCode 载具码
     * @param startProdTime    开始生产时间
     * @param endProdTime 结束生产时间
     * @param order    排序方式
     * @param field    排序字段
     * @return 上料报表信息列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/feeding/query")
    public Result<?> queryFeedings(@RequestParam int page, @RequestParam int limit,
                                  String equipmentId, String axisName,
                                  String inSFCId, String prodSFCId,
                                  String vehicleCode, String startProdTime,
                                  String endProdTime,
                                  String order, String field) {
        List feedings = feedingService.queryFeedings(page,limit,equipmentId,axisName,inSFCId,prodSFCId,vehicleCode,startProdTime,endProdTime,order,field);
        return Result.success(feedings,feedingService.count(equipmentId,axisName,inSFCId,prodSFCId,vehicleCode,startProdTime,endProdTime));
    }
}
