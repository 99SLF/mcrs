package com.zimax.mcrs.warn.contorller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.warn.pojo.WarningRule;
import com.zimax.mcrs.warn.service.WarningRuleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 预警规则管理
 * @author 林俊杰
 * @date 2022/11/29
 */
@RestController
@ResponseBody
@RequestMapping("/warningRule")
public class WarningRuleController {

    @Autowired
    private WarningRuleService warningRuleService;

    /**
     * 添加预警规则
     * @param warningRule 预警规则
     */
    @RequestMapping("/add")
    public Result<?> addWarningRule(@RequestBody WarningRule warningRule){
        warningRuleService.addWarningRule(warningRule);
        return Result.success();
    }

    /**
     * 更新预警规则
     * @param warningRule 预警规则
     */
    @PutMapping("/update")
    public Result<?> updateWarningRule(@RequestBody WarningRule warningRule) {
        warningRuleService.updateWarningRule(warningRule);
        return Result.success();
    }

    /**
     * 查询预警规则
     * @param waringMessageName 预警信息名称
     * @return 预警信息
     */
    @GetMapping("/find/{waringMessageName}")
    public Result<?> getWarningRule(@PathVariable("waringMessageName") String waringMessageName) {

        return Result.success(warningRuleService.query(waringMessageName));
    }

    /**
     * 删除预警规则
     * @param waringId 预警信息数组
     */
    @DeleteMapping("/delete/{waringId}")
    public Result<?> removeWarningRule(@PathVariable("waringId")int waringId) {
        warningRuleService.deleteById(waringId);
        return  Result.success();
    }

    /**
     * 查询预警信息
     * @param waringMessageName 警告规则名称
     * @param waringRule 警告规则内容
     * @param limit 记录数
     * @param page 页码
     * @return 警告规则列表
     */
    @GetMapping("/query")
    public Result<?> querywaringRule(@RequestParam String waringMessageName,@RequestParam String waringRule, int limit, int page) {
        return Result.success(warningRuleService.queryAll());
    }

    /**
     * 警告推送
     * @return
     */
    @RequestMapping
    public void pushWarning(@PathVariable String topLimit){

    }
}

