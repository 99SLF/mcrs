package com.zimax.components.coframe.org.mapper;

import com.zimax.components.coframe.org.pojo.EmpPosition;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * @Author 施林丰
 * @Date:2023/2/16 9:47
 * @Description
 */
@Mapper
public interface EmpPositionMapper {
    void deleteEmpPositionByEmpId(String empId);
    void deleteEmpPositionByEP(@Param("empId") int empId, @Param("positionId") int positionId );
    EmpPosition[] queryEmpPositionByEmpId(int empId);
}
