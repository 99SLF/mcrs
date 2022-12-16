package com.zimax.mcrs.update.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.update.mapper.UpdatePackageMapper;
import com.zimax.mcrs.update.service.UpdatePackageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @author 李伟杰
 * @date 2022/12/13 20:03
 */

@RestController
@RequestMapping("/update")
public class UpdatePackage {

    @Autowired
    private UpdatePackageService  updatePackageService;

    /**
     * 接受APPId
     * 是否升级，是否强制升级，版本号
     * @
     */
    @PostMapping("/checkResult")
    public Result<?> checkResult(@RequestBody String APPId) {

        /*返回(异常)状态码，code，msg；返回信息内容给终端：isUpdate（是否升级） ,isForceUpdate（是否强制升级）, version（要升级的版本号）*/
        return Result.success();
        /*service：
        *终端传过来的APPId值和未升级条件（固定条件）查升级记录表，查到一条数据，给终端返回，要升级，没数据条数，不需要升级
        *通过升级记录表，组件id查询更新包数据，查找更新包更新策略
        *
        * 更新表数据，升级状态升级中
        * */
    }


    /**
     *
     * 终端用appid调用提供提供的更新包下载接口
     * 返回zip文件下载路径，更新资源包版本号
     *
     */
    @GetMapping("/loaderInterface")
    public Result<?> loaderInterface(@RequestBody String APPId){
        return Result.success();

    }


    /**
     * 接受终端升级状态返回的接口
     * 终端传appid，升级状态码
     *@param par 字符串 {APPId ,isCode}
     */
    @PostMapping("/loaderResult")
    public Result<?> loaderResult(@RequestBody String par) {
        return Result.success();
    }
    /**
     *
     * 更新包数据，已升级
     */


}
