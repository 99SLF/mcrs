package com.zimax.components.coframe.org.interfaces;

import com.zimax.components.coframe.org.pojo.Employee;
import com.zimax.components.coframe.org.pojo.Organization;
import com.zimax.components.coframe.org.pojo.Position;
import com.zimax.components.coframe.org.pojo.vo.OrgResponse;

/**
 * @Author 施林丰
 * @Date:2023/2/11 14:08
 * @Description
 */
public interface IOrganizationService {
    /**
     * 添加机构
     *
     * @param orgOrganization
     * @return 添加机构状态对象
     */
    OrgResponse addOrganization(Organization orgOrganization);

    /**
     *
     * @param orgOrganizations
     *            Organization[]
     */
    void deleteOrganization(Organization[] orgOrganizations);

    /**
     * 根据id删除机构
     *
     * @param id
     */
    void deleteOrganization(String id);

    /**
     *
     * @param orgOrganization
     *            Organization[]
     */
    Organization getOrganization(Organization orgOrganization);


    /**
     *
     * @param ids
     *            String[]
     * @return Organization[]
     */
    Organization[] queryOrganizationsByIds(Integer[] ids);


    /**
     * 查询机构下的所有子机构，参数orgid为空时返回顶级机构
     *
     * @param orgid
     * @return
     */
    Organization[] querySubOrgs(Integer orgid);

    /**
     * 查询机构下的所有岗位
     *
     * @param orgid
     * @return
     */
    Position[] queryPositionsOfOrg(Integer orgid);

    /**
     * 查询在机构下且未分配到此机构下级岗位的员工
     *
     * @param orgid
     * @return
     */
    Employee[] queryEmployeesOfOrgNotInPosition(Integer orgid);

    /**
     * 查询机构下的所有员工
     *
     * @param orgid
     * @return
     */
    Employee[] queryEmployeesOfOrg(Integer orgid);
}
