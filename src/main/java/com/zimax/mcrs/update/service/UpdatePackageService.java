package com.zimax.mcrs.update.service;

import com.zimax.mcrs.device.mapper.DeviceMapper;
import com.zimax.mcrs.device.mapper.DeviceRollbackMapper;
import com.zimax.mcrs.device.mapper.DeviceUpdateMapper;
import com.zimax.mcrs.device.mapper.DeviceUpgradeMapper;
import com.zimax.mcrs.device.pojo.Device;
import com.zimax.mcrs.device.pojo.DeviceRollback;
import com.zimax.mcrs.device.pojo.DeviceUpdate;
import com.zimax.mcrs.device.pojo.DeviceUpgrade;
import com.zimax.mcrs.update.mapper.*;
import com.zimax.mcrs.update.pojo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @author 李伟杰
 * @date 2022/12/14 8:38
 */
@Service
public class UpdatePackageService {

    @Autowired
    private UpdatePackageMapper updatePackageMapper;

    @Autowired
    private DeviceRollbackVoMapper deviceRollbackVoMapper;

    @Autowired
    private DeviceUpgradeVoMapper deviceUpgradeVoMapper;

    @Autowired
    private UpdateUploadMapper updateUploadMapper;

    @Autowired
    private DeviceEquipmentVoMapper deviceEquipmentVoMapper;

    @Autowired
    private DeviceUpgradeMapper deviceUpgradeMapper;

    @Autowired
    private DeviceRollbackMapper deviceRollbackMapper;

    @Autowired
    private DeviceMapper deviceMapper;

    @Autowired
    private ConfigurationFileMapper configurationFileMapper;

    /**
     * 通过APPID查询终端，升级表，更新包信息
     * @param APPId
     * @return
     */
    public DeviceRollbackVo getRollbackVoDevice(String APPId) {

        return deviceRollbackVoMapper.getDevice(APPId);

    }

    /**
     * 通过APPID查询终端，升级表，更新包信息
     * @param APPId
     * @return
     */
    public DeviceUpgradeVo getUpgradeVoDevice(String APPId) {
        return deviceUpgradeVoMapper.getDevice(APPId);
    }


    /**
     * 通过appid查询终端，升级记录表，更新包信息
     * @param
     * @return
     */
    public DeviceRecordUpdateMsgVo getDevice(String APPId) {

        return updatePackageMapper.getDevice(APPId);

    }

    /**
     * 通过更新包主键查询单个更新包
     * @param uploadId
     * @return
     */
    public UpdateUpload getUpload(int uploadId) {
        List<Integer> uploadIds = new ArrayList<>();
        uploadIds.add(uploadId);
        List<UpdateUpload> updateUploads = updateUploadMapper.getUpload(uploadIds);
        if (updateUploads.size() < 1) {
            return null;
        } else {
            return updateUploads.get(0);
        }
    }

    /**
     * 通过IP\端口查询终端信息
     * @param equipmentIp
     * @param equipmentContinuePort
     * @return
     */
    public DeviceEquipmentVo getDeviceEquipmentVo(String equipmentIp, String equipmentContinuePort){
        return deviceEquipmentVoMapper.getDeviceEquipmentVo(equipmentIp, equipmentContinuePort);
    }

    /**
     * 修改升级表
     * @param deviceUpgrade
     */
    public void updateDeviceUpdate(DeviceUpgrade deviceUpgrade) {
        deviceUpgradeMapper.updateDeviceUpgradeStatus(deviceUpgrade);
    }

    /**
     * 修改升级表的uploadid
     * @param deviceUpgrade
     */
    public void updateDeviceUploadId(DeviceUpgrade deviceUpgrade) {
        deviceUpgradeMapper.updateDeviceUploadId(deviceUpgrade);
    }

    /**
     * 修改注册表状态
     * @param device
     */
    public void updateDeviceStatus(Device device){
        deviceMapper.updateDeviceStatus(device);
    }

    /**
     * 修改回退表
     * @param deviceRollback
     */
    public void updateDeviceRollback(DeviceRollback deviceRollback) {
        deviceRollbackMapper.updateDeviceRollback(deviceRollback);
    }


    /**
     * 获取配置文件表
     * @param appId
     * @param fileName
     * @return
     */
    public List<ConfigurationFile> getConfigurationFile(String appId, String fileName) {
        return configurationFileMapper.getConfigurationFile(appId,fileName);
    }


    /**
     * 修改配置文件
     * @param configurationFile
     */
    public void updateConfigurationFile(ConfigurationFile configurationFile) {
        configurationFileMapper.updateConfigurationFile(configurationFile);
    }


//    /**
//     * 通过更新包id查询记录
//     * @param uploadId
//     */
//    public VersionUploadStrategyVo getVersionUploadStrategy(String uploadId) {
//        return updatePackageMapper.getVersionUploadStrategy(uploadId);
//    }

//    /**
//     * 新增
//     * @param
//     */
//    public void addRecordUpdateMsg(RecordUpdateMsg recordUpdateMsg) {
//
//        updatePackageMapper.addRecordUpdateMsg(recordUpdateMsg);
//    }
//
//    /**
//     * 更新
//     */
//    public void updateRecordUpdateMsg(RecordUpdateMsg recordUpdateMsg) {
//
//        updatePackageMapper.updateRecordUpdateMsg(recordUpdateMsg);
//    }
}
