package com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.controller;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfo;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfoVo;
import com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.pojo.ProcessInfo;
import com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.service.ProcessService;
import com.zimax.mcrs.config.ChangeString;
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
     * 分页查询所有设备信息
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
}
