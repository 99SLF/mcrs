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
import lombok.val;
import lombok.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;

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
     * @param version            升级版本号
     * @param deviceName         终端名称
     * @param deviceSoftwareType 终端软件类型
     * @param limit              记录数
     * @param page               页码
     * @param field              排序字段
     * @param order              排序方式
     * @return 终端列表
     */
    @GetMapping("/deviceUpgrade/query")
    public Result<?> queryDeviceUpgrade(String page, String limit, String deviceName, String deviceSoftwareType, String version, String versionUpdater, String versionUpdateTime, String order, String field) {
        List deviceUpgrade = deviceUpgradeService.queryDeviceUpgrades(page, limit, deviceName, deviceSoftwareType, version, versionUpdater, versionUpdateTime, order, field);
        return Result.success(deviceUpgrade, deviceUpgradeService.count(deviceName, deviceSoftwareType, version, versionUpdater, versionUpdateTime));
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

        //通过device 遍历查询当前每个终端的版本号放到新的数组versions中
        //获取versions中的最大值
        //根据更新包id获取升级版本号
        //通过deviceId，查询升级记录表符合的当前记录数

        for (String key : deviceIdArray) {
            int deviceId = Integer.valueOf(key.replace(" ", ""));

            //如果传过来的终端id查询数据库所有未升级的记录数。（条件，终端主键，未升级）
            List<DeviceUploadUpgradeVo> lists = new ArrayList<DeviceUploadUpgradeVo>();
            lists = deviceUpgradeService.queryRecordId(String.valueOf(deviceId));
            int i = lists.size();

//          int i = deviceUpgradeService.queryRecordIdCount(deviceId);

            //没有有数据（list集合，长度数<1），新增一条升级记录

            if (i < 1) {
                DeviceUpgrade deviceUpgrade = new DeviceUpgrade();

                //将当前选择的终端id存到升级表
                deviceUpgrade.setDeviceId(deviceId);

                //将当前选择的更新包存到升级表
                deviceUpgrade.setUploadId(uploadId);

                //获取更新人
                IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
                deviceUpgrade.setVersionUpdater(userObject.getUserName());

                //记录当前更新时间
                deviceUpgrade.setVersionUpdateTime(new Date());

                //100为未升级，101为升级中，102已升级
                deviceUpgrade.setUpgradeStatus("100");

                //通过终端id查询为升级前的版本号

                String upgradeBeforeVersion = deviceUpgradeService.getVersion(deviceId).getVersion();
                deviceUpgrade.setUpgradeBeforeVersion(upgradeBeforeVersion);

                //通过终端主键获取设备信息
                int equipmentInt = deviceService.getEquipment(deviceId).getEquipmentInt();
                deviceUpgrade.setEquipmentInt(equipmentInt);

                //调用添加方法
                deviceUpgradeService.addDeviceUpgrade(deviceUpgrade);

            } else {

                //如果传过来的中id list.size() 有数据,（且仅有一条数据）通过主键 更新更新包主键 为当前前端传过来的主键
                DeviceUploadUpgradeVo deviceUploadUpgradeVo = lists.get(0);

                //获取该条已有的升级记录表的主键，用于修改操作
                int deviceUpgradeId = deviceUploadUpgradeVo.getDeviceUpgradeId();

                //复用接口，所有获取获取该条已有的升级记录表的更新包主键
                int equipmentInt = deviceUploadUpgradeVo.getEquipmentInt();

                //复用接口，所有获取获取该条已有的升级记录表的终端主键
                int deviceId1 = deviceUploadUpgradeVo.getDeviceId();

                //复用接口，所有获取获取该条已有的升级记录表的升级状态
                String upgradeStatus = deviceUploadUpgradeVo.getUpgradeStatus();

                //复用接口，所有获取获取该条已有的升级记录表的升级状态
                String upgradeBeforeVersion = deviceUploadUpgradeVo.getUpgradeBeforeVersion();


                DeviceUpgrade deviceUpgrade = new DeviceUpgrade();

                deviceUpgrade.setDeviceUpgradeId(deviceUpgradeId);
                deviceUpgrade.setEquipmentInt(equipmentInt);
                deviceUpgrade.setDeviceId(deviceId1);
                deviceUpgrade.setUpgradeStatus(upgradeStatus);
                deviceUpgrade.setUpgradeBeforeVersion(upgradeBeforeVersion);

                //改动了更新包id（为新传过来的id），版本修改人，修改时间
                IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
                deviceUpgrade.setVersionUpdater(userObject.getUserName());
                deviceUpgrade.setVersionUpdateTime(new Date());
                deviceUpgrade.setUploadId(uploadId);

                //调用更新接口
                deviceUpgradeService.updateDeviceUpgrade(deviceUpgrade);
            }


        }
        return Result.success();
    }


}
