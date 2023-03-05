package com.zimax.mcrs.report.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.report.pojo.CoilDiameterRecord;
import com.zimax.mcrs.report.pojo.VerifyUnusual;
import com.zimax.mcrs.report.service.CoilDiameterRecordService;
import com.zimax.mcrs.report.service.VerifyUnusualService;
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
public class VerifyUnusualController {
    /**
     * 防串度数据记录表服务
     */
    @Autowired
    private VerifyUnusualService verifyUnusualService;

    /**
     * 记录防串度报表信息
     *
     * @param verifyUnusual 报表信息
     */
    @PostMapping("/VerifyUnusual/add")
    public Result<?> addVerifyUnusual(@RequestBody VerifyUnusual verifyUnusual) {
        verifyUnusualService.addVerifyUnusual(verifyUnusual);
        return Result.success();
    }
}
