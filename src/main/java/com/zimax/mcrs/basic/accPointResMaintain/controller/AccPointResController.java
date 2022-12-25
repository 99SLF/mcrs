package com.zimax.mcrs.basic.accPointResMaintain.controller;

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
     * 条件查询
     *
     * @param accPointResCode 接入点代码
     * @param accPointResName 接入点名称
     * @param creator         制单人
     * @param createTime      制单时间
     * @param limit           记录数
     * @param page            页码
     * @param field           排序字段
     * @param order           排序方式
     * @return 终端列表
     */
    @GetMapping("/query")
    public Result<?> queryAccPointRes(String page, String limit, String accPointResCode, String accPointResName, String creator, String createTime, String order, String field) {
        List AccPointRes = accPointResService.queryAccPointRes(page, limit, accPointResCode, accPointResName, creator, createTime, order, field);
        return Result.success(AccPointRes, accPointResService.count(accPointResCode, accPointResName, creator, createTime));
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


}
