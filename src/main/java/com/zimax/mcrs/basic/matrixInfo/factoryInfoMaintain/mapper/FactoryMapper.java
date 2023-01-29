package com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.mapper;

import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfo;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfoVo;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfo;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfoVo;
import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.Matrix;
import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.MatrixVo;
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
     *
     * @param factoryInfo 工厂信息
     * @return
     */
    void addFactoryInfo(FactoryInfo factoryInfo);

//    /**
//     * 主键删除工厂信息
//     */
//    void deleteFactory(int factoryId);

    /**
     * （接入点编辑）
     * 初始化下拉框，获取全部的工厂代码
     */
    List<FactoryInfoVo> selectListInit(@Param("matrixCode") String matrixCode);

    int countFactory(@Param("matrixCode") String matrixCode);


    /**
     * 查询工厂信息（树表）
     */
    List<FactoryInfoVo> queryFactoryInfos(Map map);

    int count(@Param("infoId") String infoId);

    /**
     * 查询工厂信息（无树表）
     */
    List<FactoryInfoVo> queryFactoryInfosNode(Map map);

    int countNode(@Param("nodeId") String nodeId);

    List<FactoryInfo> queryFactoryInfosTree(Map map);


    /**
     * 更新
     */
    void updateFactoryInfo(FactoryInfo factoryInfo);

    /**
     * 接入点新增，通过基地id查询工厂信息
     *
     * @param matrixId
     */
    List<FactoryInfo> selectList(@Param("matrixId") String matrixId);

//    int countFactory(@Param("infoId") String infoId);


    /**
     * 接入点新增
     * 通过工厂代码获取工厂信息（名称）
     *
     * @param
     * @return
     */
    List<FactoryInfo> getFactoryName(Map map);


    void removeFactory(int realId);

    int countFactoryProcess(@Param("factoryId") int factoryId);


    /**
     * （基础数据目录树）
     * 查询出当前树节点的详细工厂信息
     *
     * @param
     * @return
     */
    List<FactoryInfo> queryFactoryNode(int nodeId);
}
