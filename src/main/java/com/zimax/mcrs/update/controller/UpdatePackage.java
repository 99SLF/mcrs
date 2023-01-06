package com.zimax.mcrs.update.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.components.coframe.rights.pojo.User;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.update.pojo.DeviceRecordUpdateMsgVo;
import com.zimax.mcrs.update.pojo.RecordUpdateMsg;
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
     * 接受APPId
     * 是否升级，是否强制升级，版本号
     */
    @PostMapping("/checkResult")
    public Result<?> checkResult(String APPId) {

        //查询表eqi_device，upd_record，upd_upload ，通过终端主键，更新包主键关联，中间表是upd_record，如果appid查询的升级状态是空，或者是未升级的话，就返回信息，问终端“是否升级”
        DeviceRecordUpdateMsgVo deviceRecordUpdateMsgVo = updatePackageService.getDevice(APPId);


        if (deviceRecordUpdateMsgVo!= null && deviceRecordUpdateMsgVo.getUpdateStatus()=="") {


            //查询表eqi_device，upd_record，upd_upload ，通过终端主键，更新包主键关联，中间表是upd_record，查询该条更新包的版本号和升级策略
            String version = updatePackageService.getDevice(APPId).getVersion();
            String uploadStrategy = updatePackageService.getDevice(APPId).getUploadStrategy();

            // 通过appid查询，一条终端的一条数据获取主键
            int deviceId = updatePackageService.getDevice(APPId).getDeviceId();
            int uploadId = updatePackageService.getDevice(APPId).getUploadId();

            //新增一条数据到upd_record表，将勾选的appid和勾选的更新包id，和前端页面传过来的创建人和创建时间（或者是后端)，将更新状态改为未升级
            RecordUpdateMsg recordUpdateMsg = new RecordUpdateMsg();
            recordUpdateMsg.setDeviceId(deviceId);
//            int uploadIdVal = Integer.parseInt(uploadId);
            recordUpdateMsg.setUploadId(uploadId);
            String creator = DataContextManager.current().getMUODataContext().getUserObject().getUserId();
            recordUpdateMsg.setCreator(creator);
            recordUpdateMsg.setCreateTime(new Date());
            recordUpdateMsg.setUpdateStatus("未升级");
            updatePackageService.addRecordUpdateMsg(recordUpdateMsg);

            //如果更新策略是强制升级的话就返回是否强制升级，和要要升级的版本号
            if (uploadStrategy == "强制更新") {
                return Result.success("200", "是否升级" + "；" + "即将升级的版本号为" + version + "；" + "是否强制升级");

            } else {
                return Result.success("200", "是否升级" + "；" + "即将升级的版本号为" + version + "；" + "请手动更新");
            }
        } else {
            return Result.error("0", "当前已经是最新版本");
        }

    }

    /**
     * 终端用appid调用提供提供的更新包下载接口
     * 返回zip文件下载路径，更新资源包版本号
     */
    @GetMapping("/loaderInterface")
    public Result<?> loaderInterface(@PathVariable("APPId") String APPId, @PathVariable("uploadId") String uploadId) {
        //通过uploadId，获取更新包存储地址，得到文件

        //文件的解压，自动运行

        //更新upd_record表，将更新状态改为升级中
        RecordUpdateMsg recordUpdateMsg = new RecordUpdateMsg();
        recordUpdateMsg.setUpdateStatus("升级中");
        updatePackageService.updateRecordUpdateMsg(recordUpdateMsg);
        return Result.success("200", "正在升级");

    }


    /**
     * 接受终端升级状态返回的接口
     * 终端传appid，升级状态码
     *
     * @param par 字符串 {APPId ,isCode}
     */
    @PostMapping("/loaderResult")
    public Result<?> loaderResult(@RequestBody String par) {

        //将传过来的值装为数组
        JSONArray array = JSON.parseArray(par);

        //通过appid、更新upd_record表
        String UpdateStatus = (String) array.get(1);
        if (UpdateStatus == "200") {
            String APPId = (String) array.get(0);
            RecordUpdateMsg recordUpdateMsg = new RecordUpdateMsg();
            recordUpdateMsg.setUpdateStatus("已升级");
            //通过appid更新一条数据
            updatePackageService.updateRecordUpdateMsg(recordUpdateMsg);
        } else {
            return Result.error("0", "升级失败");
        }
        return Result.success("200", "该终端已完成升级");
    }




}
