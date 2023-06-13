package com.zimax.mcrs.basic.equipTypeMaintain.mapper;

import com.zimax.components.coframe.rights.pojo.User;
import com.zimax.mcrs.basic.accPointResMaintain.pojo.AccPointRes;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfo;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfoVo;
import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.Matrix;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;


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



    /**
     * 查询信息
     */
    List<EquipTypeInfoVo> queryEquipInfos(Map map);

    int count(@Param("equipTypeCode") String equipTypeCode,
              @Param("equipTypeName") String equipTypeName,
              @Param("equipTypeEnable") String equipTypeEnable ,
              @Param("manufacturer") String manufacturer,
              @Param("equipControllerModel") String equipControllerModel,
              @Param("protocolCommunication") String protocolCommunication,
              @Param("mesIpAddress") String mesIpAddress,
              @Param("equipCreatorName") String equipCreatorName ,
              @Param("createTime") String createTime,
              @Param("equipUpdaterName") String equipUpdaterName,
              @Param("updateTime") String updateTime);



    /**
     * 更新
     */
    void updateEquipInfo(EquipTypeInfo equipTypeInfo);

    /**
     * 批量删除
     */
    void deleteEquipInfos(List<Integer> equipTypeIds);


    /**
     * 批量启用
     */
    int enable(EquipTypeInfo equipTypeInfo);



    List<EquipTypeInfo> getEquipTypeName();
}
