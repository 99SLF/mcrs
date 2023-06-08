package com.zimax.mcrs.basic.equipTypeMaintain.controller;


import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfo;
import com.zimax.mcrs.basic.equipTypeMaintain.service.EquipService;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * 设备信息维护
 *
 * @author 李伟杰,施林丰
 * @date 2022/12/19 14:18
 */
@RestController
@ResponseBody
@RequestMapping("/EquipController")
public class EquipController {

    /**
     * 设备信息维护
     */
    @Autowired
    private EquipService equipService;


    /**
     * 设备信息维护
     *
     * @param equipTypeInfo 设备信息
     */
    @PostMapping("/add")
    public Result<?> addEquipInfo(@RequestBody EquipTypeInfo equipTypeInfo) {

        equipService.addEquipInfo(equipTypeInfo);
        return Result.success();
    }


    /**
     * 分页查询所有设备信息(设备类型管理的主页面)
     *
     * @param page          页记录数
     * @param limit         页码
     * @param field         排序字段
     * @param order         排序方式
     * @return 数据列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/query")
    public Result<?> queryEquipInfos(String page, String limit,
                                     String equipTypeCode,
                                     String equipTypeName,
                                     String equipTypeEnable,
                                     String manufacturer,
                                     String equipControllerModel,
                                     String protocolCommunication,
                                     String mesIpAddress,
                                     String equipCreatorName,
                                     String createTime,
                                     String equipUpdaterName,
                                     String updateTime, String order, String field) {
        List EquipInfos = equipService.queryEquipInfos(page, limit, equipTypeCode,equipTypeName, equipTypeEnable, manufacturer, equipControllerModel, protocolCommunication, mesIpAddress, equipCreatorName, createTime, equipUpdaterName, updateTime, order, field);
        return Result.success(EquipInfos, equipService.count(equipTypeCode,equipTypeName, equipTypeEnable, manufacturer, equipControllerModel, protocolCommunication, mesIpAddress, equipCreatorName, createTime, equipUpdaterName, updateTime));
    }


    /**
     * 更新设备类型信息
     *
     * @param equipTypeInfo 设备信息维护信息
     * @return
     */
    @PostMapping("/update")
    public Result<?> updateEquipInfo(@RequestBody EquipTypeInfo equipTypeInfo) {
        equipService.updateEquipInfo(equipTypeInfo);
        return Result.success();
    }

    /**
     * 批量删除用户信息
     *
     * @param equipTypeIds 设备信息数据编码
     */
    @DeleteMapping("/batchDelete")
    public Result<?> deleteEquipInfos(@RequestBody Integer[] equipTypeIds) {
        equipService.deleteEquipInfos(Arrays.asList(equipTypeIds));
        return Result.success();

    }


    /**
     * 批量启用接入点
     *
     * @param equipTypeIds 接入点主键
     */
    @PostMapping("/enable")
    public Result<?> enable(@RequestBody List<Integer> equipTypeIds) {
        equipService.enable(equipTypeIds);
        return Result.success();

    }

    /**
     * 查询设备类型名称作为设备管理的高级查询的下拉选项
     */
    @GetMapping("/gaoJiEquipTypeName")
    public Result<?> gaoJiEquipTypeName() {
        List typeName = equipService.gaoJiEquipTypeName();
        return Result.success(typeName);
    }

}
