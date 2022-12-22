package com.zimax.mcrs.basic.treeStructure.controller;

import com.zimax.mcrs.basic.treeStructure.service.TreeService;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 树型信息
 * @author 李伟杰
 * @date 2022/12/21 9:25
 */
@RestController
@RequestMapping("/TreeInfo")
public class TreeInfo {


    @Autowired
    private TreeService treeService;
    /**
     *  查询所有树信息
     * @param order       排序方式
     * @param field       排序字段
     * @return 树信息列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/query")
    public Result<?> queryTreeInfo(String order, String field) {
        List TreeInfo = treeService.queryTreeInfo(order, field);
        return Result.success(TreeInfo, treeService.count());
    }
}
