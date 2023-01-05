package com.zimax.mcrs.device.controller;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.DeviceUpgrade;
import com.zimax.mcrs.device.service.DeviceService;
import com.zimax.mcrs.device.service.DeviceUpgradeService;
import com.zimax.mcrs.update.service.UpdateUploadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 终端管理
 *
 * @author 林俊杰
 * @date 2022/11/30
 */
@RestController
@ResponseBody
@RequestMapping("/equipment")
public class DeviceUpgradeController {

    @Autowired
    private DeviceUpgradeService deviceUpgradeService;

    @Autowired
    private UpdateUploadService updateUploadService;

    @Autowired
    private DeviceService deviceService;

    /**
     * 条件查询
     *
     * @param upgradeVersion 升级版本号
     * @param equipmentId    设备资源号
     * @param limit          记录数
     * @param page           页码
     * @param field          排序字段
     * @param order          排序方式
     * @return 终端列表
     */
    @GetMapping("/deviceUpgrade/query")
    public Result<?> queryDeviceUpgrade(String page, String limit, String equipmentId, String upgradeVersion, String versionUpdater, String versionUpdateTime, String order, String field) {
        List deviceUpgrade = deviceUpgradeService.queryDeviceUpgrades(page, limit, equipmentId, upgradeVersion, versionUpdater, versionUpdateTime, order, field);
        return Result.success(deviceUpgrade, deviceUpgradeService.count(equipmentId, upgradeVersion));
    }


    /**
     * 修改升级记录的升级状态
     */
    @PostMapping("/update")
    public Result<?> updateDeviceUpgrade(@RequestBody DeviceUpgrade deviceUpgrade) {
        deviceUpgradeService.updateDeviceUpgrade(deviceUpgrade);
        return Result.success();
    }
//    /**
//     * 新增升级记录的升级状态
//     */
//    @PostMapping("/add")
//    public Result<?> addDeviceUpgrade(@RequestBody Integer[] ids,@PathVariable("uploadIds") String uploadIds) {
//        deviceUpgradeService.addDeviceUpgrade(Arrays.asList(ids),uploadIds);
//        return Result.success();
//    }

    /**
     * 新增升级记录的升级状态
     */
    @PostMapping("/add")
    public Result<?> addDeviceUpgrade(@RequestBody Map json) {

        // System.out.println(json);
        String deviceIds = json.get("DeviceIds").toString().substring(1, json.get("DeviceIds").toString().length() - 1).replace('"', ' ');
        String uploadIdString = json.get("UploadId").toString();
        int uploadId = Integer.parseInt(uploadIdString);
        String[] deviceIdArray = deviceIds.split(",");
        //根据更新包id获取升级版本号
        for (String key : deviceIdArray) {
            int deviceId = Integer.valueOf(key.replace(" ", ""));
            DeviceUpgrade deviceUpgrade = new DeviceUpgrade();
            deviceUpgrade.setDeviceId(deviceId);
            deviceUpgrade.setUploadId(uploadId);
            IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
            deviceUpgrade.setVersionUpdater(userObject.getUserName());
            deviceUpgrade.setVersionUpdateTime(new Date());
            deviceUpgrade.setUpgradeStatus("未升级");
            //List<UpdateUpload> list = updateUploadService.getUpdateUploadRecord(uploadId);
            String version = updateUploadService.getUpdateUploadRecord(uploadId).getVersion();
            deviceUpgrade.setUpgradeVersion(version);
            //通过终端主键获取设备信息
            int equipmentInt = deviceService.getEquipment(deviceId).getEquipmentInt();
            deviceUpgrade.setEquipmentInt(equipmentInt);
            deviceUpgradeService.addDeviceUpgrade(deviceUpgrade);
        }
        return Result.success();
    }
}
