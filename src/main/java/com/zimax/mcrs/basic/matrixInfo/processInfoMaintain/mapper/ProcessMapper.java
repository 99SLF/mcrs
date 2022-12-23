package com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.mapper;

import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfo;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfoVo;
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
     * 主键删除工厂信息
     */
    void deleteProcess(int processId);


    /**
     * 查询信息
     */
    List<ProcessInfoVo> queryProcessInfo(Map map);

    int count(@Param("infoId") String infoId);

    /**
     * 更新
     */
    void updateProcessInfo(ProcessInfo processInfo);
}
