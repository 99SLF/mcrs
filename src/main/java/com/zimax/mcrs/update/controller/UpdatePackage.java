package com.zimax.mcrs.update.controller;

import com.alibaba.excel.util.StringUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.components.coframe.rights.pojo.User;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.Device;
import com.zimax.mcrs.device.pojo.DeviceRollback;
import com.zimax.mcrs.device.pojo.DeviceUpgrade;
import com.zimax.mcrs.update.pojo.*;
import com.zimax.mcrs.update.service.UpdatePackageService;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.InetAddress;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
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

    public Result<?> checkRollback(String APPId) {

        if (APPId == null || APPId == "") {
            return Result.success("1", "数据不存在，无法升级");
        }

        DeviceRollbackVo deviceRollbackVo = updatePackageService.getRollbackVoDevice(APPId);
        UpgradeData upgradeData = new UpgradeData();
        //2.1.2.1、数据不存在，返回不升级
        if (deviceRollbackVo == null) {
            upgradeData.setUpdatetype("1");
            upgradeData.setIfUpdate(false);
            return Result.success(upgradeData,"1", "数据不存在，无法升级");
        } else {
            //2.1.2.2、存在，但状态为升级，返回已经是最新版本
            String upgradeStatus = deviceRollbackVo.getUpgradeStatus();
            if (upgradeStatus.equals("102") || upgradeStatus.equals("101") ) {
                upgradeData.setUpdatetype("1");
                upgradeData.setIfUpdate(false);
                return Result.success(upgradeData,"1", "已经是最新版本，无法升级");
            } else {    //2.1.2.3、存在，但状态为未升级
                //2.1.3、查询更新策略
                //2.1.3.1、更新策略为手动更新，返回 是否升级、版本号、更新策略
                String version = deviceRollbackVo.getVersion();
                if (deviceRollbackVo.getUploadStrategy().equals("002")) {
                    upgradeData.setUpdatetype("1");
                    upgradeData.setVersionID(version);
                    upgradeData.setIfUpdate(true);
                    upgradeData.setIsForcedUpdate("false");
                    return Result.success(upgradeData,"0", "是否回滚");
                } else {//2.1.3.2、更新策略为强制更新，返回 是否升级、版本号、更新策略
                    upgradeData.setUpdatetype("1");
                    upgradeData.setVersionID(version);
                    upgradeData.setIfUpdate(true);
                    upgradeData.setIsForcedUpdate("true");
                    return Result.success(upgradeData,"0", "是否回滚");
                }
            }
        }
    }


    /**
     * 接受APPId
     * 是否升级回退，是否强制升级，版本号
     */
    @PostMapping("/checkResult")
    public Result<?> checkResult(String APPId) {

        if (APPId == null || APPId == "") {
            return Result.success("1", "数据不存在，无法升级");
        }

        try {
            //1、根据APPID查询升级关联表（关联3 设备、升级、更新）
            DeviceUpgradeVo deviceUpgradeVo = updatePackageService.getUpgradeVoDevice(APPId);


            UpgradeData upgradeData = new UpgradeData();

            //2.1、数据不存在，返回不升级
            if (deviceUpgradeVo == null) {
                //2.1.1、根据APPID查询回退关联表（关联3，设备，资源，回退）
                return checkRollback(APPId);
            } else {
                //2.2、存在，但状态为升级，返回已经是最新版本
                String upgradeStatus = deviceUpgradeVo.getUpgradeStatus();
                if (upgradeStatus.equals("102") || upgradeStatus.equals("101")) {
                    upgradeData.setUpdatetype("1");
                    upgradeData.setIfUpdate(false);
                    return checkRollback(APPId);
                    //return Result.success(upgradeData,"1", "已经是最新版本，无法升级");
                } else {    //2.3、存在，但状态为未升级
                    //3、查询更新策略
                    //3.1、更新策略为手动更新，返回 是否升级、版本号、更新策略
                    String version = deviceUpgradeVo.getVersion();
                    if (deviceUpgradeVo.getUploadStrategy().equals("002")) {
                        upgradeData.setUpdatetype("0");
                        upgradeData.setVersionID(version);
                        upgradeData.setIfUpdate(true);
                        upgradeData.setIsForcedUpdate("false");
                        return Result.success(upgradeData,"0", "是否升级");
                    } else {//3.2、更新策略为强制更新，返回 是否升级、版本号、更新策略
                        upgradeData.setUpdatetype("0");
                        upgradeData.setVersionID(version);
                        upgradeData.setIfUpdate(true);
                        upgradeData.setIsForcedUpdate("true");
                        return Result.success(upgradeData,"0", "是否升级");
                    }
                }
            }
        }catch (Exception e){
            return Result.error("1", "请求失败");
        }

    }

    /**
     * 终端用appid调用提供提供的更新包下载接口
     * 返回zip文件下载路径，更新资源包版本号
     */
    @GetMapping("/loaderInterface")
    public void  loaderInterface(String APPId, HttpServletRequest request, HttpServletResponse response) {

        if (APPId == null || APPId == "") {
            return;
        }

        try {
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
                if (deviceRollbackVo == null || deviceRollbackVo.getUpgradeStatus().equals("102")){
//                return Result.error("1", "");
                    // return null;
                    return;
                }

                //2.1.2、数据存在，获取更新包主键
                uploadId = deviceRollbackVo.getUploadId();
                deviceRollbackId = deviceRollbackVo.getDeviceRollbackId();
            } else {
                if (deviceUpgradeVo.getUpgradeStatus().equals("102")) {
                    DeviceRollbackVo deviceRollbackVo = updatePackageService.getRollbackVoDevice(APPId);
                    if (deviceRollbackVo == null || deviceRollbackVo.getUpgradeStatus().equals("102")) {
                        return;
                    }
                    uploadId = deviceRollbackVo.getUploadId();
                    deviceRollbackId = deviceRollbackVo.getDeviceRollbackId();
                } else {
                    //2.2、数据存在，获取更新包主键
                    uploadId = deviceUpgradeVo.getUploadId();
                    deviceUpgradeId = deviceUpgradeVo.getDeviceUpgradeId();
                }
            }


            //2.3、通过更新包主键获取文件数据
            UpdateUpload updateUpload = updatePackageService.getUpload(uploadId);
            if (updateUpload == null) {
                //更新包查询出错
                // return Result.error("1", "更新包查询出错");
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
        }catch (Exception e){
            return;
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
        if (APPId == null || APPId == "" || isCode == null ||isCode =="") {
            return Result.success("1", "数据不存在，无法升级");
        }

        try {
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
                if (deviceRollbackVo == null || deviceRollbackVo.getUpgradeStatus().equals("102")){
                    return Result.error("1", "升级失败");
                }

                //2.1.2、数据存在，获取更新包主键
                uploadId = deviceRollbackVo.getUploadId();
                deviceRollbackId = deviceRollbackVo.getDeviceRollbackId();
            } else {
                if (deviceUpgradeVo.getUpgradeStatus().equals("102")) {
                    DeviceRollbackVo deviceRollbackVo = updatePackageService.getRollbackVoDevice(APPId);
                    if (deviceRollbackVo == null || deviceRollbackVo.getUpgradeStatus().equals("102")) {
                        return Result.error("1", "升级失败");
                    }
                    uploadId = deviceRollbackVo.getUploadId();
                    deviceRollbackId = deviceRollbackVo.getDeviceRollbackId();
                } else {
                    //2.2、数据存在，获取更新包主键
                    uploadId = deviceUpgradeVo.getUploadId();
                    deviceUpgradeId = deviceUpgradeVo.getDeviceUpgradeId();
                }
            }


            //3.1、升级不成功，修改升级表状态（升级中-->升级失败-->未升级）（1升级）
            //3.2、升级成功，修改升级表状态（升级中-->升级成功-->已升级）
            if (deviceUpgradeId != 0) {
                DeviceUpgrade deviceUpgrade = new DeviceUpgrade();
                deviceUpgrade.setDeviceUpgradeId(deviceUpgradeId);
                deviceUpgrade.setUpgradeStatus(isCode);
                upgradeData.setUpdatetype("1");
                //更新
                updatePackageService.updateDeviceUpdate(deviceUpgrade);
            }
            if (deviceRollbackId != 0) {
                DeviceRollback deviceRollback = new DeviceRollback();
                deviceRollback.setDeviceRollbackId(deviceRollbackId);
                if (isCode.equals("102")) {
                    isCode = "102";
                }
                deviceRollback.setUpgradeStatus(isCode);
                upgradeData.setUpdatetype("1");
                //更新
                updatePackageService.updateDeviceRollback(deviceRollback);
            }

            //4、返回终端信息
            if (isCode.equals("100")) {

                return Result.success(upgradeData,"1", "升级失败");
            } else {

                return Result.success(upgradeData,"0", "该终端已完成升级");
            }
        }catch (Exception e){
            return  Result.error("1","请求失败");
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
    public Result<?> register(HttpServletRequest request,String equipmentIp) {
        if (equipmentIp == null || equipmentIp == "" ) {
            return Result.error("1", "数据不存在");
        }

        try {
            String equipmentContinuePort = "";

            String appId = null;
            //1.通过IP、端口查询设备资源 （关联2 设备、资源）
            DeviceEquipmentVo deviceEquipmentVo= updatePackageService.getDeviceEquipmentVo(equipmentIp,equipmentContinuePort);
            //2.1不存在资源，返回录入信息
            if (deviceEquipmentVo == null || equipmentIp == "") {
                return Result.error("1", "不存在设备资源:"+equipmentIp);
            } else {//2.2存在资源
                appId = deviceEquipmentVo.getAppId();


                String registerStatus = deviceEquipmentVo.getRegisterStatus();
                int deviceId = deviceEquipmentVo.getDeviceId();

                if(registerStatus.equals("101")) {
                    //3.1注册存在，但终端已注册，返回终端已经注册，不能重复注册,返回已注册APPID
                    return Result.success(appId,"1", "终端已经注册，不能重复注册");
                } else {
                    //3.2注册存在，终端未注册，进行终端注册（修改注册表），返回APPID （1，注册表）
                    Device device = new Device();
                    device.setDeviceId(deviceId);
                    device.setRegisterStatus("101");
                    updatePackageService.updateDeviceStatus(device);
                    return Result.success(appId,"0", "终端注册成功");
                }
            }
        }catch ( Exception e){
            return Result.error("1","请求失败");
        }

//        String equipmentIp = ip;
        //equipmentIp = getIpAddress(request);

    }


    /**
     * 配置文件上传
     * @param appId
     * @param file
     * @param request
     * @return
     * @throws IOException
     */
    @PostMapping("/configurationUploading")
    public Result<?> configurationUploading (String appId,MultipartFile file, String time,HttpServletRequest request) throws IOException {
        if (appId == null || appId == "" || file == null) {
            return Result.error("1", "数据不存在");
        }

        try {
            //1、根据APPID查询配置文件
            // 1.获取原始文件名
            String fileName = file.getOriginalFilename();
            ConfigurationFile configurationFile = new ConfigurationFile();
            List<ConfigurationFile> configurationFiles = new ArrayList<>();
            configurationFiles = updatePackageService.getConfigurationFile(appId,fileName);
            String filePath = request.getSession().getServletContext().getRealPath("/configurationFile/"+ appId);
            //判断数据是否存在，存在则修改，不存在则新增
            if(configurationFiles.size() < 1) {
                return Result.error("1", "上传失败");
            } else {
                configurationFile = configurationFiles.get(0);
                //修改
                configurationFile.setTerminalTime(time);
                configurationFile.setWebTime(time);
                configurationFile.setFilePath(filePath+"/"+fileName);
                //已同步
                configurationFile.setFileStatus("102");
                updatePackageService.updateConfigurationFile(configurationFile);
            }
            if (file != null) {
                //4.文件大小
                double uploadFileSize = file.getSize();
                //5.获取文件类型
                String uploadFileType = file.getContentType();

                //创建文件夹，存放文件
                String realPath = filePath;
                File dir = new File(realPath);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                // 1.创建空文件
                File newFile = new File(dir, fileName);
                // 2.将参数file（上传文件）写入空文件中
                file.transferTo(newFile);
            } else {
                return Result.error("1", "上传失败");

            }
            return Result.success("0","上传成功");
        }catch (Exception e){
            return Result.error("1","请求失败");
        }

    }



    /**
     * 终端用appid，fileName调用提供提供的更新包下载接口
     */
    @GetMapping("/configurationDownload")
    public void  configurationDownload(String appId, String fileName,HttpServletRequest request, HttpServletResponse response) {
        if (appId == null || appId == "" || fileName == null || fileName == "") {
            return ;
        }
        //1、通过APPID查询
        ConfigurationFile configurationFile = new ConfigurationFile();
        List<ConfigurationFile> configurationFiles = new ArrayList<>();
        configurationFiles = updatePackageService.getConfigurationFile(appId,fileName);

        //修改状态
        if (configurationFiles.size() < 1) {
            return;
        } else {
            configurationFile = configurationFiles.get(0);
            String webTime = configurationFile.getWebTime();
            //修改
            configurationFile.setTerminalTime(webTime);
            //已同步
            configurationFile.setFileStatus("102");
            updatePackageService.updateConfigurationFile(configurationFile);
        }

        //文件处理
        String filePath = configurationFile.getFilePath();
        //fileName = "";

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
     *
     * @param appId
     * @return
     *  ifUpdate    0内容为空；
     *              1内容不为空，且状态不同步
     *              2内容不为空，且状态已同步
     */
    @GetMapping("/configurationInformation")
    public Result<?> configurationInformation (String appId) {
        try {
            if (appId == null || appId == "") {
                return Result.error("1","数据不存在");
            }
            List<ConfigurationFile> configurationFiles = new ArrayList<>();
            configurationFiles = updatePackageService.getConfigurationFile(appId,null);
            List<HashMap> list = new ArrayList();

            //查询内容为空
            if (configurationFiles.size() < 1) {
                //返回空数组
                return Result.success(list,"0","请求成功");
            } else {
                for (ConfigurationFile configurationFile : configurationFiles) {

                    HashMap<String,Object> map = new HashMap<>();
                    String terminalTime = configurationFile.getTerminalTime();
                    String webTime =configurationFile.getWebTime();
                    String fileStatus = configurationFile.getFileStatus();
                    String configPath = configurationFile.getConfigPath();
                    if (webTime == null || webTime == "" || terminalTime == null || terminalTime == "") {
                        map.put("fileName",configurationFile.getFileName());
                        map.put("ifUpdate",0);
                        map.put("configPath",configPath);
                        list.add(map);
                    } else {
                        map.put("terminalTime",terminalTime);
                        map.put("webTime",webTime);
                        map.put("configPath",configPath);
                        map.put("fileName",configurationFile.getFileName());
                        //未同步
                        if (fileStatus.equals("101")) {
                            map.put("ifUpdate",1);
                        } else {
                            //同步
                            map.put("ifUpdate",2);
                        }
                        list.add(map);
                    }

                }
            }
            return Result.success(list,"0","请求成功");
        }catch (Exception e){
            return Result.error("1","请求失败");
        }
    }
}
