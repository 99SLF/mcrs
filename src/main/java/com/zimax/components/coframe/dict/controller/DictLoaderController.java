package com.zimax.components.coframe.dict.controller;

import com.zimax.mcrs.config.Result;
import org.springframework.web.bind.annotation.*;

/**
 * 获取字典数据
 * @author 李伟杰
 * @date 2022/12/1
 */
@RestController
@ResponseBody
@RequestMapping("/dictLoader")
public class DictLoaderController {

    /**
     * 获取字典数据
     * @param dictTypeId 字典类型编号
     * @return 字典数据
     */
    @GetMapping("/find/{dictTypeId}")
    public Result<?> getDict(@PathVariable("dictTypeId") String dictTypeId) {
        return Result.success();
    }


}