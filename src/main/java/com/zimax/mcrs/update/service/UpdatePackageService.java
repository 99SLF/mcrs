package com.zimax.mcrs.update.service;

import com.zimax.mcrs.update.mapper.UpdatePackageMapper;
import com.zimax.mcrs.update.pojo.DeviceRecordUpdateMsgVo;
import com.zimax.mcrs.update.pojo.RecordUpdateMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author 李伟杰
 * @date 2022/12/14 8:38
 */
@Service
public class UpdatePackageService {

    @Autowired
    private UpdatePackageMapper updatePackageMapper;

    /**
     * 通过appid查询终端，升级记录表，更新包信息
     * @param
     * @return
     */
    public DeviceRecordUpdateMsgVo getDevice(String APPId) {

        return updatePackageMapper.getDevice(APPId);

    }

//    /**
//     * 通过更新包id查询记录
//     * @param uploadId
//     */
//    public VersionUploadStrategyVo getVersionUploadStrategy(String uploadId) {
//        return updatePackageMapper.getVersionUploadStrategy(uploadId);
//    }

    /**
     * 新增
     * @param
     */
    public void addRecordUpdateMsg(RecordUpdateMsg recordUpdateMsg) {

        updatePackageMapper.addRecordUpdateMsg(recordUpdateMsg);
    }

    /**
     * 更新
     */
    public void updateRecordUpdateMsg(RecordUpdateMsg recordUpdateMsg) {

        updatePackageMapper.updateRecordUpdateMsg(recordUpdateMsg);
    }
}
