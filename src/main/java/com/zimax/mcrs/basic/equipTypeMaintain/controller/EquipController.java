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
 * @author 李伟杰
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
     * 分页查询所有设备信息
     *
     * @param page          页记录数
     * @param limit         页码
     * @param equipTypeCode 代码
     * @param equipTypeName 名称
     * @param creator       制单人
     * @param createTime    制单时间
     * @param field         排序字段
     * @param order         排序方式
     * @return 数据列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/query")
    public Result<?> queryEquipInfos(String page, String limit, String equipTypeCode, String equipTypeName, String creator, String createTime, String order, String field) {
        List EquipInfos = equipService.queryEquipInfos(page, limit, equipTypeCode, equipTypeName, creator, createTime, order, field);
        return Result.success(EquipInfos, equipService.count(equipTypeCode, equipTypeName, creator, createTime));
    }


    /**
     * 更新用户
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
}
