package com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.controller;

import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfo;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.service.FactoryService;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 工厂信息维护
 * @author 李伟杰
 * @date 2022/12/19 14:11
 */
@RestController
@ResponseBody
@RequestMapping("/FactoryController")
public class FactoryController {

    /**
     * 工厂信息维护
     */
    @Autowired
    private FactoryService factoryService;

    /**
     * 工厂信息维护
     *
     * @param factoryInfo 工厂信息维护
     */
    @PostMapping("/add")
    public Result<?> addFactoryInfo(@RequestBody FactoryInfo factoryInfo) {
        factoryService.addFactoryInfo(factoryInfo);
        return Result.success();
    }

    /**
     * 根据主键删除工厂数据
     * @param
     * @return
     */
    @DeleteMapping("/delete/{factoryId}")
    public Result<?> deleteFactory(@PathVariable("factoryId") int factoryId) {
        factoryService.deleteFactory(factoryId);
        return Result.success();
    }

}
