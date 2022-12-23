package com.zimax.mcrs.basic.matrixInfo.matrix.service;


import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfo;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfoVo;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfoVo;
import com.zimax.mcrs.basic.matrixInfo.matrix.mapper.MatrixMapper;
import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.Matrix;
import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.MatrixVo;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.serialnumber.service.SerialnumberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
        matrixMapper.addMatrix(matrix);

    }

    /**
     * 编辑
     */
    public void updateMatrix(Matrix matrix) {
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
            map.put("field", "create_time");
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
     * 记录条数
     *
     * @param
     * @return
     */
    public int count(String infoId) {
        return matrixMapper.count(infoId);
    }

}
