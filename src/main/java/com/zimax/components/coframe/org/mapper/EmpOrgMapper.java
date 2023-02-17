package com.zimax.components.coframe.org.mapper;

import com.zimax.components.coframe.org.pojo.EmpOrg;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

/**
 * @Author 施林丰
 * @Date:2023/2/16 9:24
 * @Description
 */
@Mapper
public interface EmpOrgMapper {
    void deleteEmpOrg(@Param("orgId") int orgId, @Param("empId") int empId);
    EmpOrg[] queryEmpOrgAll(int empId);
}
