package com.zimax.mcrs.basic.matrixInfo.matrix.service;


import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfo;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfoVo;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfoVo;
import com.zimax.mcrs.basic.matrixInfo.matrix.mapper.MatrixMapper;
import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.Matrix;
import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.MatrixVo;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.serialnumber.service.SerialnumberService;
import com.zimax.mcrs.update.pojo.UpdateUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/23 10:35
 */
@Service
public class MatrixService {

    @Autowired
    private MatrixMapper matrixMapper;

    @Autowired
    private SerialnumberService serialnumberService;
    /**
     * 添加设备维护信息
     *
     * @param matrix 基地信息
     */
    public void addMatrix(Matrix matrix) {

        String coding = serialnumberService.getSerialNum("jdCod").replace("_", "");
        matrix.setMatrixCode(coding);
        IUserObject useObject = DataContextManager.current().getMUODataContext().getUserObject();
        matrix.setCreator(useObject.getUserId());
        matrix.setCreateTime(new Date());
        matrixMapper.addMatrix(matrix);

    }

    /**
     * 编辑
     */
    public void updateMatrix(Matrix matrix) {

        IUserObject useObject = DataContextManager.current().getMUODataContext().getUserObject();
        matrix.setUpdater(useObject.getUserId());
        matrix.setUpdateTime(new Date());
        matrixMapper.updateMatrix(matrix);
    }

    /**
     * 查询所有信息
     */
    public List<MatrixVo> queryMatrix(String page, String limit, String infoId, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "matrix_code");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("infoId", infoId);
        return matrixMapper.queryMatrix(map);

    }

    /**
     * 查询所有基地信息（树）
     */
    public List<Matrix> queryMatrixTree() {
        Map<String, Object> map = new HashMap<>();
        return matrixMapper.queryMatrixTree(map);

    }

    /**
     * （接入点新增，编辑）
     *  获取基地代码
     * 查询所有基地代码
     */
    public List<Matrix> selectList() {
        return matrixMapper.selectList();

    }
    public int countMatrix() {

        return matrixMapper.countMatrix();
    }


    /**
     * 记录条数
     *
     * @param
     * @return
     */
    public int count(String infoId) {
        return matrixMapper.count(infoId);
    }


    /**
     * 通过基地代码获取
     * 查询所有基地信息
     * 不能用vo映射
     */
    public List<Matrix> getMatrixName(String matrixCode) {
        Map<String, Object> map = new HashMap<>();
        map.put("matrixCode", matrixCode);
        return matrixMapper.getMatrixName(map);

    }

    public void removeMatrix(int matrixId) {
        matrixMapper.removeMatrix(matrixId);
    }


    /**
     * 通过基地id查询底下的工厂数
     * @param
     */
    public int countMatrixFactory(int matrixId){
        return matrixMapper.countMatrixFactory(matrixId);
    }

    /**
     * （基础数据目录树）
     * 查询出当前树节点的详细基地信息信息
     * @param
     * @return
     */
    public List<Matrix> queryMatrixNode(int nodeId) {
        return matrixMapper.queryMatrixNode(nodeId);

    }
}
