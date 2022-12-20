package com.zimax.mcrs.basic.accPointResMaintain.equipTypeMaintain.mapper;

import com.zimax.mcrs.basic.accPointResMaintain.equipTypeMaintain.pojo.EquipTypeInfo;
import org.apache.ibatis.annotations.Mapper;


/**
 * @author 李伟杰
 * @date 2022/12/19 14:18
 */
@Mapper
public interface EquipMapper {

    /**
     * 添加设备维护信息
     *
     * @param equipTypeInfo 设备信息
     * @return
     */
    void addEquipInfo(EquipTypeInfo equipTypeInfo);

}
