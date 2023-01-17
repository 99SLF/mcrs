package com.zimax.mcrs.device.mapper;

import com.zimax.mcrs.device.pojo.Equipment;
import com.zimax.mcrs.device.pojo.EquipmentVo;
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
    List<EquipmentVo> queryAll(Map map);

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
    int count(@Param("equipmentId") String equipmentId, @Param("equipmentName") String equipmentName, @Param("enable") String enable, @Param("processName") String processName);

    /**
     * 批量删除设备
     * @param equipmentInt
     */
    void deleteEquipments(List<Integer> equipmentInt);

    /**
     * 检查当前设备资源号是否存在
     */
    int checkEquipmentId(@Param("equipmentId") String equipmentId);

    /**
     * 检查输入Ip是否已存在
     * @return
     */
    int checkEquipmentIp(@Param("equipmentIp") String equipmentIp);


}
