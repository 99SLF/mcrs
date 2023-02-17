package com.zimax.components.coframe.org.service;

import com.zimax.components.coframe.org.interfaces.IEmpPositionService;
import com.zimax.components.coframe.org.mapper.EmpPositionMapper;
import com.zimax.components.coframe.org.pojo.EmpPosition;
import com.zimax.components.coframe.org.pojo.Employee;
import com.zimax.components.coframe.org.pojo.Position;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Author 施林丰
 * @Date:2023/2/16 9:45
 * @Description
 */
@Service
public class EmpPositionService implements IEmpPositionService {
    private EmpPositionMapper empPositionMapper;

    public EmpPositionMapper getEmpPositionMapper() {
        return empPositionMapper;
    }

    public void setEmpPositionMapper(EmpPositionMapper empPositionMapper) {
        this.empPositionMapper = empPositionMapper;
    }

    @Override
    public void deleteEmppositionsByPosition(Position position) {

    }

    @Override
    public void deleteEmppositionsByEmp(Employee emp) {
        EmpPosition[] empPositions = queryEmppositionsByEmp(emp);
        if (empPositions != null && empPositions.length > 0) {
            deleteEmpPosition(empPositions);
        }
    }

    @Override
    public Employee[] queryEmpsByPosition(Position position) {
        return new Employee[0];
    }
    public void deleteEmpPositionByEP(String empId){
        empPositionMapper.deleteEmpPositionByEmpId(empId);
    }
    /**
     * 根据员工查出所有员工岗位关联关系
     *
     * @param emp
     * @return 员工岗位关联关系列表
     */
    private EmpPosition[] queryEmppositionsByEmp(Employee emp) {
        return empPositionMapper.queryEmpPositionByEmpId(emp.getEmpId());
    }

    public void deleteEmpPosition(EmpPosition[] orgEmppositions) {
        if (orgEmppositions == null)
            return;
        for (EmpPosition orgEmpposition : orgEmppositions) {
            empPositionMapper.deleteEmpPositionByEP(orgEmpposition.getEmpId(),orgEmpposition.getPositionId());
        }
    }
}
