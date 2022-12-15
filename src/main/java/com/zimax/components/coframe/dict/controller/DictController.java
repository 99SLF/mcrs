package com.zimax.components.coframe.dict.controller;

import com.zimax.components.coframe.dict.service.DictService;
import com.zimax.components.coframe.framework.pojo.FuncGroup;
import com.zimax.mcrs.config.Result;

import com.zimax.components.coframe.dict.pojo.DictEntry;
import com.zimax.components.coframe.dict.pojo.DictType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * 业务字典配置
 *
 * @author 李伟杰
 * @date 2022/12/1
 */
@RestController
@ResponseBody
@RequestMapping("/dict")
public class DictController {

    /**
     * 字典服务
     */
    @Autowired
    private DictService dictService;

    /**
     * 添加业务字典类型
     * 包括：添加字典类型；添加子类型
     *
     * @param dictType 字典类型编号
     * @return DictType 业务字典类型；状态码
     */
    @PostMapping("/saveDictType")
    public Result<?> saveDictType(@RequestBody DictType dictType) {
        int i=dictService.saveDictType(dictType);
        if(i==0){
            return Result.success();
        }else{
            return Result.error("1","已存在");
        }
    }

    /**
     * 添加业务字典项
     * 包括：添加字典项；添加子项
     *
     * @param dictEntry 字典类型项
     * @return dictEntry 业务字典项；状态码
     */
    @RequestMapping("/saveDict")
    public Result<?> saveDict(@RequestBody DictEntry dictEntry) {
        int i = dictService.saveDict(dictEntry);
        if(i==0){
            return Result.success();
        }else{
            return Result.error("1","已存在");
        }
    }

    /**
     * 查询业务字典类型，刷新
     *
     * @param dictTypeId   父节点ID
     * @param name 类型名称
     * @param id 类型代码
     * @param limit        记录数
     * @param page         页码
     * @param order 排序
     * @return 业务字典类型列表
     */


    @GetMapping("/queryDictType")
    public Result<?> queryDictTypes(String page, String limit, String dictTypeId, String name, String id, String order, String field) {
        List DictTypes = dictService.queryDictTypes(page, limit, dictTypeId, name, id, order, field);
        if(dictTypeId!=null){
            return Result.success(DictTypes);
        }else{
            return Result.success(DictTypes, dictService.countType(id, name));
        }
    }
    @PostMapping("/refreshDictCache")
    public Result<?> refreshDictCache(){
        return Result.success();
    }
    /**
     * 查询业务字典项
     * 根据查询条件查询业务字典项
     * 查询条件：
     * 业务字典类型ID
     * 说明：默认parentid，sortno升序排列
     *
     * @param dictTypeId 类型代码
     * @param dictId     父节点ID
     * @param parentTypeId   父节点类型ID
     * @param limit      记录数
     * @param page       页码
     * @return 业务字典类型列表
     */
    @GetMapping("/queryDict")
    public Result<?> queryDict(String page, String limit, String dictTypeId, String dictId, String parentTypeId, String order, String field) {
        List Dicts = dictService.queryDicts(page, limit, dictTypeId, dictId, parentTypeId, order, field);
        if(dictId!=null){
            return Result.success(Dicts);
        }else{
            return Result.success(Dicts, dictService.count(dictTypeId, null,null));
        }

    }

    /**
     * 更新(修改)字典类型
     *
     * @param dictType 字典类型
     */
    @PostMapping("/updateDictType")
    public Result<?> updateDictType(@RequestBody DictType dictType) {
        dictService.updateDictType(dictType);
        return Result.success();
    }

    /**
     * 更新(修改)字典项数据
     *
     * @param dictEntry 字典类型
     */
    @PostMapping("/updateDict")
    public Result<?> updateDict(@RequestBody DictEntry dictEntry) {
        dictService.updateDict(dictEntry);
        return Result.success();
    }


    /**
     * 删除字典类型
     *
     * @param dictTypeId 字典类型编号
     */
    @DeleteMapping("/deleteDictType{dictTypeId}")
    public Result<?> removeDictType(@PathVariable String dictTypeId) {
        dictService.removeDictType(dictTypeId);
        return Result.success();
    }

    /**
     * 删除字典项
     *
     * @param dictId 字典项代码
     */
    @DeleteMapping("/deleteDict{dictId}")
    public Result<?> removeDict(@PathVariable String dictId) {
        dictService.removeDict(dictId);
        return Result.success();
    }

    /**
     * 批量删除字典类型
     *
     * @param dictTypeIds 字典类型编号数组
     */
    @DeleteMapping("/batchDeleteDictType")
    public Result<?> deleteDictTypes(@RequestBody String[] dictTypeIds) {
        dictService.deleteDictTypes(Arrays.asList(dictTypeIds));
        return Result.success();
    }

    /**
     * 批量删除字典项
     *
     * @param dictIds 字典项数组
     */
    @DeleteMapping("/batchDeleteDict")
    public Result<?> deleteDicts(@RequestBody String[] dictIds) {
        dictService.deleteDicts(Arrays.asList(dictIds));
        return Result.success();
    }

    /**
     * 获取字典类型信息
     *
     * @param dictTypeId 字典类型编号
     * @return 字典类型信息
     */
    @GetMapping("/findDictType/{dictTypeId}")
    public Result<?> getDictType(@PathVariable("dictTypeId") String dictTypeId) {
        return Result.success(dictService.getDictType(dictTypeId));
    }

    /**
     * 获取字典项信息
     *
     * @param dictId 字典类型编号
     * @return 字典类型信息
     */
    @GetMapping("/findDict/{dictId}")
    public Result<?> getDict(@PathVariable("dictId") String dictId) {
        return Result.success(dictService.getDict(dictId));
    }

    /**
     * 导入业务字典
     *
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


//    /**
//     * 删除业务字典类型
//     * 说明：
//     * 1.删除选择的字典类型和其子类型
//     * 2.删除所有字典类型和子类型级联的业务字典项
//     * @param dictType 业务字典类型
//     */
//    @DeleteMapping("/removeDictType")
//    public Result<?> removeDictType(@RequestBody DictType dictType) {
//        return Result.success(dictType);
//
//    }

//    /**
//     * 刷新业务字典缓存
//     * @return状态码
//     */
//    @PutMapping("refreshDictCache")
//    public String refreshDictCache() {
//        return Result.success().getCode();
//    }


}
