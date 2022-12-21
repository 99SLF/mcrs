package com.zimax.mcrs.basic.accPointResMaintain.equipTypeMaintain.service;

import com.zimax.mcrs.basic.accPointResMaintain.equipTypeMaintain.mapper.EquipMapper;
import com.zimax.mcrs.basic.accPointResMaintain.equipTypeMaintain.pojo.EquipTypeInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

        equipMapper.addEquipInfo(equipTypeInfo);
    }
}
