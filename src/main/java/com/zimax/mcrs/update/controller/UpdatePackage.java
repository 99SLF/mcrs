package com.zimax.mcrs.update.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.components.coframe.rights.pojo.User;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.Device;
import com.zimax.mcrs.device.pojo.DeviceRollback;
import com.zimax.mcrs.device.pojo.DeviceUpgrade;
import com.zimax.mcrs.update.pojo.*;
import com.zimax.mcrs.update.service.UpdatePackageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

/**
 *@author 李伟杰
 *@date 2023/1/3 0:38
 */

@RestController
@RequestMapping("/update")
public class UpdatePackage {

    @Autowired
    private UpdatePackageService updatePackageService;

    /**
     * 注入信息
     * 1、（关联3 设备、升级、更新） 1
     * 2、（关联3 设备、回退、更新） 1
     *    （关联3 设备、资源）
     * 3、（关联1 更新）   UpdateUpload
     * 4、（关联1 升级）   DeviceUpgrade
     * 5、（关联1 回退）   DeviceRollback.java
     * 6、（关联1 注册）
     */

    /**
     * 返回信息：
     *  更新包：
     */



    /**
     * 接受APPId
     * 是否升级回退，是否强制升级，版本号
     */
    @PostMapping("/checkResult")
    public Result<?> checkResult(String APPId) {

        //1、根据APPID查询升级关联表（关联3 设备、升级、更新）
        DeviceUpgradeVo deviceUpgradeVo = updatePackageService.getUpgradeVoDevice(APPId);

        //2.1、数据不存在，返回不升级
        if (deviceUpgradeVo == null) {
            //2.1.1、根据APPID查询回退关联表（关联3，设备，资源，回退）
            DeviceRollbackVo deviceRollbackVo = updatePackageService.getRollbackVoDevice(APPId);

            //2.1.2.1、数据不存在，返回不升级
            if (deviceRollbackVo == null) {
                return Result.error("0", "");
            } else {
                //2.1.2.2、存在，但状态为升级，返回已经是最新版本
                String upgradeStatus = deviceRollbackVo.getUpgradeStatus();
                if (upgradeStatus.equals("102") || upgradeStatus.equals("101") ) {
                    return Result.error("0", "");
                } else {    //2.1.2.3、存在，但状态为未升级
                    //2.1.3、查询更新策略
                    //2.1.3.1、更新策略为手动更新，返回 是否升级、版本号、更新策略
                    String version = deviceRollbackVo.getVersion();
                    if (deviceRollbackVo.getUploadStrategy().equals("002")) {
                        return Result.success("200", "是否升级" + "；" + "即将升级的版本号为" + version + "；" + "是否强制升级");
                    } else {//2.1.3.2、更新策略为强制更新，返回 是否升级、版本号、更新策略
                        return Result.success("200", "是否升级" + "；" + "即将升级的版本号为" + version + "；" + "是否强制升级");
                    }
                }
            }
        } else {
            //2.2、存在，但状态为升级，返回已经是最新版本
            String upgradeStatus = deviceUpgradeVo.getUpgradeStatus();
            if (upgradeStatus.equals("102") || upgradeStatus.equals("101")) {
                return Result.error("0", "");
            } else {    //2.3、存在，但状态为未升级
                //3、查询更新策略
                //3.1、更新策略为手动更新，返回 是否升级、版本号、更新策略
                String version = deviceUpgradeVo.getVersion();
                if (deviceUpgradeVo.getUploadStrategy().equals("002")) {
                    return Result.success("200", "是否升级" + "；" + "即将升级的版本号为" + version + "；" + "是否强制升级");
                } else {//3.2、更新策略为强制更新，返回 是否升级、版本号、更新策略
                    return Result.success("200", "是否升级" + "；" + "即将升级的版本号为" + version + "；" + "是否强制升级");
                }
            }
        }

    }

