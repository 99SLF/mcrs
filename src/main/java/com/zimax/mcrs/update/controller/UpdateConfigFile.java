package com.zimax.mcrs.update.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.Device;
import com.zimax.mcrs.device.pojo.DeviceRollback;
import com.zimax.mcrs.device.pojo.DeviceUpgrade;
import com.zimax.mcrs.update.pojo.*;
import com.zimax.mcrs.update.service.UpdateConfigService;
import com.zimax.mcrs.update.service.UpdatePackageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.InetAddress;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 *@author 王广玉
 *@date 2023/1/3 0:38
 */

@RestController
@RequestMapping("/updateConfig")
public class UpdateConfigFile {

    @Autowired
    private UpdateConfigService updateConfigService;

    @GetMapping("/query")
    public Result<?> queryConfigurationFile(String page, String limit, String appId, String order, String field) {
        return Result.success(updateConfigService.queryConfigurationFile(page, limit, appId, order, field),updateConfigService.count(appId));
    }

    @PostMapping("/add")
    public Result<?> addConfigurationFile(@RequestBody ConfigurationFile configurationFile) {
        try {
            updateConfigService.addConfigurationFile(configurationFile);
        }catch (Exception e){
            return Result.error("0","请求失败");
        }
        return Result.success("200","请求成功");
    }


    /**
     * s删除编码规则
     */
    @DeleteMapping("/del")
    public Result<?> delConfigurationFile(@RequestBody ConfigurationFile configurationFile){
        try{
            updateConfigService.delConfigurationFile(configurationFile);
        } catch (Exception e){
            return Result.error("0","请求失败");
        }
        return Result.success("200","请求成功");
    }
}
