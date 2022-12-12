package com.zimax.mcrs.device.mapper;

import com.zimax.mcrs.device.pojo.Equipment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 设备
 *
 * @author 林俊杰
 * @date 2022/11/28
 */
@Mapper
public interface EquipmentMapper {

    /**
     * 查询所有
     *
     * @return
     */
    List<Equipment> queryAll(Map map);


    /**
     * 新建设备
     *
     * @return
     */
    void addEquipment(Equipment equipment);

    /**
     * 导入（从excle模板导入）
     */
//    public void importEquipment();


    /**
     * 删除设备
     *
     * @return
     */
    void removeEquipment(int EquipmentId);

    /**
     * 更新设备
     *
     * @return
     */
    void updateEquipment(Equipment equipment);


    /**
     * 记录条数
     *
     * @return
     */
    int count(@Param("equipmentId") String equipmentId, @Param("equipmentName") String equipmentName);


}
