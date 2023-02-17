package com.zimax.components.coframe.org.interfaces;

import com.zimax.components.coframe.org.pojo.Employee;
import com.zimax.components.coframe.org.pojo.Position;

/**
 * 岗位和人员的关系服务类
 * @Author 施林丰
 * @Date:2023/2/13 12:15
 * @Description
 */
public interface IEmpPositionService {
    /**
     *
     * @param orgEmpposition
     *            EmpPosition
     */
   /// void addEmpPosition(EmpPosition orgEmpposition);

    /**
     * @param orgEmppositions
     */
    //void addEmpPosition(EmpPosition[] orgEmppositions);

    /**
     *
     * @param orgEmppositions
     *            EmpPosition[]
     */
   // void deleteEmpPosition(EmpPosition[] orgEmppositions);

    /**
     *
     * @param orgEmpposition
     *            EmpPosition[]
     */
    //void getEmpPosition(EmpPosition orgEmpposition);

    /**
     *
     * @param criteria
     *            CriteriaType
     * @param page
     *            PageCond
     * @return EmpPosition[]
     */
    //EmpPosition[] queryEmpPositions(CriteriaType criteriaType, PageCond pageCond);

    /**
     *
     * @param orgEmpposition
     *            EmpPosition[]
     */
    //void updateEmpPosition(EmpPosition orgEmpposition);

    /**
     * 根据岗位删除岗位关联的人员关系
     *
     * @param position
     *            岗位
     */
    void deleteEmppositionsByPosition(Position position);

    /**
     * 根据员工删除员工关联的岗位关系
     *
     * @param emp
     */
    void deleteEmppositionsByEmp(Employee emp);

    /**
     * 根据员工ID和父机构ID，查询出子岗位与员工的关系
     *
     * @param empId
     *            员工ID
     * @param parentOrgId
     *            父机构ID
     * @return
     */
    //EmpPosition[] queryEmpPositionsOfEmp(String empId, String parentOrgId);

    /**
     * 根据岗位查询所有的人员列表
     *
     * @param position
     * @return 人员列表
     */
    Employee[] queryEmpsByPosition(Position position);
}
