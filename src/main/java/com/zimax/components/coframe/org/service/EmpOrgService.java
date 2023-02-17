package com.zimax.components.coframe.org.service;

import com.zimax.components.coframe.framework.service.FuncGroupService;
import com.zimax.components.coframe.org.interfaces.IEmpOrgService;
import com.zimax.components.coframe.org.interfaces.IOrgConstants;
import com.zimax.components.coframe.org.mapper.EmpOrgMapper;
import com.zimax.components.coframe.org.pojo.EmpOrg;
import com.zimax.components.coframe.org.pojo.Employee;
import com.zimax.components.coframe.org.pojo.Organization;
import com.zimax.components.coframe.org.pojo.Position;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Author 施林丰
 * @Date:2023/2/16 9:14
 * @Description
 */
@Service
public class EmpOrgService implements IEmpOrgService {
    private EmpOrgMapper empOrgMapper;

    public EmpOrgMapper getEmpOrgMapper() {
        return empOrgMapper;
    }

    public void setEmpOrgMapper(EmpOrgMapper empOrgMapper) {
        this.empOrgMapper = empOrgMapper;
    }

    @Override
    public void addEmpOrg(EmpOrg orgEmporg) {

    }

    @Override
    public void deleteEmpOrg(EmpOrg[] orgEmporgs) {
        if (orgEmporgs == null)
            return;
        for (EmpOrg orgEmporg : orgEmporgs) {
           empOrgMapper.deleteEmpOrg(orgEmporg.getOrgId(),orgEmporg.getEmpId());
        }
    }

    @Override
    public void getEmpOrg(EmpOrg orgEmporg) {

    }

    @Override
    public void updateEmpOrg(EmpOrg orgEmporg) {

    }

    @Override
    public EmpOrg[] queryEmpOrgsByOrg(Organization org) {
        return new EmpOrg[0];
    }

    @Override
    public Employee[] queryEmpsByOrgDifferFromPosition(Organization org, Position position) {
        return new Employee[0];
    }

    @Override
    public void deleteEmporgByEmp(Employee emp) {
        EmpOrg[] empOrgs = queryEmpOrgsByEmp(emp);
        if (empOrgs != null && empOrgs.length > 0) {
            deleteEmpOrg(empOrgs);
        }
    }

    @Override
    /**
     * 根据员工查询出所有员工机构的关联关系
     *
     * @param emp
     * @return 员工机构关联关系列表
     */
    public EmpOrg[] queryEmpOrgsByEmp(Employee emp) {
        return empOrgMapper.queryEmpOrgAll(emp.getEmpId());
    }
}
