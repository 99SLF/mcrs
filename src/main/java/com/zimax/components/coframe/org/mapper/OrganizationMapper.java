package com.zimax.components.coframe.org.mapper;

import com.zimax.components.coframe.org.pojo.Organization;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @Author 施林丰
 * @Date:2023/2/9 9:40
 * @Description
 */
public interface OrganizationMapper {
    List<Organization> queryOrg(Map map);

    int count(@Param("parentOrgId") Integer parentOrgId, @Param("orgCode") String orgCode,@Param("orgType") String orgType);
}
