package com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.controller;

import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfo;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfoVo;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfo;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfoVo;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.service.FactoryService;
import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.Matrix;
import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.MatrixVo;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 工厂信息维护
 * @author 李伟杰
 * @date 2022/12/19 14:11
 */
@RestController
@ResponseBody
@RequestMapping("/FactoryController")
public class FactoryController {

    /**
     * 工厂信息维护
     */
    @Autowired
    private FactoryService factoryService;

    /**
     * 工厂信息维护
     *
     * @param factoryInfo 工厂信息维护
     */
    @PostMapping("/add")
    public Result<?> addFactoryInfo(@RequestBody FactoryInfo factoryInfo) {
        factoryService.addFactoryInfo(factoryInfo);
        return Result.success();
    }

    /**
     * 更新
     *
     * @param factoryInfo 工厂信息维护
     * @return
     */
    @PostMapping("/update")
    public Result<?> updateFactoryInfo(@RequestBody FactoryInfo factoryInfo) {
        factoryService.updateFactoryInfo(factoryInfo);
        return Result.success();
    }

    /**
     * 分页查询所有工厂信息(树表，废弃)
     *
     * @param page          页记录数
     * @param limit         页码
     * @param infoId        树id
     * @param field         排序字段
     * @param order         排序方式
     * @return 数据列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/query")
    public Result<?> queryFactoryInfos(String page, String limit, String infoId, String order, String field) {
        List FactoryInfos = factoryService.queryFactoryInfos(page, limit, infoId, order, field);
        return Result.success(FactoryInfos, factoryService.count(infoId));
    }

    /**
     * 分页查询所有工厂信息（无树表）
     *
     * @param page          页记录数
     * @param limit         页码
     * @param nodeId        树节点真实id
     * @param field         排序字段
     * @param order         排序方式
     * @return 数据列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/queryNode")
    public Result<?> queryFactoryInfosNode(String page, String limit, String nodeId, String order, String field) {
        List FactoryInfos = factoryService.queryFactoryInfosNode(page, limit, nodeId, order, field);
        return Result.success(FactoryInfos, factoryService.countNode(nodeId));
    }

    /**
     *查询所有工厂信息（树）
     *
     * @return 数据列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/queryFactoryInfosTree")
    public Result<?> queryFactoryInfosTree() {
        List FactoryInfos = factoryService.queryFactoryInfosTree();
        return Result.success(FactoryInfos);
    }

    /**
     * （接入点编辑）
     * 初始化下拉框，获取全部的工厂代码
     * @param
     * @return
     */
    @GetMapping("/selectFactoryCodeInit")
    public Result<?> selectListInit(String matrixCode){
        Map<String,Object> maps = new HashMap<>();
        List<FactoryInfoVo> factoryList = factoryService.selectListInit(matrixCode);//查询出数据
        maps.put("data",factoryList);
        return Result.success(factoryList, factoryService.countFactory(matrixCode));
    }

    /**
     * (接入点新增)
     * 通过父节点id查询工厂信息(工厂代号),父节点id等于基地节点id
     * 用户选择框下拉值
     * @param
     * @return
     */
    @GetMapping("/selectFactoryCode")
    public Result<?> selectList(String matrixId){
        Map<String,Object> maps = new HashMap<>();
        List<FactoryInfo> List = factoryService.selectList(matrixId);//查询出数据
        maps.put("data",List);
        return Result.success(List);
    }

    /**
     * （接入点新增）
     * 通过工厂代码查询出相应的工厂信息（名称）
     * @param
     * @return
     */
    @GetMapping("/getFactoryName")
    public Result<?> getFactoryName(String factoryCode){
        List getFactory = factoryService.getFactoryName(factoryCode);
        return Result.success(getFactory);

    }

//    /**
//     * 根据主键删除工厂数据
//     * @param
//     * @return
//     */
//    @DeleteMapping("/delete/{factoryId}")
//    public Result<?> deleteFactory(@PathVariable("factoryId") int factoryId) {
//        factoryService.deleteFactory(factoryId);
//        return Result.success();
//    }

    /**
     * （目录树）
     * 通过真实id删除一条工厂信息
     * @param
     * @return
     */
    @PostMapping("/removeFactory")
    public Result<?> removeFactory(Integer realId) {
        int count =factoryService.countFactoryProcess(realId) ;
        if ( count==0){
            factoryService.removeFactory(realId);
            return Result.success();
        }else {
            return Result.error("1", "该工厂下有工序，无法删除");
        }
    }

    /**
     * （基础数据目录树）
     * 查询出当前树节点的详细工厂信息
     * @param
     * @return
     */
    @GetMapping("/exactQuery")
    public Result<?> queryFactoryNode(Integer nodeId){
        Map<String,Object> maps = new HashMap<>();
        List<FactoryInfo> factoryInfo = factoryService.queryFactoryNode(nodeId);
        maps.put("data",factoryInfo);
        return Result.success(factoryInfo);
    }

}
