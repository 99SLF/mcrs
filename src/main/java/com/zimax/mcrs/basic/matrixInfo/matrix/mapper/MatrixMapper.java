package com.zimax.mcrs.basic.matrixInfo.matrix.mapper;

import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfo;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfoVo;
import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.Matrix;
import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.MatrixVo;
import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.Matrix_TreeVo;
import com.zimax.mcrs.update.pojo.UpdateUpload;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/23 10:34
 */
@Mapper
public interface MatrixMapper {


    /**
     * 添加设备维护信息
     *
     * @param matrix 设备信息
     * @return
     */
    void addMatrix(Matrix matrix);


    /**
     * 查询信息
     */
    List<MatrixVo> queryMatrix(Map map);

    int count(@Param("infoId") String infoId);


    /**
     * 查询代码
     */
    List<MatrixVo> selectList();

    int countMatrix();

    /**
     * 更新
     */
    void updateMatrix(Matrix matrix);

    /**
     * 通过基地代码获取基地信息
     * @param
     * @return
     */

    List<Matrix> getMatrixName(Map map);
}