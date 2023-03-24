package com.zimax.mcrs.basic.warn.controller;

import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfo;
import com.zimax.mcrs.basic.warn.pojo.WarnManager;
import com.zimax.mcrs.basic.warn.service.WarnService;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author 施林丰
 * @Date:2023/3/20 17:19
 * @Description
 */
@RestController
@ResponseBody
@RequestMapping("/warnManage")
public class WarnController {
    @Autowired
    private WarnService warnService;
    /**
     * 新增预警等级
     */
    @PostMapping("/addWarn")
    public Result<?> addWarn(@RequestBody WarnManager warnManager) {
        warnService.addWarn(warnManager);
        return Result.success();
    }

    /**
     * 修改预警等级
     */
    @PostMapping("/updateWarn")
    public Result<?> updateWarn(@RequestBody WarnManager warnManager) {
        warnService.updateWarnToUser(warnManager);
        return Result.success();
    }

    /**
     * 分页查询所有预警等级
     */
    @GetMapping("/queryWarn")
    public Result<?> queryWarn(String page, String limit, String warnGrade, String order, String field) {
        List warnManagers = warnService.queryWarn(page, limit, warnGrade, order, field);
        return Result.success(warnManagers, warnService.count(warnGrade));
    }

    /**
     * 检测预警等级是否存在
     */
    @GetMapping("/isExist")
    public Result<?> isExist(String warnGrade) {
        return Result.success(warnService.isExist(warnGrade));
    }
}
