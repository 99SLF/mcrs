package com.zimax.mcrs.device.mapper;

import com.zimax.mcrs.device.pojo.Equipment;

import java.util.List;

/**
 * 设备
 * @author 林俊杰
 * @date 2022/11/28
 */
public interface EquipmentMapper {

    /**
     * 初始化查询
     * @return
     */
    public List<Equipment> queryEquipment();

    /**
     * 新建设备
     * @return
     */
//    public void addEquipment(Equipment equipment);

    /**
     * 导入（从excle模板导入）
     */
//    public void importEquipment();

    /**
     * 依据设备资源号查询设备
     * @return
     */
//    public Equipment getEquipment(int deviceId);

    /**
     * 依据设备资源号查询设备
     * @return
     */
//    public void getEquipmentName(String EquipmentName);

    /**
     * 删除设备
     * @return
     */
//    public void removeEquipment(int EquipmentId);

    /**
     * 更新设备
     * @return
     */
//    public void updateEquipment(Equipment equipment);

}
