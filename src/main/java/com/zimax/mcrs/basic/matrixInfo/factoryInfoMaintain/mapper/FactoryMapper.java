package com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.mapper;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfo;
import org.apache.ibatis.annotations.Mapper;

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

    /**
     * 主键删除工厂信息
     */
    void deleteFactory(int factoryId);

}
