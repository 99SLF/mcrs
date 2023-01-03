package com.zimax.mcrs.update.mapper;


import com.zimax.mcrs.update.pojo.DeviceRecordUpdateMsgVo;
import com.zimax.mcrs.update.pojo.RecordUpdateMsg;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UpdatePackageMapper {

    DeviceRecordUpdateMsgVo getDevice(String APPId);

//    VersionUploadStrategyVo getVersionUploadStrategy(String uploadId);

    void addRecordUpdateMsg(RecordUpdateMsg recordUpdateMsg);

    void updateRecordUpdateMsg(RecordUpdateMsg recordUpdateMsg);
}
