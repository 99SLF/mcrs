package com.zimax.mcrs.report.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.report.pojo.CoilDiameterRecord;
import com.zimax.mcrs.report.pojo.Feeding;
import com.zimax.mcrs.report.service.CoilDiameterRecordService;
import com.zimax.mcrs.report.service.FeedingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Author 施林丰
 * @Date:2023/3/4 13:29
 * @Description
 */
@RestController
@RequestMapping("/report")
public class CoilDiameterRecordController {
    /**
     * 上下料卷径数据记录表服务
     */
    @Autowired
    private CoilDiameterRecordService coilDiameterRecordService;

    /**
     * 记录上下料卷径报表信息
     *
     * @param coilDiameterRecord 报表信息
     */
    @PostMapping("/CoilDiameterRecord/add")
    public Result<?> addCoilDiameterRecord(@RequestBody CoilDiameterRecord coilDiameterRecord) {
        coilDiameterRecordService.addCoilDiameterRecord(coilDiameterRecord);
        return Result.success();
    }
}
