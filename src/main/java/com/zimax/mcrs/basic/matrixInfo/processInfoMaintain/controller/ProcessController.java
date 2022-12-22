package com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.controller;
import com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.pojo.ProcessInfo;
import com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.service.ProcessService;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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
     * 根据主键删除工序数据
     * @param
     * @return
     */
    @DeleteMapping("/delete/{processId}")
    public Result<?> deleteProcess(@PathVariable("processId") int processId) {
        processService.deleteProcess(processId);
        return Result.success();
    }
}
