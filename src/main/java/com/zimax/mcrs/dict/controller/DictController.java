package com.zimax.mcrs.dict.controller;

import com.zimax.mcrs.config.Result;

import com.zimax.mcrs.dict.pojo.DictEntry;
import com.zimax.mcrs.dict.pojo.DictType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 业务字典配置
 * @author 李伟杰
 * @date 2022/12/1
 */
@RestController
@ResponseBody
@RequestMapping("/dict")
public class DictController {

    /**
     * 查询业务字典类型
     * @param dictTypeId   类型代码
     * @param dictTypeName 类型名称
     * @param limit        记录数
     * @param page         页码
     * @return 业务字典类型列表
     */
    @GetMapping("/queryDictType")
    public Result<?> queryDictType(@RequestParam String dictTypeId, @RequestParam String dictTypeName,
                                   @RequestParam int limit, @RequestParam int page) {
        return Result.success();
    }

    /**
     * 查询业务字典项
     * 根据查询条件查询业务字典项
     * 查询条件：
     * 业务字典类型ID
     * 说明：默认parentid，sortno升序排列
     * @param dictTypeId   类型代码
     * @param dictId       父节点ID
     * @param parentTypeId 父节点类型ID
     * @param limit        记录数
     * @param page         页码
     * @return 业务字典类型列表
     */
    @GetMapping("/queryDictType")
    public Result<?> queryDict(@RequestParam String dictTypeId, @RequestParam String dictId,
                               @RequestParam String parentTypeId, @RequestParam int limit,
                               @RequestParam int page) {
        return Result.success();
    }

    /**
     * 保存业务字典类型
     * 包括：添加字典类型；添加子类型；修改字典类型
     * @param dictType 字典类型编号
     * @return DictType 业务字典类型；状态码
     */
    @RequestMapping("/saveDictType")
    public Result<?> saveDictType(@RequestBody DictType dictType) {
        return Result.success();
    }

    /**
     * 保存业务字典项
     * 包括：添加字典项；添加子项；修改字典项
     * @param dictEntry 字典类型项
     * @return dictEntry 业务字典项；状态码
     */
    @RequestMapping("/saveDict")
    public Result<?> saveDict(@RequestBody DictEntry dictEntry) {
        return Result.success();
    }

    /**
     * 级联删除字典类型
     * @param dictTypeId 字典类型编号
     */
    @DeleteMapping("/removeDictTypeCascade")
    public void removeDictTypeCascade(@RequestParam("dictTypeId") String[] dictTypeId) {

    }

    /**
     * 删除业务字典类型
     * 说明：
     * 1.删除选择的字典类型和其子类型
     * 2.删除所有字典类型和子类型级联的业务字典项
     * @param dictType 业务字典类型
     */
    @DeleteMapping("/removeDictType")
    public Result<?> removeDictType(@RequestBody DictType dictType) {
        return Result.success(dictType);

    }

    /**
     * 刷新业务字典缓存
     * @return状态码
     */
    @PutMapping("refreshDictCache")
    public String refreshDictCache() {
        return Result.success().getCode();
    }

    /**
     * 导入业务字典
     * @return状态码
     */
    @PostMapping("importDict")
    public String importDict(@RequestParam("excelFile") MultipartFile excelFile) {
        return Result.success().getCode();
    }

    /**
     * 导出业务字典
     */
    @GetMapping("exportDict")
    @ResponseBody
    public String exportDict(HttpServletResponse response) throws IOException {
        return Result.success().getCode();

    }
}
