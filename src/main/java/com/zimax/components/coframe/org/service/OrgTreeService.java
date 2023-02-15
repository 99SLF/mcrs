package com.zimax.components.coframe.org.service;

import com.zimax.components.coframe.org.interfaces.IPositionService;
import com.zimax.components.coframe.org.pojo.Position;
import com.zimax.components.coframe.org.pojo.vo.QueryPositionEmp;
import org.springframework.stereotype.Service;

/**
 * @Author 施林丰
 * @Date:2023/2/13 11:54
 * @Description
 */
@Service
public class OrgTreeService {
    private static final String EXPANDED = "expanded";

    private static final String IS_LEAF = "isLeaf";

    private IPositionService positionService;

    /**
     * 获取岗位下的所有子岗位
     *
     * @param positionid
     * @return
     */
    public Position[] querySubPositions(Integer positionid) {
        Position[] positions = positionService.querySubPositions(positionid);
        return positions;
    }
    /**
     * 获取岗位下的所有员工
     *
     * @param positionid
     * @return
     */
    public QueryPositionEmp[] queryEmployeesOfPosition(Integer positionid) {
        QueryPositionEmp[] emps = positionService.queryEmployeesOfPosition(positionid);
        return emps;
    }

}
