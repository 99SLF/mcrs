package com.zimax.mcrs.device.controller;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.DeviceUpgrade;
import com.zimax.mcrs.device.pojo.DeviceUploadUpgradeVo;
import com.zimax.mcrs.device.service.DeviceService;
import com.zimax.mcrs.device.service.DeviceUpgradeService;
import com.zimax.mcrs.update.service.UpdatePackageService;
import com.zimax.mcrs.update.service.UpdateUploadService;
import lombok.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
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

    @Autowired
    private UpdatePackageService updatePackageService;

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

//    public Result<?> queryRecordId(String deviceId) {
//        List deviceUpgrade = deviceUpgradeService.queryRecordId(deviceId);
//        return Result.success(deviceUpgrade);
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
        //通过deviceId，查询升级记录表符合的当前记录数
        //如果传过来的终端id查询数据库所有为升级的记录数。（条件，终端主键，未升级）没有有数据（list集合，长度数<1）
        for (String key : deviceIdArray) {
            int deviceId = Integer.valueOf(key.replace(" ", ""));
            List<DeviceUploadUpgradeVo> lists = new ArrayList<DeviceUploadUpgradeVo>();
            lists = deviceUpgradeService.queryRecordId(String.valueOf(deviceId));
            int i = lists.size();

//          int i = deviceUpgradeService.queryRecordIdCount(deviceId);
            if (i < 1) {
                DeviceUpgrade deviceUpgrade = new DeviceUpgrade();
                deviceUpgrade.setDeviceId(deviceId);
                deviceUpgrade.setUploadId(uploadId);
                IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
                deviceUpgrade.setVersionUpdater(userObject.getUserName());
                deviceUpgrade.setVersionUpdateTime(new Date());

                //100为未升级，101为升级中，102已升级
                deviceUpgrade.setUpgradeStatus("100");
                String version = updateUploadService.getUpdateUploadRecord(uploadId).getVersion();
                deviceUpgrade.setUpgradeVersion(version);

                //通过终端主键获取设备信息
                int equipmentInt = deviceService.getEquipment(deviceId).getEquipmentInt();
                deviceUpgrade.setEquipmentInt(equipmentInt);
                deviceUpgradeService.addDeviceUpgrade(deviceUpgrade);
            } else {

                //如果传过来的中id list.size() 有数据,（且仅有一条数据）通过主键 更新更新包主键 为当前前端传过来的主键
                DeviceUploadUpgradeVo deviceUploadUpgradeVo = lists.get(0);
                int deviceUpgradeId = deviceUploadUpgradeVo.getDeviceUpgradeId();
                int equipmentInt = deviceUploadUpgradeVo.getEquipmentInt();
                int deviceId1 = deviceUploadUpgradeVo.getDeviceId();
                String upgradeVersion = deviceUploadUpgradeVo.getUpgradeVersion();
                String upgradeStatus = deviceUploadUpgradeVo.getUpgradeStatus();

                DeviceUpgrade deviceUpgrade = new DeviceUpgrade();
                deviceUpgrade.setDeviceUpgradeId(deviceUpgradeId);
                deviceUpgrade.setEquipmentInt(equipmentInt);
                deviceUpgrade.setDeviceId(deviceId1);
                deviceUpgrade.setUpgradeVersion(upgradeVersion);
                deviceUpgrade.setUpgradeStatus(upgradeStatus);

                //改动了更新包id，版本修改人，修改时间
                IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
                deviceUpgrade.setVersionUpdater(userObject.getUserName());
                deviceUpgrade.setVersionUpdateTime(new Date());
                deviceUpgrade.setUploadId(uploadId);

                deviceUpgradeService.updateDeviceUpgrade(deviceUpgrade);
            }


        }
        return Result.success();
    }


}
