package com.zimax.mcrs.report.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.report.pojo.Blanking;
import com.zimax.mcrs.report.pojo.Feeding;
import com.zimax.mcrs.report.service.BlankingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 下料报表
 * @author 李伟杰
 * @date 2022/12/5 10:59
 */
@RestController
@RequestMapping("/report")
public class BlankingReport {

    /**
     *下料报表服务
     */
    @Autowired
    private BlankingService blankingService;

    /**
     * 记录下料报表信息
     * @param blanking 下料报表信息
     */
    @PostMapping("/blanking/add")
    public Result<?> addBlanking(@RequestBody Blanking blanking) {
        blankingService.addBlanking(blanking);
        return Result.success();
    }
}
