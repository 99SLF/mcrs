package com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.controller;

import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfo;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfoVo;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfo;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.service.FactoryService;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
     * 更新
     *
     * @param factoryInfo 工厂信息维护
     * @return
     */
    @PostMapping("/update")
    public Result<?> updateFactoryInfo(@RequestBody FactoryInfo factoryInfo) {
        factoryService.updateFactoryInfo(factoryInfo);
        return Result.success();
    }

    /**
     * 分页查询所有设备信息
     *
     * @param page          页记录数
     * @param limit         页码
     * @param infoId        树id
     * @param field         排序字段
     * @param order         排序方式
     * @return 数据列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/query")
    public Result<?> queryFactoryInfos(String page, String limit, String infoId, String order, String field) {
        List FactoryInfos = factoryService.queryFactoryInfos(page, limit, infoId, order, field);
        return Result.success(FactoryInfos, factoryService.count(infoId));
    }

//    /**
//     * 根据主键删除工厂数据
//     * @param
//     * @return
//     */
//    @DeleteMapping("/delete/{factoryId}")
//    public Result<?> deleteFactory(@PathVariable("factoryId") int factoryId) {
//        factoryService.deleteFactory(factoryId);
//        return Result.success();
//    }

}
