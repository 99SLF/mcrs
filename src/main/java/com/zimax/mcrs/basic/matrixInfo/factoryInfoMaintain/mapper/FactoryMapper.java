package com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.mapper;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfo;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfoVo;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfo;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfoVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/19 14:15
 */
@Mapper
public interface FactoryMapper {

    /**
     * 添加工厂维护信息
     * @param factoryInfo 工厂信息
     * @return
     */
    void addFactoryInfo(FactoryInfo factoryInfo);

//    /**
//     * 主键删除工厂信息
//     */
//    void deleteFactory(int factoryId);


    /**
     * 查询信息
     */
    List<FactoryInfoVo> queryFactoryInfos(Map map);

    int count(@Param("infoId") String infoId);



    /**
     * 更新
     */
    void updateFactoryInfo(FactoryInfo factoryInfo);
}
