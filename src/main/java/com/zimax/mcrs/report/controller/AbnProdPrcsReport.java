package com.zimax.mcrs.report.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.report.pojo.AbnProdPrcs;
import com.zimax.mcrs.report.pojo.Feeding;
import com.zimax.mcrs.report.service.AbnProdPrcsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 生产过程异常报表
 * @author 李伟杰
 * @date 2022/12/5 11:13
 */
@RestController
@RequestMapping("/report")
public class AbnProdPrcsReport {

    /**
     *生产过程异常服务
     */
    @Autowired
    private AbnProdPrcsService abnProdPrcsService;

    /**
     * 记录生产过程异常报表信息
     * @param abnProdPrcs 生产过程异常
     */
    @PostMapping("/abnProdPrcs/add")
    public Result<?> addAbnProdPrcs(@RequestBody AbnProdPrcs abnProdPrcs) {
        abnProdPrcsService.addAbnProdPrcs(abnProdPrcs);
        return Result.success();
    }
}
