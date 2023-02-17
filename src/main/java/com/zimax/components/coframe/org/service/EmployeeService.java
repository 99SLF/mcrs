package com.zimax.components.coframe.org.service;

import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.zimax.components.coframe.org.interfaces.IEmployeeService;
import com.zimax.components.coframe.org.interfaces.IOrgConstants;
import com.zimax.components.coframe.org.mapper.EmployeeMapper;
import com.zimax.components.coframe.org.pojo.*;
import com.zimax.components.coframe.org.pojo.vo.OrgResponse;
import com.zimax.components.coframe.rights.pojo.User;
import com.zimax.components.coframe.rights.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Author 施林丰
 * @Date:2023/2/16 12:07
 * @Description
 */
@Service
public class EmployeeService implements IEmployeeService {
    private EmployeeMapper employeeMapper;
    private EmpOrgService empOrgService;
    private EmpPositionService empPositionService;
    private UserService userService;

    public UserService getUserService() {
        return userService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public EmpPositionService getEmpPositionService() {
        return empPositionService;
    }

    public void setEmpPositionService(EmpPositionService empPositionService) {
        this.empPositionService = empPositionService;
    }

    public EmployeeMapper getEmployeeMapper() {
        return employeeMapper;
    }

    public void setEmployeeMapper(EmployeeMapper employeeMapper) {
        this.employeeMapper = employeeMapper;
    }

    public EmpOrgService getEmpOrgService() {
        return empOrgService;
    }

    public void setEmpOrgService(EmpOrgService empOrgService) {
        this.empOrgService = empOrgService;
    }


    public void deleteEmployee(String id, String parentId,
                               String parentType, String isDeleteUserCascade) {
        if (StringUtils.isBlank(parentType))
            return;
        Employee empWillBeDelete = new Employee();
        empWillBeDelete.setEmpId(Integer.parseInt(id));
        if ("true".equals(isDeleteUserCascade)) {
            getEmployee(empWillBeDelete);
        }
        if (IOrgConstants.NODE_TYPE_ORG.equals(parentType)) {// 父节点是机构
            if ("true".equals(isDeleteUserCascade)) {
                // 删除机构和人员的关系
                EmpOrg empOrgAssosiation = new EmpOrg();
                empOrgAssosiation.setOrgId(Integer.parseInt(parentId));
                empOrgAssosiation.setEmployee(empWillBeDelete);
                empOrgService.deleteEmpOrg(new EmpOrg[] { empOrgAssosiation });
                // 删除人员与岗位的关系
                empPositionService.deleteEmpPositionByEP(id);
            }
            // 判断人员是否在其他机构下，如果不在，则删除这个员工
            EmpOrg[] existsEmpOrgAssosiations = empOrgService
                    .queryEmpOrgsByEmp(empWillBeDelete);
            if ("true".equals(isDeleteUserCascade)) {
                if (existsEmpOrgAssosiations.length == 0) {
                    deleteEmployee(new Employee[] { empWillBeDelete });
                }
            }else if("false".equals(isDeleteUserCascade)){
                if (existsEmpOrgAssosiations.length == 1) {
                    deleteEmployee(new Employee[] { empWillBeDelete });
                }
            }

        } else if (IOrgConstants.NODE_TYPE_ORGPOSI.equals(parentType)) {// 父节点是岗位
            // 直接删除人员和岗位的关联关系
            EmpPosition empPositionAssosiation = new EmpPosition();
            Position position = new Position();
            position.setPositionId(Integer.parseInt(parentId));
            empPositionAssosiation.setEmployee(empWillBeDelete);
            empPositionAssosiation.setPosition(position);
            empPositionService.deleteEmpPosition(new EmpPosition[] { empPositionAssosiation });
        }
        User capUser = new User();
        if(!StringUtils.isBlank(empWillBeDelete.getUserId())){
            capUser.setUserId(empWillBeDelete.getUserId());
            capUser = userService.getUserByUserId(capUser.getUserId());
            if (capUser.getUserId() != null) {
                userService.deleteUser(capUser.getOperatorId());
            }
        }

    }


    public OrgResponse addEmployee(Employee employee, User user, Organization org) {
        return null;
    }

    public void deleteEmployee(Employee[] emps) {
        if (emps == null)
            return;
            for (Employee emp : emps) {
                empPositionService.deleteEmppositionsByEmp(emp);
                empOrgService.deleteEmporgByEmp(emp);
        }
    }

    public void getEmployee(Employee emp) {
        employeeMapper.expandEntity(emp.getEmpId());
    }

    public OrgResponse updateEmployee(Employee employee, User user) {
        return null;
    }


    public void deleteEmpAndOrgRelationship(Organization org) {

    }
}
