package com.zimax.mcrs.device.mapper;

import com.zimax.mcrs.device.pojo.Equipment;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 设备
 * @author 林俊杰
 * @date 2022/11/28
 */
@Mapper
public interface EquipmentMapper {

    /**
     * 初始化查询
     * @return
     */
    List<Equipment> queryAll();


    /**
     * 条件查询
     * @return
     */
    List<Equipment> query();

    /**
     * 新建设备
     * @return
     */
    void addEquipment(Equipment equipment);

    /**
     * 导入（从excle模板导入）
     */
//    public void importEquipment();


    /**
     * 删除设备
     * @return
     */
    public void removeEquipment(int EquipmentId);

    /**
     * 更新设备
     * @return
     */
    public void updateEquipment(Equipment equipment);

}
