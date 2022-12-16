package com.zimax.mcrs.update.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.update.pojo.UpdateUpload;
import com.zimax.mcrs.update.service.UpdateUploadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author 李伟杰
 * @date 2022/12/16 10:44
 */
@RestController
@RequestMapping("/upload")
public class UpdateUploadController {

    /**
     * 更新包上传服务
     *
     * @param
     * @return
     */
    @Autowired
    private UpdateUploadService updateUploadService;

    /**
     * 记录更新包上传记录
     *
     * @param updateUpload 更新包信息
     */
    @PostMapping("/addUpdateUpload/add")
    public Result<?> addUpdateUpload(@RequestBody UpdateUpload updateUpload) {
        updateUploadService.addUpdateUpload(updateUpload);
        return Result.success();
    }

//
//    /**
//     * 显示更新包信息
//     *
//     * @param
//     * @param page        页记录数
//     * @param limit       页码
//     * @param version      版本号
//     * @param deviceSoType 终端软件类型
//     * @param order       排序方式
//     * @param field       排序字段
//     * @return
//     * @return 更新包信息列表
//     * @return total 总记录数
//     * @return code 状态码
//     * @return msg 返回信息
//     */
//    @GetMapping("/abnProdPrcs/query")
//    public Result<?> queryUpdateUpload(String page, String limit,
//                                        String version, String deviceSoType,
//                                        String order, String field) {
//        List UpdateUpload = updateUploadService.queryUpdateUpload(page, limit, version, deviceSoType, order, field);
//        return Result.success(UpdateUpload, updateUploadService.count(version, deviceSoType));
//    }

}
