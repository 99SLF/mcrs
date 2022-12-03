package com.zimax.mcrs.warn.contorller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.warn.service.WarningMessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 预警信息管理
 * @author 林俊杰
 * @date 2022/11/29
 */
@RestController
@ResponseBody
@RequestMapping("/warningMessage")
public class WarningMessageController {

    @Autowired
    private WarningMessageService warningMessageService;

    /**
     * 查询警告信息
     * @param warningMessageId 警告信息Id
     * @return 警告信息
     */
    @GetMapping("/find/{warningMessageId}")
    public String getWarningMessage(@PathVariable("warningMessageId") int warningMessageId) {
        return "我是查询警告信息";
    }

    /**
     * 查询所有警告
     * @param deviceId 设备编号
     * @param waringMessage 警告信息
     * @param limit 记录数
     * @param page 页码
     * @return 警告列表
     */
    @GetMapping("/queryAll")
        public Result<?> WarningMessage(@RequestParam int deviceId, @RequestParam String waringMessage, int limit, int page) {
        return Result.success(warningMessageService.queryAll());
    }

}
