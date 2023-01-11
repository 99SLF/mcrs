package com.zimax.mcrs.device.controller;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.*;
import com.zimax.mcrs.device.service.DeviceRollbackService;
import com.zimax.mcrs.device.service.DeviceService;
import com.zimax.mcrs.device.service.DeviceUpgradeService;
import com.zimax.mcrs.update.service.UpdatePackageService;
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

    @Autowired
    private DeviceService deviceService;

    @Autowired
    private UpdatePackageService UpdatePackageService;

    /**
     * 条件查询
     *
     * @param version        升级版本号
     * @param deviceName         终端名称
     * @param deviceSoftwareType 终端软件类型
     * @param versionRollbackPeople 版本更改人
     * @param versionRollbackTime   版本更改时间
     * @param limit                 记录数
     * @param page                  页码
     * @param field                 排序字段
     * @param order                 排序方式
     * @return 终端列表
     */
    @GetMapping("/deviceRollback/query")
    public Result<?> queryDeviceUpgrade(String page, String limit,  String deviceName, String deviceSoftwareType, String version, String versionRollbackPeople, String versionRollbackTime, String order, String field) {
        List deviceRollback = deviceRollbackService.queryDeviceRollback(page, limit, deviceName, deviceSoftwareType,version, versionRollbackPeople, versionRollbackTime, order, field);
        return Result.success(deviceRollback, deviceRollbackService.count(deviceName,deviceSoftwareType, version,versionRollbackPeople,versionRollbackTime));
    }


    /**
     * 回退记录
     */
    @PostMapping("/deviceRollback/add")
    public Result<?> addDeviceUpgrade(@RequestBody Map json) {
        // System.out.println(json);

        //获取前端终端主键
        String deviceIds = json.get("DeviceIds").toString().substring(1, json.get("DeviceIds").toString().length() - 1).replace('"', ' ');

       //获取更新包主键
        String uploadIdString = json.get("UploadId").toString();
        int uploadId = Integer.parseInt(uploadIdString);

        //将获取的终端主键放到数组用于遍历
        String[] deviceIdArray = deviceIds.split(",");


        for (String key : deviceIdArray) {
            int deviceId = Integer.valueOf(key.replace(" ", ""));

            //如果传过来的终端id查询数据库所有未回退的记录数。（条件，终端主键，未升级）
            List<DeviceUploadRollbackVo> lists = new ArrayList<DeviceUploadRollbackVo>();
            lists = deviceRollbackService.queryRollRecordId (String.valueOf(deviceId));
            int i = lists.size();

            //没有有数据（list集合，长度数<1），新增一条升级记录

            if (i < 1) {
                DeviceRollback deviceRollback = new DeviceRollback();

                //将当前选择的终端id存到升级表
                deviceRollback.setDeviceId(deviceId);

                //将当前选择的更新包存到升级表
                deviceRollback.setUploadId(uploadId);

                //获取更新人
                IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
                deviceRollback.setVersionRollbackPeople(userObject.getUserName());

                //记录当前更新时间
                deviceRollback.setVersionRollbackTime(new Date());

                //100为未回退，101为回退中，102已回退
                deviceRollback.setUpgradeStatus("100");

                //通过终端id查询为回退前的版本号

                String rollbackBeforeVersion = deviceUpgradeService.getVersion(deviceId).getVersion();
                deviceRollback.setRollbackBeforeVersion(rollbackBeforeVersion);

                //通过终端主键获取设备信息
                int equipmentInt = deviceService.getEquipment(deviceId).getEquipmentInt();
                deviceRollback.setEquipmentInt(equipmentInt);

                //调用添加方法
                deviceRollbackService.addDeviceRollback(deviceRollback);

            } else {

                //如果传过来的中id list.size() 有数据,（且仅有一条数据）通过主键 更新更新包主键 为当前前端传过来的主键
                DeviceUploadRollbackVo deviceRollbackVo = lists.get(0);

                //获取该条已有的回退记录表的主键，用于修改操作
                int deviceRollbackId = deviceRollbackVo.getDeviceRollbackId();

                //复用接口，所有获取获取该条已有的回退记录表的更新包主键
                int equipmentInt = deviceRollbackVo.getEquipmentInt();

                //复用接口，所有获取获取该条已有的回退记录表的终端主键
                int deviceId1 = deviceRollbackVo.getDeviceId();

                //复用接口，所有获取获取该条已有的回退记录表的回退状态
                String upgradeStatus = deviceRollbackVo.getUpgradeStatus();

                //复用接口，所有获取获取该条已有的回退记录表的回退前版本号
                String rollbackBeforeVersion = deviceRollbackVo.getRollbackBeforeVersion();


                DeviceRollback deviceRollback = new DeviceRollback();

                deviceRollback.setDeviceRollbackId(deviceRollbackId);
                deviceRollback.setEquipmentInt(equipmentInt);
                deviceRollback.setDeviceId(deviceId1);
                deviceRollback.setUpgradeStatus(upgradeStatus);
                deviceRollback.setRollbackBeforeVersion(rollbackBeforeVersion);

                //改动了更新包id（为新传过来的id），版本修改人，修改时间
                IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
                deviceRollback.setVersionRollbackPeople(userObject.getUserName());
                deviceRollback.setVersionRollbackTime(new Date());
                deviceRollback.setUploadId(uploadId);

                //调用更新接口
                UpdatePackageService.updateDeviceRollbackAll(deviceRollback);
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
