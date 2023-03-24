package com.zimax.mcrs.basic.warn.mapper;

import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.Matrix;
import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.MatrixVo;
import com.zimax.mcrs.basic.warn.pojo.WarnDealWith;
import com.zimax.mcrs.basic.warn.pojo.WarnManager;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * @Author 施林丰
 * @Date:2023/3/20 16:57
 * @Description
 */
@Mapper
public interface WarnMapper {
    /**
     * 添加预警维护信息
     */
    void addWarn(WarnManager warnManager);
    void updateWarn(WarnManager warnManager);

    /**
     * 查询信息
     */
    List<WarnManager> queryWarn(Map map);
    void addWarnToUser(WarnDealWith warnDealWith);
    int count(String warnGrade);
    int isExist(String warnGrade);
    void delWarnToUser(int warnId);
    List<WarnDealWith> queryWarnToUser(int warnId);
}
