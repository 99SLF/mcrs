package com.zimax.components.coframe.org.service;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.zimax.cap.party.Party;
import com.zimax.components.coframe.auth.service.PartyAuthService;
import com.zimax.components.coframe.framework.mapper.FuncGroupMapper;
import com.zimax.components.coframe.framework.pojo.FuncGroup;
import com.zimax.components.coframe.org.GradeAuthOrgService;
import com.zimax.components.coframe.org.OrgHelper;
import com.zimax.components.coframe.org.OrgTreeNodeConvertor;
import com.zimax.components.coframe.org.OrgTreeNodeHelper;
import com.zimax.components.coframe.org.interfaces.IOrganizationService;
import com.zimax.components.coframe.org.mapper.OrganizationMapper;
import com.zimax.components.coframe.org.pojo.Employee;
import com.zimax.components.coframe.org.pojo.OrgTreeNode;
import com.zimax.components.coframe.org.pojo.Organization;
import com.zimax.components.coframe.org.pojo.Position;
import com.zimax.components.coframe.org.pojo.vo.OrgResponse;
import com.zimax.components.coframe.org.pojo.vo.OrganizationDelVo;
import com.zimax.components.coframe.org.pojo.vo.QueryPositionEmp;
import com.zimax.components.coframe.rights.gradeauth.GradeAuthService;
import com.zimax.mcrs.config.ChangeString;

import java.util.*;

/**
 * @Author 施林丰
 * @Date:2023/2/9 9:38
 * @Description
 */
public class OrganizationService implements IOrganizationService {
    /**
     * 机构服务
     */
    private OrganizationMapper organizationMapper;
    private PartyAuthService partyAuthService;
    private OrgTreeService orgTreeService;
    private GradeAuthService gradeAuthService;
    public OrganizationMapper getOrganizationMapper() {
        return organizationMapper;
    }

    public void setOrganizationMapper(OrganizationMapper organizationMapper) {
        this.organizationMapper = organizationMapper;
    }

    public PartyAuthService getPartyAuthService() {
        return partyAuthService;
    }

    public void setPartyAuthService(PartyAuthService partyAuthService) {
        this.partyAuthService = partyAuthService;
    }

    public OrgTreeService getOrgTreeService() {
        return orgTreeService;
    }

    public void setOrgTreeService(OrgTreeService orgTreeService) {
        this.orgTreeService = orgTreeService;
    }

    public GradeAuthService getGradeAuthService() {
        return gradeAuthService;
    }

    public void setGradeAuthService(GradeAuthService gradeAuthService) {
        this.gradeAuthService = gradeAuthService;
    }

