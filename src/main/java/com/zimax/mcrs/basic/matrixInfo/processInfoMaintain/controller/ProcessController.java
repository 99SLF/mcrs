package com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.controller;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfo;
import com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.pojo.ProcessInfo;
import com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.pojo.ProcessInfoVo;
import com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.service.ProcessService;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/19 14:17
 */
@RestController
@ResponseBody
@RequestMapping("/ProcessController")
public class ProcessController {
    /**
     * 工序信息维护
     */
    @Autowired
    private ProcessService processService;

    /**
     * 工序信息维护
     *
     * @param processInfo 工序信息
     */
    @PostMapping("/add")
    public Result<?> addProcessInfo(@RequestBody ProcessInfo processInfo) {
        processService.addProcessInfo(processInfo);
        return Result.success();
    }

    /**
     * 更新
     *
     * @param processInfo 工序信息维护信息
     * @return
     */
    @PostMapping("/update")
    public Result<?> updateProcessInfo(@RequestBody ProcessInfo processInfo) {
        processService.updateProcessInfo(processInfo);
        return Result.success();
    }
//    /**
//     * 根据主键删除工序数据
//     * @param
//     * @return
//     */
//    @DeleteMapping("/delete/{processId}")
//    public Result<?> deleteProcess(@PathVariable("processId") int processId) {
//        processService.deleteProcess(processId);
//        return Result.success();
//    }

    /**
     * （接入点编辑）
     * 初始化下拉框，获取全部获取工序代码
     * @param
     * @return
     */
    @GetMapping("/selectProcessCodeInit")
    public Result<?> selectListInit(String factoryCode){
        Map<String,Object> maps = new HashMap<>();
        List<ProcessInfoVo> processList = processService.selectListInit(factoryCode);//查询出数据
        maps.put("data",processList);
        return Result.success(processList, processService.countProcess(factoryCode));
    }


    /**
     * 分页查询所有工序信息(树表，废弃)
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
    public Result<?> queryProcessInfo(String page, String limit, String infoId, String order, String field) {
        List ProcessInfos = processService.queryProcessInfo(page, limit, infoId, order, field);
        return Result.success(ProcessInfos, processService.count(infoId));
    }

    /**
     * 分页查询所有工序信息（无树表）
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
    public Result<?> queryProcessInfoNode(String page, String limit, String nodeId, String order, String field) {
        List ProcessInfos = processService.queryProcessInfoNode(page, limit, nodeId, order, field);
        return Result.success(ProcessInfos, processService.countNode(nodeId));
    }

    /**
     * 查询所有工序信息
     *
     * @return 数据列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/queryProcessInfoTree")
    public Result<?> queryProcessInfoTree() {
        List ProcessInfos = processService.queryProcessInfoTree();
        return Result.success(ProcessInfos);
    }


    /**
     * 接入点新增
     * 通过工厂代码获取工序新增
     * 下拉选择框
     * @param factoryId
     * @return
     */
    @GetMapping("/selectProcessCode")
    public Result<?> selectList(String factoryId){
        Map<String,Object> maps = new HashMap<>();
        List<ProcessInfo> processList = processService.selectList(factoryId);//查询出数据
        maps.put("data",processList);
        return Result.success(processList);
    }

    /**
     * 接入点新增
     * 通过工序代码查询出相应的工序信息（名称和描述）
     *名称和描述
     * @param
     * @return
     */
    @GetMapping("/getProcessNameDe")
    public Result<?> getProcessNameDe(String processCode){
        List Process = processService.getProcessNameDe(processCode);
        return Result.success(Process);

    }


    /**
     * 通过真实id删除一条工序信息
     * @param
     * @return
     */

    @PostMapping("/removeProcess")
    public Result<?> removeProcess(Integer realId) {
       int count = processService.countProcessAccess(realId);
        if (count==0) {
            processService.removeProcess(realId);
            return Result.success();
        }else {
            return Result.error("1", "该工序被接入点使用，无法删除");
        }

    }

    /**
     * （基础数据目录树）
     * 查询出当前树节点的详细工序信息
     * @param
     * @return
     */
    @GetMapping("/exactQuery")
    public Result<?> queryProcessNode(Integer nodeId){
        Map<String,Object> maps = new HashMap<>();
        List<ProcessInfo> processInfo = processService.queryProcessNode(nodeId);
        maps.put("data",processInfo);
        return Result.success(processInfo);
    }

    /**
     * （基础数据目录树）
     * 检测相同父节点下的工序名称是否存在
     *
     * @param parentId 上级节点的id
     */
    @GetMapping("/check/isExist")
    public Result<?> checkProcessName(@RequestParam("parentId") String parentId,@RequestParam("processName") String processName,@RequestParam("flag") String flag) {
        if(flag.equals("1")){
            if (processService.checkProcessNameAdd(parentId,processName) > 0) {
                return Result.error("1", "节点下该工序已存在");
            } else {
                return Result.success();
            }
        }else {

            ProcessInfo processInfo =  processService.getProcess(Integer.parseInt(parentId));
            String factoryId = String.valueOf(processInfo.getFactoryId());

            if (processService.checkProcessNameEdit (parentId,processName,factoryId) > 0) {
                return Result.error("1", "节点下该工序已存在");
            } else {
                return Result.success();
            }
        }
    }
}

