package com.zimax.mcrs.basic.equipTypeMaintain.service;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.components.coframe.rights.pojo.User;
import com.zimax.mcrs.basic.equipTypeMaintain.mapper.EquipMapper;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfo;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfoVo;
import com.zimax.mcrs.config.ChangeString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/19 14:18
 */
@Service
public class EquipService {
    @Autowired
    private EquipMapper equipMapper;

    /**
     * 添加设备维护信息
     * @param equipTypeInfo 设备信息
     */
    public void addEquipInfo(EquipTypeInfo equipTypeInfo){
//        try {
//            String creator = DataContextManager.current().getMUODataContext().getUserObject().getUserId();
//            equipTypeInfo.setCreator(creator);
//            equipTypeInfo.setCreateTime(new Date());
//            if (equipTypeInfo.getUpdateTime() == null) {
//                equipTypeInfo.setUpdateTime(new Date());
//            }
//            if (equipTypeInfo.getUpdater() == null) {
//                equipTypeInfo.setUpdater(creator);
//            }
//        } catch (Exception e) {
//            throw new RuntimeException(e);
//        }
           equipMapper.addEquipInfo(equipTypeInfo);

    }

    /**
     * 查询所有信息
     */
    public List<EquipTypeInfoVo> queryEquipInfos(String page, String limit, String equipTypeCode, String equipTypeName, String creator, String createTime, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "create_time");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("equipTypeCode", equipTypeCode);
        map.put("equipTypeName", equipTypeName);
        map.put("creator", creator);
        map.put("createTime", createTime);
        return equipMapper.queryEquipInfos(map);

    }

    /**
     * 记录条数
     * @param
     * @return
     */
    public int count(String equipTypeCode, String equipTypeName, String creator, String createTime) {
        return equipMapper.count(equipTypeCode, equipTypeName,creator, createTime);
    }

    /**
     * 编辑
     */
    public void updateEquipInfo(EquipTypeInfo equipTypeInfo) {
        equipMapper.updateEquipInfo(equipTypeInfo);
    }

    /**
     * 批量删除
     *
     * @param equipTypeIds 编号
     */
    public void deleteEquipInfos(List<Integer> equipTypeIds) {
        equipMapper.deleteEquipInfos(equipTypeIds);
    }

}