    /**
     * 终端用appid调用提供提供的更新包下载接口
     * 返回zip文件下载路径，更新资源包版本号
     */
    @GetMapping("/loaderInterface")
    public Result<?> loaderInterface(@PathVariable("APPId") String APPId) {
        //1、通过APPID查询更新表（关联3）
        DeviceUpgradeVo deviceUpgradeVo = updatePackageService.getUpgradeVoDevice(APPId);

        //更新包主键
        int uploadId = 0;
        //升级表主键
        int deviceUpgradeId = 0;
        //回退表主键
        int deviceRollbackId = 0;

        //2.1、数据不存在，查询回退表
        if (deviceUpgradeVo == null) {
            DeviceRollbackVo deviceRollbackVo = updatePackageService.getRollbackVoDevice(APPId);

            //2.1.1数据不存在则返回APPID信息有误
            if (deviceRollbackVo == null){
                return Result.error("0", "");
            }

            //2.1.2、数据存在，获取更新包主键
            uploadId = deviceRollbackVo.getUploadId();
            deviceRollbackId = deviceRollbackVo.getDeviceRollbackId();
        } else {
            //2.2、数据存在，获取更新包主键
            uploadId = deviceUpgradeVo.getUploadId();
            deviceUpgradeId = deviceUpgradeVo.getDeviceUpgradeId();
        }


        //2.3、通过更新包主键获取文件数据
        UpdateUpload updateUpload = updatePackageService.getUpload(uploadId);
        if (updateUpload == null) {
            //更新包查询出错
            return Result.error("0", "");
        }

        //3、修改升级表、回退表状态（升级中）（1个）
        if (deviceUpgradeId != 0) {
            DeviceUpgrade deviceUpgrade = new DeviceUpgrade();
            deviceUpgrade.setDeviceUpgradeId(deviceUpgradeId);
            deviceUpgrade.setUpgradeStatus("101");
            //更新
            updatePackageService.updateDeviceUpdate(deviceUpgrade);
        }
        if (deviceRollbackId != 0) {
            DeviceRollback deviceRollback = new DeviceRollback();
            deviceRollback.setDeviceRollbackId(deviceRollbackId);
            deviceRollback.setUpgradeStatus("101");

            //更新
            updatePackageService.updateDeviceRollback(deviceRollback);

        }


        //4、文件发送，解压，运行
        updateUpload.getFileName();

        //5、返回信息
        return Result.success("200", "正在升级");

    }


    /**
     * 接受终端升级状态返回的接口
     * @param APPId
     * @param isCode 100 升级不成功， 102成功
     * @return
     */
    @PostMapping("/loaderResult")
    public Result<?> loaderResult(@RequestBody String APPId,@RequestBody String isCode) {
        //1、通过APPID查询更新表（关联3）
        DeviceUpgradeVo deviceUpgradeVo = updatePackageService.getUpgradeVoDevice(APPId);

        //更新包主键
        int uploadId = 0;
        //升级表主键
        int deviceUpgradeId = 0;
        //回退表主键
        int deviceRollbackId = 0;


        //2.1、数据不存在，查询回退表
        if (deviceUpgradeVo == null) {
            DeviceRollbackVo deviceRollbackVo = updatePackageService.getRollbackVoDevice(APPId);

            //2.1.1数据不存在则返回APPID信息有误
            if (deviceRollbackVo == null){
                return Result.error("0", "");
            }

            //2.1.2、数据存在，获取更新包主键
            uploadId = deviceRollbackVo.getUploadId();
            deviceRollbackId = deviceRollbackVo.getDeviceRollbackId();
        } else {
            //2.2、数据存在，获取更新包主键
            uploadId = deviceUpgradeVo.getUploadId();
            deviceUpgradeId = deviceUpgradeVo.getDeviceUpgradeId();
        }


        //3.1、升级不成功，修改升级表状态（升级中-->升级失败-->未升级）（1升级）
        //3.2、升级成功，修改升级表状态（升级中-->升级成功-->已升级）
        if (deviceUpgradeId != 0) {
            DeviceUpgrade deviceUpgrade = new DeviceUpgrade();
            deviceUpgrade.setDeviceUpgradeId(deviceUpgradeId);
            deviceUpgrade.setUpgradeStatus(isCode);
            //更新
            updatePackageService.updateDeviceUpdate(deviceUpgrade);
        }
        if (deviceRollbackId != 0) {
            DeviceRollback deviceRollback = new DeviceRollback();
            deviceRollback.setDeviceRollbackId(deviceRollbackId);
            deviceRollback.setUpgradeStatus(isCode);
            //更新
            updatePackageService.updateDeviceRollback(deviceRollback);
        }

        //4、返回终端信息
        if (isCode.equals("100")) {
            return Result.error("0", "升级失败");
        } else {
            return Result.success("200", "该终端已完成升级");
        }

    }

    /**
     *终端注册
     * @param ip 终端IP
     * @param port 终端端口
     * @return 注册成功返回APPID
     */
    public Result<?> register(String ip, String port) {
        String appId = null;

        //1.通过IP、端口查询设备资源 （关联2 设备、资源）
        DeviceEquipmentVo deviceEquipmentVo= updatePackageService.getDeviceEquipmentVo(ip,port);
        //2.1不存在资源，返回录入信息
        if (deviceEquipmentVo == null) {
            return Result.error("0", "");
        } else {//2.2存在资源
            appId = deviceEquipmentVo.getAppId();


            String registerStatus = deviceEquipmentVo.getRegisterStatus();
            int deviceId = deviceEquipmentVo.getDeviceId();

            if(registerStatus.equals("101")) {
                //3.1注册存在，但终端已注册，返回终端已经注册，不能重复注册,返回已注册APPID
                return Result.success(appId,"0", "");
            } else {
                //3.2注册存在，终端未注册，进行终端注册（修改注册表），返回APPID （1，注册表）
                Device device = new Device();
                device.setDeviceId(deviceId);
                device.setRegisterStatus("101");
                updatePackageService.updateDevice(device);
                return Result.success(appId,"200", "");
            }
        }
    }



}
