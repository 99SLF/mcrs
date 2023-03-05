package com.zimax.mcrs.device.mapper;

import com.zimax.mcrs.basic.accPointResMaintain.pojo.AccPointRes;
import com.zimax.mcrs.device.pojo.Equipment;
import com.zimax.mcrs.device.pojo.EquipmentVo;
import com.zimax.mcrs.device.pojo.WorkStation;
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
    void updateEquipmentByUpload (Equipment equipment);

    /**
     * 记录条数
     *
     * @return
     */
    int count(@Param("equipmentId") String equipmentId, @Param("equipmentName") String equipmentName, @Param("enable") String enable,
              @Param("equipmentInstallLocation") String equipmentInstallLocation,
              @Param("equipTypeName") String equipTypeName,
              @Param("protocolCommunication") String protocolCommunication,
              @Param("accPointResName") String accPointResName,
              @Param("processName") String processName,
              @Param("createName") String createName,
              @Param("createTime") String createTime);

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
    int checkEquipmentIp(@Param("equipmentIp") String equipmentIp,@Param("equipmentInt") String equipmentInt);

    /**
     * 检查输入Ip是否已存在
     * @return
     */
    int checkExistenceIp(@Param("equipmentIp") String equipmentIp);


    /**
     * 查询设备是否存在工位
     * @param equipmentInt 设备主键
     * @return
     */
    List<WorkStation> queryWorkStation(int equipmentInt);

    /**
     * 给对应的设备添加工位
     */
    void addWorkStation(WorkStation workStation);

    /**
     * 删除工位信息
     */
    void removeWorkStation(int workStationId);


    /**
     * 根据主键查询设备信息
     */
    Equipment queryEquipment(int equipmentInt);

    /**
     * 批量启用
     */
    int enable(Equipment equipment);

    /**
     * 批量启用
     */
    int noEnable(Equipment equipment);
    /**
     * 批量删除工位
     */
    void delWorkStationByequInt(int equipmentInt);
}
