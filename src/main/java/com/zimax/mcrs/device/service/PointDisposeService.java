package com.zimax.mcrs.device.service;

import com.zimax.components.coframe.framework.pojo.Application;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.device.mapper.PointDisposeMapper;
import com.zimax.mcrs.device.pojo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author 施林丰
 * @Date:2022/12/21 9:52
 * @Description
 */
@Service
public class PointDisposeService {
    @Autowired
    PointDisposeMapper pointDisposeMapper;

    /**
     * 新增点位
     *
     * @param pointDispose
     */
    public void addPoint(PointDispose pointDispose) {
        pointDisposeMapper.addPoint(pointDispose);
        addPointother(pointDispose);
    }
    public void addPointother(PointDispose pointDispose) {
        if (pointDispose.getPlcGroupList().size() > 0) {
            for (PlcGroup plcGroup : pointDispose.getPlcGroupList()) {
                plcGroup.setAppId(pointDispose.getAppId());
                pointDisposeMapper.addPlcGroup(plcGroup);
                if (plcGroup.getPlcPointList() != null && plcGroup.getPlcPointList().size() > 0) {
                    for (PlcPoint plcPoint : plcGroup.getPlcPointList()) {
                        plcPoint.setPlcGroupId(plcGroup.getPlcGroupId());
                        pointDisposeMapper.addPlcParam(plcPoint);
                    }
                }
            }
        }
        if (pointDispose.getRfidGroupList().size() > 0) {
            for (RfidGroup rfidGroup : pointDispose.getRfidGroupList()) {
                rfidGroup.setAppId(pointDispose.getAppId());
                pointDisposeMapper.addRfidGroup(rfidGroup);
                if (rfidGroup.getRfidPointList() != null && rfidGroup.getRfidPointList().size() > 0) {
                    for (RfidPoint rfidPoint : rfidGroup.getRfidPointList()) {
                        rfidPoint.setRfidGroupId(rfidGroup.getRfidGroupId());
                        pointDisposeMapper.addRfidParam(rfidPoint);
                    }
                }
            }
        }
    }
    /**
     * 查询所有点位信息
     *
     * @return
     */
    public List<PointDispose> queryPointDisposes(String page, String limit, String deviceName, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "app_id");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("deviceName", deviceName);
        return pointDisposeMapper.queryPointDisposes(map);
    }

    /**
     * 查询记录
     */
    public int count(String deviceName) {
        return pointDisposeMapper.count(deviceName);
    }

    public PointDispose getPointDispose(String appId) {
        PointDispose pointDispose = new PointDispose();
        List<PlcGroup> plcGroupList = pointDisposeMapper.queryPlcGroups(appId);
        List<RfidGroup> rfidGroupList = pointDisposeMapper.queryRfidGroups(appId);
        List<PlcPoint> plcPointList;
        List<RfidPoint> rfidPointList;
        if(plcGroupList!=null&&plcGroupList.size()>0){
            for(PlcGroup plcGroup: plcGroupList){
                plcPointList= new ArrayList<>();
                plcPointList = pointDisposeMapper.queryPlcPoints(plcGroup.getPlcGroupId());
                if(plcPointList!=null&&plcPointList.size()>0){
                    plcGroup.setPlcPointList(plcPointList);
                }
            }
            pointDispose.setPlcGroupList(plcGroupList);
        }
        if(rfidGroupList!=null&&rfidGroupList.size()>0){
            for(RfidGroup rfidGroup: rfidGroupList){
                rfidPointList= new ArrayList<>();
                rfidPointList = pointDisposeMapper.queryRfidPoints(rfidGroup.getRfidGroupId());
                if(rfidPointList!=null&&rfidPointList.size()>0){
                    rfidGroup.setRfidPointList(rfidPointList);
                }
            }
            pointDispose.setPlcGroupList(plcGroupList);
            pointDispose.setRfidGroupList(rfidGroupList);
        }
        return pointDispose;

    }
    public void delPointDispose(String appId) {
        List<PlcGroup>plcGroupList = pointDisposeMapper.queryPlcGroups(appId);
        List<RfidGroup>rfidGroupList = pointDisposeMapper.queryRfidGroups(appId);
        if(plcGroupList.size()>0){
            for(PlcGroup plcGroup: plcGroupList){
                pointDisposeMapper.delPlcPoints(plcGroup.getPlcGroupId());
            }
            pointDisposeMapper.delPlcGroups(appId);
        }
        if(rfidGroupList.size()>0){
            for(RfidGroup rfidGroup: rfidGroupList){
                pointDisposeMapper.delRfidPoints(rfidGroup.getRfidGroupId());
            }
            pointDisposeMapper.delRfidGroups(appId);
        }
        pointDisposeMapper.delPointDispose(appId);
    }
    public void updatePointDispose(PointDispose pointDispose) {
        List<PlcGroup>plcGroupList = pointDisposeMapper.queryPlcGroups(pointDispose.getAppId());
        List<RfidGroup>rfidGroupList = pointDisposeMapper.queryRfidGroups(pointDispose.getAppId());
        if(plcGroupList.size()>0){
            for(PlcGroup plcGroup: plcGroupList){
                pointDisposeMapper.delPlcPoints(plcGroup.getPlcGroupId());
            }
            pointDisposeMapper.delPlcGroups(pointDispose.getAppId());
        }
        if(rfidGroupList.size()>0){
            for(RfidGroup rfidGroup: rfidGroupList){
                pointDisposeMapper.delRfidPoints(rfidGroup.getRfidGroupId());
            }
            pointDisposeMapper.delRfidGroups(pointDispose.getAppId());
        }
        pointDisposeMapper.updatePointDispose(pointDispose);
        addPointother(pointDispose);

    }

}
