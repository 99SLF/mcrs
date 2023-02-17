package com.zimax.components.coframe.org.mapper;

import com.zimax.components.coframe.org.pojo.Position;
import com.zimax.components.coframe.org.pojo.vo.QueryPositionEmp;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * @Author 施林丰
 * @Date:2023/2/13 11:19
 * @Description
 */
@Mapper
public interface PositionMapper {
    Position[] querySubPositions(@Param("manaPosi") Integer manaPosi);
    QueryPositionEmp[] queryEmployeesOfPosition(Integer positionId);
    void deletePosition(String positionid);

}
