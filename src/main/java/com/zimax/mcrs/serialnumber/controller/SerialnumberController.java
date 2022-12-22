package com.zimax.mcrs.serialnumber.controller;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.serialnumber.pojo.Serialnumber;
import com.zimax.mcrs.serialnumber.service.SerialnumberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author 施林丰
 * @Date:2022/12/19 15:32
 * @Description
 */
@RestController
@ResponseBody
@RequestMapping("/serialnumber")
public class SerialnumberController {
    @Autowired
    SerialnumberService serialnumberService;
    /**
     * 新增编码规则
     * @param serialnumber 编码规则
     */
    @PostMapping("/add")
    public Result<?> addSerialnumber(@RequestBody Serialnumber serialnumber){
        int flag = serialnumberService.addSerialnumber(serialnumber);
        if(flag==1){
            return Result.error("1","功能编号重复");
        }else{
            return Result.success();
        }
    }

    @PutMapping("/update")
    public Result<?> updateSerialnumber(@RequestBody Serialnumber serialnumber){
        serialnumberService.updateSerialnumber(serialnumber);
        return Result.success();
    }

    /**
     * s删除编码规则
     * @param Ids 编码规则主键
     */
    @DeleteMapping("/del")
    public Result<?> batchDeleteSerialnumber(@RequestBody List<Integer> Ids){
        serialnumberService.batchDeleteSerialnumber(Ids);
        return Result.success();
    }

    @GetMapping("/query")
    public Result<?> querySerialnumbers(String page, String limit, String functionName, String order, String field){
        return Result.success(serialnumberService.querySerialnumbers(page, limit, functionName,null, order, field),serialnumberService.count(functionName,null));
    }
}
