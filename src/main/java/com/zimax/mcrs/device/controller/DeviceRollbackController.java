package com.zimax.mcrs.device.controller;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.DeviceRollback;
import com.zimax.mcrs.device.pojo.DeviceUpgrade;
import com.zimax.mcrs.device.pojo.DeviceUploadUpgradeVo;
import com.zimax.mcrs.device.service.DeviceRollbackService;
import com.zimax.mcrs.device.service.DeviceUpgradeService;
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
public class DeviceRollbackController {

    @Autowired
    private DeviceRollbackService deviceRollbackService;

    @Autowired
    private DeviceUpgradeService deviceUpgradeService;

    /**
     * 条件查询
     *
     * @param upgradeVersion        升级版本号
     * @param equipmentId           设备资源号
     * @param versionRollbackPeople 版本更改人
     * @param versionRollbackTime   版本更改时间
     * @param limit                 记录数
     * @param page                  页码
     * @param field                 排序字段
     * @param order                 排序方式
     * @return 终端列表
     */
    @GetMapping("/deviceRollback/query")
    public Result<?> queryDeviceUpgrade(String page, String limit, String equipmentId, String upgradeVersion, String versionRollbackPeople, String versionRollbackTime, String order, String field) {
        List deviceRollback = deviceRollbackService.queryDeviceRollback(page, limit, equipmentId, upgradeVersion, versionRollbackPeople, versionRollbackTime, order, field);
        return Result.success(deviceRollback, deviceRollbackService.count(equipmentId, upgradeVersion));
    }


    /**
     * 回退记录
     */
    @PostMapping("/deviceRollback/add")
    public Result<?> addDeviceUpgrade(@RequestBody Map json) {
        String deviceUpgradeIds = json.get("deviceUpgradeIds").
                toString().substring(1, json.get("deviceUpgradeIds").toString().length() - 1);
        String[] deviceUpgradeIdArray = deviceUpgradeIds.split(",");


        for (String key : deviceUpgradeIdArray) {
            int deviceUpgradeId = Integer.valueOf(key);
            List<DeviceRollback> lists = new ArrayList<DeviceRollback>();
            lists = deviceRollbackService.queryRollbackMsg(String.valueOf(deviceUpgradeId));
            int i = lists.size();

            if (i<1){

                //通过升级表主键，查询回退表，返回list的集合

                DeviceUpgrade deviceUpgrade = deviceUpgradeService.getDeviceUpgrade(deviceUpgradeId);
                //回退表更新主键
                int equipmentInt = deviceUpgrade.getEquipmentInt();
                //回退表，终端主键
                int deviceId = deviceUpgrade.getDeviceId();
                //回退表，更新包主键
                int uploadId = deviceUpgrade.getUploadId();
                //回退表，回退版本号
                String upgradeVersion = deviceUpgrade.getUpgradeVersion();
                //升级状态，为已回退

                DeviceRollback deviceRollback = new DeviceRollback();
                deviceRollback.setDeviceUpgradeId(deviceUpgradeId);
                deviceRollback.setDeviceId(deviceId);
                deviceRollback.setEquipmentInt(equipmentInt);
                deviceRollback.setUploadId(uploadId);
                deviceRollback.setUpgradeVersion(upgradeVersion);
                deviceRollback.setUpgradeStatus("103");
                IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
                deviceRollback.setVersionRollbackPeople(userObject.getUserName());
                deviceRollback.setVersionRollbackTime(new Date());
                deviceRollbackService.addDeviceRollback(deviceRollback);

            }else {

                    return Result.error("1","该终端处于回退中，或已经回退，请尝试回退其他终端");
            }


        }
        return Result.success();
    }



    /**
     * 检测选择的升级记录信息是否已经回滚记录
     *
     * @param deviceUpgradeId 终端升级表
     */
    @GetMapping("/rollback/check/isExist")
    public Result<?> check(@RequestParam("deviceUpgradeId") String deviceUpgradeId) {
        if(deviceRollbackService.check(deviceUpgradeId)>0){
            return Result.error("1","当前所选升级记录，已存在回退记录，请重新选择");
        }else {
            return Result.success();
        }

    }
}
