package com.zimax.mcrs.basic.accPointResMaintain.controller;

import com.zimax.components.coframe.rights.pojo.User;
import com.zimax.mcrs.basic.accPointResMaintain.pojo.AccPointRes;
import com.zimax.mcrs.basic.accPointResMaintain.service.AccPointResService;
import com.zimax.mcrs.config.Result;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * @author 李伟杰
 * @date 2022/12/24 16:45
 */
@RestController
@ResponseBody
@RequestMapping("/accPointResController")
public class AccPointResController {

    @Autowired
    private AccPointResService accPointResService;

    /**
     * 添加接入点
     *
     * @param accPointRes 接入点
     */
    @PostMapping("/add")
    public Result<?> addAccPointRes(@RequestBody AccPointRes accPointRes) {
        accPointResService.addAccPointRes(accPointRes);
        return Result.success();
    }

    /**
     * 删除接入点
     *
     * @param accPointResId 依据接入点主键删除
     */
    @DeleteMapping("/deleteAccPointRes/{accPointResId}")
    public Result<?> deleteAccPointRes(@PathVariable("accPointResId") int accPointResId) {

        accPointResService.deleteAccPointRes(accPointResId);
        return Result.success();
    }


    /**
     * 修改接入点
     *
     * @param accPointRes 接入点
     */
    @PostMapping("/update")
    public Result<?> updateAccPointRes(@RequestBody AccPointRes accPointRes) {
        accPointResService.updateAccPointRes(accPointRes);
        return Result.success();
    }

    /**
     * 条件查询（接入点模块显示）
     *
     * @param accPointResCode 接入点代码
     * @param accPointResName 接入点名称
     * @param accCreatorName  制单人
     * @param createTime      制单时间
     * @param limit           记录数
     * @param page            页码
     * @param field           排序字段
     * @param order           排序方式
     * @return 终端列表
     */
    @GetMapping("/query")
    public Result<?> queryAccPointRes(String page, String limit, String accPointResCode, String accPointResName, String isEnable, String matrixCode, String factoryCode, String accCreatorName, String createTime, String accUpdaterName, String updateTime, String matrixName,String order, String field) {
        List AccPointRes = accPointResService.queryAccPointRes(page, limit, accPointResCode, accPointResName, isEnable, matrixCode, factoryCode, accCreatorName, createTime, accUpdaterName, updateTime,matrixName, order, field);
        return Result.success(AccPointRes, accPointResService.countAll(accPointResCode, accPointResName, isEnable, matrixCode, factoryCode, accCreatorName, createTime, accUpdaterName, updateTime,matrixName));
    }


    /**
     * 批量删除接入点信息
     *
     * @param accPointResIds 主键数组
     */
    @DeleteMapping("/batchDelete")
    public Result<?> batchDelete(@RequestBody Integer[] accPointResIds) {
        accPointResService.batchDelete(Arrays.asList(accPointResIds));
        return Result.success();

    }

    @GetMapping("/getCount")
    public Result<?> getCount() {
        return Result.success(accPointResService.count(null, null, null, null));

    }


    /**
     * 批量启用（弃用了）
     *
     * @param accPointRess 接入点编号
     * @param
     */
    @PostMapping("/changeEnable")
    @ResponseBody
    public Result<?> changeEnable(@RequestBody List<AccPointRes> accPointRess) {
        /*调用启用*/
        accPointResService.changeEnable(accPointRess);
        return Result.success();

    }

    /**
     * 批量启用接入点
     *
     * @param accPointResIds 接入点主键
     */
    @PostMapping("/accPointRes/enable")
    public Result<?> enable(@RequestBody List<Integer> accPointResIds) {
        accPointResService.enable(accPointResIds);
        return Result.success();

    }
}