    public List<Organization> queryOrg(String page, String limit, Integer parentOrgId, String orgCode, String orgType, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "org_level");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("parentOrgId", parentOrgId);
        map.put("orgCode", orgCode);
        map.put("orgType", orgType);
        map.put("orgSeq", null);
        return organizationMapper.queryOrg(map);
    }

    /**
     * 添加筛选条件
     *
     * @return
     */
    public Organization addAuthorizedCriteria() {
        GradeAuthService bean = partyAuthService.getGradeAuthService();
        List<Party> orgList = bean.getManagedOrgList();
        if (orgList == null || orgList.size() == 0)
            return null;
        return null;
    }

    /**
     * 查询记录
     */
    public int count(Integer parentOrgId, String orgCode, String orgType) {
        return organizationMapper.count(parentOrgId, orgCode, orgType);
    }

    /**
     * 渲染机构
     */
    public OrgTreeNode[] queryTreeChildNodes(Integer nodeId, String nodeType) {
        if (nodeId != null) {
            Organization[] organizations = querySubOrgs(nodeId);
            Position[] positions = queryPositionsOfOrg(nodeId);
            Employee[] employees = queryEmployeesOfOrgNotInPosition(nodeId);
            return OrgTreeNodeHelper.buildOrgTreeNodes(organizations, positions, employees);

        } else if ("OrgPosition".equals(nodeType)) {
            Position[] positions = orgTreeService.querySubPositions(nodeId);
            QueryPositionEmp[] queryPositionEmps = orgTreeService.queryEmployeesOfPosition(nodeId);
            return OrgTreeNodeHelper.buidPositionTreeNodes(positions,queryPositionEmps);
        } else {
            List<Party> managedOrgList = gradeAuthService.getManagedOrgList();
            List<Party>test = new ArrayList<>();
            if(managedOrgList.size()==0){
                Party party = new Party();
                party.setId("1");
                party.setCode("zjhsr");
                party.setPartyTypeID("org");
                party.setName("浙江和生荣智能科技有限公司");
                test.add(party);
            }
            return OrgTreeNodeHelper.buildOrgTreeNodes(test);
        }
    }

    /**
     * 查询机构下的子机构
     *
     * @param orgid
     * @return
     */
    public Organization[] querySubOrgs(Integer orgid) {
        Organization[] organizations = organizationMapper.querySubOrgs(orgid);
        return organizations;
    }

    /**
     * 查询机构下的员工
     * （在机构的岗位下则过滤掉）
     *
     * @param orgid
     * @return
     */
    public Position[] queryPositionsOfOrg(Integer orgid) {
        if (orgid == null) {
            return new Position[0];
        }
        return organizationMapper.queryPositionsOfOrg(orgid);
    }

    /**
     * 查询机构下的岗位
     *
     * @param orgid
     * @return
     */
    public Employee[] queryEmployeesOfOrgNotInPosition(Integer orgid) {
        if (orgid == null) {
            return new Employee[0];
        }
        return organizationMapper.queryEmployeesOfOrgNotInPosition(orgid);
    }


    public OrgResponse addOrganization(Organization org) {
        if (!validateOrgcode(org)) {
            return new OrgResponse(false, "机构代码:" + org.getOrgCode() + "已存在");
        }
        organizationMapper.insertOrganization(org);
        Organization parentOrg = org.getOrganization();
        if (parentOrg != null && parentOrg.getOrgId() !=0) {
            parentOrg = getOrganization(parentOrg);
        }
        OrgHelper.expandOrganizationPropertyByParent(org, parentOrg);
        organizationMapper.updateOrganization(org);
        // 更新父机构
        if (parentOrg != null && parentOrg.getOrgId() != 0) {
            OrgHelper.expandParentOrganizationProperty(parentOrg);
            organizationMapper.updateOrganization(parentOrg);
        }
        return new OrgResponse(true, "添加成功");
    }
    /**
     * 检验机构code是否合格
     *
     * @param org
     * @return true合格，false不合格
     */
    public boolean validateOrgcode(Organization org) {
        Organization[] orgs =organizationMapper.queryOrganizationsByOrgCode(org.getOrgCode());
        if (orgs == null || orgs.length == 0) {
            return true;
        }
        if (org.getOrgId()!=0 && orgs[0].getOrgId()!=(org.getOrgId())) {// 修改的情况，只能为1个
            return orgs.length == 1;
        } else {// 新增,必定没有
            return orgs.length == 0;
        }
    }
    /**
     * 删除机构树
     *
     * @param map
     */
    public OrgResponse deleteNodes(Map map) {
        String str = (String)map.get("childs");
        Map childs = (Map) JSON.parse(str);
        int i=0;
//        for(i=0;i<childs.size();i++){
//            deleteNode(childs.get("nodeId"),hashMap.get("nodeType"),(String)map.get("parentId"),(String)map.get("parentType"),(String)map.get("isDeleteCascade"));
//        }
//        Organization [] organizations = organizationDelVo.getOrganization();
//        for(Organization organization: organizations){
//
//        }
        return null;
    }
    public void deleteNode(String nodeId,String nodeType,String parentId,String parentType,String isDeleteCascade) {

    }
    public void deleteOrganization(Organization[] orgOrganizations) {

    }

    public void deleteOrganization(String id) {

    }

    public Organization getOrganization(Organization orgOrganization) {
        return organizationMapper.queryOrganizationsByOrgId(orgOrganization.getOrgId());

    }

    public Organization[] queryOrganizationsByIds(Integer[] ids) {
        if (ids.length == 0) {
            return new Organization[0];
        }
        return organizationMapper.queryOrganizationsByIds(ids);
    }


    public Employee[] queryEmployeesOfOrg(Integer orgid) {
        return new Employee[0];
    }
}
