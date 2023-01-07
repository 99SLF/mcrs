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

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.InetAddress;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.util.Date;
import java.util.HashMap;
import java.util.zip.ZipInputStream;

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


        UpgradeData upgradeData = new UpgradeData();

        //2.1、数据不存在，返回不升级
        if (deviceUpgradeVo == null) {
            //2.1.1、根据APPID查询回退关联表（关联3，设备，资源，回退）
            DeviceRollbackVo deviceRollbackVo = updatePackageService.getRollbackVoDevice(APPId);
            //2.1.2.1、数据不存在，返回不升级
            if (deviceRollbackVo == null) {
                upgradeData.setStatusCode("101");
                upgradeData.setIsUpdate("100");
                return Result.success(upgradeData,"0", "数据不存在，无法升级");
            } else {
                //2.1.2.2、存在，但状态为升级，返回已经是最新版本
                String upgradeStatus = deviceRollbackVo.getUpgradeStatus();
                if (upgradeStatus.equals("102") || upgradeStatus.equals("101") ) {
                    upgradeData.setStatusCode("102");
                    upgradeData.setIsUpdate("100");
                    return Result.success(upgradeData,"0", "已经是最新版本，无法升级");
                } else {    //2.1.2.3、存在，但状态为未升级
                    //2.1.3、查询更新策略
                    //2.1.3.1、更新策略为手动更新，返回 是否升级、版本号、更新策略
                    String version = deviceRollbackVo.getVersion();
                    if (deviceRollbackVo.getUploadStrategy().equals("002")) {
                        upgradeData.setStatusCode("103");
                        upgradeData.setVersionID(version);
                        upgradeData.setIsUpdate("101");
                        upgradeData.setIsForcedUpdate("100");
                        return Result.success(upgradeData,"200", "是否回滚");
                    } else {//2.1.3.2、更新策略为强制更新，返回 是否升级、版本号、更新策略
                        upgradeData.setStatusCode("103");
                        upgradeData.setVersionID(version);
                        upgradeData.setIsUpdate("101");
                        upgradeData.setIsForcedUpdate("101");
                        return Result.success(upgradeData,"200", "是否回滚");
                    }
                }
            }
        } else {
            //2.2、存在，但状态为升级，返回已经是最新版本
            String upgradeStatus = deviceUpgradeVo.getUpgradeStatus();
            if (upgradeStatus.equals("102") || upgradeStatus.equals("101")) {
                upgradeData.setStatusCode("102");
                upgradeData.setIsUpdate("100");
                return Result.success(upgradeData,"0", "已经是最新版本，无法升级");
            } else {    //2.3、存在，但状态为未升级
                //3、查询更新策略
                //3.1、更新策略为手动更新，返回 是否升级、版本号、更新策略
                String version = deviceUpgradeVo.getVersion();
                if (deviceUpgradeVo.getUploadStrategy().equals("002")) {
                    upgradeData.setStatusCode("104");
                    upgradeData.setVersionID(version);
                    upgradeData.setIsUpdate("101");
                    upgradeData.setIsForcedUpdate("101");
                    return Result.success(upgradeData,"200", "是否升级");
                } else {//3.2、更新策略为强制更新，返回 是否升级、版本号、更新策略
                    upgradeData.setStatusCode("104");
                    upgradeData.setVersionID(version);
                    upgradeData.setIsUpdate("101");
                    upgradeData.setIsForcedUpdate("101");
                    return Result.success(upgradeData,"200", "是否升级");
                }
            }
        }

    }

    /**
     * 终端用appid调用提供提供的更新包下载接口
     * 返回zip文件下载路径，更新资源包版本号
     */
    @GetMapping("/loaderInterface")
    public void  loaderInterface(String APPId, HttpServletRequest request, HttpServletResponse response) {
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
//                return Result.error("0", "");
               // return null;
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
           // return Result.error("0", "更新包查询出错");
           // return null;
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
        //文件
        String filePath = updateUpload.getDownloadUrl();
        String fileName = updateUpload.getFileName();

        byte[] data = null;

        FileInputStream fileIn = null;
        ServletOutputStream out = null;
        try {
            //String fileName = new String(fileNameString.getBytes("ISO8859-1"), "UTF-8");
            response.setContentType("application/octet-stream");
            // URLEncoder.encode(fileNameString, "UTF-8") 下载文件名为中文的，文件名需要经过url编码
            response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8"));
            File file;
            String filePathString = filePath;
            file = new File(filePathString);
            fileIn = new FileInputStream(file);
            out = response.getOutputStream();

            byte[] outputByte = new byte[1024];
            int readTmp = 0;
            while ((readTmp = fileIn.read(outputByte)) != -1) {
                out.write(outputByte, 0, readTmp); //并不是每次都能读到1024个字节，所有用readTmp作为每次读取数据的长度，否则会出现文件损坏的错误
            }
            data = outputByte;
        }
        catch (Exception e) {
            //log.error(e.getMessage());
            e.printStackTrace();
        }
        finally {
            try {
                fileIn.close();
                out.flush();
                out.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

    }


    /**
     * 接受终端升级状态返回的接口
     * @param APPId
     * @param isCode 100 升级不成功， 102成功
     * @return
     */
    @PostMapping("/loaderResult")
    public Result<?> loaderResult(String APPId,String isCode) {
        UpgradeData upgradeData = new UpgradeData();
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
            upgradeData.setStatusCode("105");
            return Result.success(upgradeData,"0", "升级失败");
        } else {
            upgradeData.setStatusCode("106");
            return Result.success(upgradeData,"200", "该终端已完成升级");
        }

    }

    /**
     * 获取ip地址
     */
    public static String getIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        // 本机访问
        if ("localhost".equalsIgnoreCase(ip) || "127.0.0.1".equalsIgnoreCase(ip) || "0:0:0:0:0:0:0:1".equalsIgnoreCase(ip)){
            // 根据网卡取本机配置的IP
            InetAddress inet;
            try {
                inet = InetAddress.getLocalHost();
                ip = inet.getHostAddress();
            } catch (UnknownHostException e) {
                e.printStackTrace();
            }
        }
        // 对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割
        if (null != ip && ip.length() > 15) {
            if (ip.indexOf(",") > 15) {
                ip = ip.substring(0, ip.indexOf(","));
            }
        }
        return ip;
    }


    /**
     *终端注册
     * @return 注册成功返回APPID
     */
    @PostMapping("/register")
    public Result<?> register(HttpServletRequest request) {
        String equipmentIp = "";
        equipmentIp = getIpAddress(request);
        String equipmentContinuePort = "";

        String appId = null;
        //1.通过IP、端口查询设备资源 （关联2 设备、资源）
        DeviceEquipmentVo deviceEquipmentVo= updatePackageService.getDeviceEquipmentVo(equipmentIp,equipmentContinuePort);
        //2.1不存在资源，返回录入信息
        if (deviceEquipmentVo == null || equipmentIp == "") {
            return Result.error("0", "不存在设备资源");
        } else {//2.2存在资源
            appId = deviceEquipmentVo.getAppId();


            String registerStatus = deviceEquipmentVo.getRegisterStatus();
            int deviceId = deviceEquipmentVo.getDeviceId();

            if(registerStatus.equals("101")) {
                //3.1注册存在，但终端已注册，返回终端已经注册，不能重复注册,返回已注册APPID
                return Result.success(appId,"0", "终端已经注册，不能重复注册");
            } else {
                //3.2注册存在，终端未注册，进行终端注册（修改注册表），返回APPID （1，注册表）
                Device device = new Device();
                device.setDeviceId(deviceId);
                device.setRegisterStatus("101");
                updatePackageService.updateDeviceStatus(device);
                return Result.success(appId,"200", "终端注册成功");
            }
        }
    }



}
