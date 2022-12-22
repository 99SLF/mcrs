package com.zimax.mcrs.device.mapper;

import com.zimax.mcrs.device.pojo.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @Author 施林丰
 * @Date:2022/12/20 11:43
 * @Description
 */
@Mapper
public interface PointDisposeMapper {
    void addPoint(PointDispose pointDispose);
    void addPlcGroup(PlcGroup plcGroup);
    void addPlcParam(PlcPoint plcPoint);
    void addRfidGroup(RfidGroup rfidGroup);
    void addRfidParam(RfidPoint rfidPoint);
    List<PointDispose> queryPointDisposes(Map map);
    List<PlcGroup> queryPlcGroups(String appId);
    List<PlcPoint> queryPlcPoints(int plcGroupId);
    List<RfidGroup> queryRfidGroups(String appId);
    List<RfidPoint> queryRfidPoints(int rfidGroupId);
    int count(@Param("deviceName") String deviceName);
    void delPointDispose(String appId);
    void delPlcGroups(String appId);
    void delPlcPoints(int plcGroupId);
    void delRfidGroups(String appId);
    void delRfidPoints(int rfidGroupId);
    void updatePointDispose(PointDispose pointDispose);
}
