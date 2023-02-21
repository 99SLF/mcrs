package com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.mapper;

import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfo;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfoVo;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfo;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfoVo;
import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.Matrix;
import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.MatrixVo;
import com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.pojo.ProcessInfo;
import com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.pojo.ProcessInfoVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/19 14:17
 */
@Mapper
public interface ProcessMapper {

    /**
     * 添加工序维护信息
     * @param processInfo 工序维护信息
     * @return
     */
    void addProcessInfo(ProcessInfo processInfo);

    /**
     * 主键删除工序信息
     */
    void deleteProcess(int processId);


    /**
     * 查询工序信息(树表)
     */
    List<ProcessInfoVo> queryProcessInfo(Map map);
    int count(@Param("infoId") String infoId);

    /**
     * 查询工序信息（无树表）
     */
    List<ProcessInfoVo> queryProcessInfoNode(Map map);
    int countNode(@Param("nodeId") String nodeId);


    List<ProcessInfo> queryProcessInfoTree(Map map);

    /**
     * 查询代码
     */
    List<ProcessInfoVo> selectListInit(@Param("factoryCode") String factoryCode);

    int countProcess(@Param("factoryCode") String factoryCode);

    /**
     * 更新
     */
    void updateProcessInfo(ProcessInfo processInfo);

    /**
     * 通过接入点新增
     * 查询工序信息
     * @param factoryId
     */
    List<ProcessInfo> selectList(@Param("factoryId") String factoryId);

    /**
     * 通过工序代码获取工序信息（名称和工序描述）
     * @param
     * @return
     */

    List<ProcessInfo> getProcessNameDe(Map map);

    void removeProcess(int processId);

    /**
     * 根据工序主键查询接入点引用
     * @param
     * @return
     */
    int countProcessAccess(@Param("processId") int processId);


    /**
     * （基础数据目录树）
     * 查询出当前树节点的详细工序信息
     * @param
     * @return
     */

    List<ProcessInfo> queryProcessNode(int nodeId);

    /**
     * （基础数据目录树）
     * 检测相同父节点下的工序名称是否存在
     *
     * @param parentId 上级节点的id
     */
    int checkProcessNameAdd(@Param("parentId") String parentId,@Param("processName") String processName);

    /**
     * （基础数据目录树）
     * 检测相同父节点下的工序名称是否存在
     *
     * @param parentId 上级节点的id
     */
    int checkProcessNameEdit(@Param("parentId") String parentId,@Param("processName") String processName,@Param("factoryId") String factoryId);

    /**
     * 根据工序id获取一条工厂信息
     * @param
     * @return
     */

    ProcessInfo getProcess(int processId);
}
