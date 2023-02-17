package com.zimax.components.coframe.org.interfaces;

import com.zimax.components.coframe.org.pojo.Employee;
import com.zimax.components.coframe.org.pojo.Organization;
import com.zimax.components.coframe.org.pojo.vo.OrgResponse;
import com.zimax.components.coframe.rights.pojo.User;

/**
 * @Author 施林丰
 * @Date:2023/2/16 10:42
 * @Description
 */
public interface IEmployeeService {
    /**
     * 添加员工
     *
     * @param employee
     * @param user
     * @param org
     * @return 返回对象,标识符flag为true，添加成功，false，为添加失败；message为提示信息
     */
    OrgResponse addEmployee(Employee employee, User user,
                            Organization org);

    /**
     *
     * @param employees
     *            Employee[]
     */
    void deleteEmployee(Employee[] employees);

    /**
     * 根据id，父节点删除人员
     *
     * @param id
     * @param parentId
     * @param parentType
     */
    void deleteEmployee(String id, String parentId, String parentType,
                        String isDeleteCascade);

    /**
     * @param employee
     *            Employee[]
     */
    void getEmployee(Employee employee);



    /**
     * 更新员工
     *
     * @param employee
     * @param user
     * @return 返回状态对象
     */
    OrgResponse updateEmployee(Employee employee, User user);



    /**
     * 根据机构删除人员和机构的关联关系
     *
     * @param org
     */
    void deleteEmpAndOrgRelationship(Organization org);



}
