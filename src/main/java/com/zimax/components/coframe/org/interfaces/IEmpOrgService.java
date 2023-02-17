package com.zimax.components.coframe.org.interfaces;

import com.zimax.components.coframe.org.pojo.EmpOrg;
import com.zimax.components.coframe.org.pojo.Employee;
import com.zimax.components.coframe.org.pojo.Organization;
import com.zimax.components.coframe.org.pojo.Position;

/**
 * @Author 施林丰
 * @Date:2023/2/16 9:13
 * @Description
 */
public interface IEmpOrgService {
    /**
     *
     * @param orgEmporg
     *            EmpOrg
     */
    void addEmpOrg(EmpOrg orgEmporg);

    /**
     *
     * @param orgEmporgs
     *            EmpOrg[]
     */
    void deleteEmpOrg(EmpOrg[] orgEmporgs);

    /**
     *
     * @param orgEmporg
     *            EmpOrg[]
     */
    void getEmpOrg(EmpOrg orgEmporg);


    /**
     *
     * @param orgEmporg
     *            EmpOrg[]
     */
    void updateEmpOrg(EmpOrg orgEmporg);

    /**
     * 根据机构查询出关联的Emporg列表
     *
     * @param org
     *            机构
     * @return
     */
    EmpOrg[] queryEmpOrgsByOrg(Organization org);

    /**
     * 根据机构查询出所有人员列表
     *
     * @param org
     *            机构
     * @return 人员列表
     */
    Employee[] queryEmpsByOrgDifferFromPosition(Organization org,
                                                Position position);

    /**
     * 根据员工删除员工机构的关联关系
     *
     * @param emp
     */
    void deleteEmporgByEmp(Employee emp);

    /**
     * 根据员工查询出所有员工机构关系列表
     *
     * @param emp
     * @return
     */
    EmpOrg[] queryEmpOrgsByEmp(Employee emp);
}
