package com.zimax.components.coframe.org.mapper;

import com.zimax.components.coframe.org.pojo.Employee;
import com.zimax.components.coframe.org.pojo.Organization;
import com.zimax.components.coframe.org.pojo.Position;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @Author 施林丰
 * @Date:2023/2/9 9:40
 * @Description
 */
@Mapper
public interface OrganizationMapper {
    List<Organization> queryOrg(Map map);
    Organization[] querySubOrgs(@Param("parentOrgId") Integer parentOrgId);
    int count(@Param("parentOrgId") Integer parentOrgId, @Param("orgCode") String orgCode,@Param("orgType") String orgType);
    Position[] queryPositionsOfOrg(@Param("orgId") Integer orgId);
    Employee[] queryEmployeesOfOrgNotInPosition(@Param("orgId") Integer orgId);
    Organization[] queryOrganizationsByIds(@Param("ids") Integer[] ids);
    Organization[] queryOrganizationsByOrgCode(String orgCode);
    Organization queryOrganizationsByOrgId(int orgId);
    void insertOrganization(Organization organization);
    void updateOrganization(Organization organization);
}
