package com.zimax.components.coframe.org.service;

import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.cap.party.Party;
import com.zimax.components.coframe.auth.service.PartyAuthService;
import com.zimax.components.coframe.org.OrgHelper;
import com.zimax.components.coframe.org.OrgTreeNodeHelper;
import com.zimax.components.coframe.org.interfaces.IOrganizationService;
import com.zimax.components.coframe.org.mapper.OrganizationMapper;
import com.zimax.components.coframe.org.mapper.PositionMapper;
import com.zimax.components.coframe.org.pojo.Employee;
import com.zimax.components.coframe.org.pojo.OrgTreeNode;
import com.zimax.components.coframe.org.pojo.Organization;
import com.zimax.components.coframe.org.pojo.Position;
import com.zimax.components.coframe.org.pojo.vo.OrgResponse;
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
    private PositionMapper positionMapper;
    private EmployeeService employeeService;

    public EmployeeService getEmployeeService() {
        return employeeService;
    }

    public void setEmployeeService(EmployeeService employeeService) {
        this.employeeService = employeeService;
    }

    public PositionMapper getPositionMapper() {
        return positionMapper;
    }

    public void setPositionMapper(PositionMapper positionMapper) {
        this.positionMapper = positionMapper;
    }

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
            return OrgTreeNodeHelper.buidPositionTreeNodes(positions, queryPositionEmps);
        } else {
            List<Party> managedOrgList = gradeAuthService.getManagedOrgList();
            List<Party> test = new ArrayList<>();
            if (managedOrgList.size() == 0) {
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
        if (StringUtils.isBlank(String.valueOf(orgid))) {
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

    @Override
    public Employee[] queryEmployeesOfOrg(Integer orgid) {
        return new Employee[0];
    }


    public OrgResponse addOrganization(Organization org) {
        if (!validateOrgcode(org)) {
            return new OrgResponse(false, "机构代码:" + org.getOrgCode() + "已存在");
        }
        organizationMapper.insertOrganization(org);
        Organization parentOrg = org.getOrganization();
        if (parentOrg != null && parentOrg.getOrgId() != 0) {
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
        Organization[] orgs = organizationMapper.queryOrganizationsByOrgCode(org.getOrgCode());
        if (orgs == null || orgs.length == 0) {
            return true;
        }
        if (org.getOrgId() != 0 && orgs[0].getOrgId() != (org.getOrgId())) {// 修改的情况，只能为1个
            return orgs.length == 1;
        } else {// 新增,必定没有
            return orgs.length == 0;
        }
    }

    /**
     * 删除机构树
     *
     * @param
     */
    public OrgResponse deleteNodes(OrgTreeNode[] childs,String parentId,String parentType,String isDeleteCascade) {
        OrgResponse orgResponse = new OrgResponse();
        int i = 0;
        for (i = 0; i < childs.length; i++) {
            orgResponse = deleteNode(childs[i].getNodeId(), childs[i].getNodeType(), parentId, parentType, isDeleteCascade, orgResponse);
        }
        return orgResponse;
    }

    public OrgResponse deleteNode(String nodeId, String nodeType, String parentId, String parentType, String isDeleteCascade, OrgResponse orgResponse) {
        if ("Organization".equals(nodeType) && "1".equals(nodeId)) {
            orgResponse.setFlag(false);
            orgResponse.setMessage("系统机构不能删除");
        } else {
            IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
            String userId = userObject.getUserId();
            if (!"1".equals(userId) && "Organization".equals(nodeType) && "Root".equals(parentType)) {
                orgResponse.setFlag(false);
                orgResponse.setMessage("顶级机构不能删除");
            } else {
                OrgTreeNode[] childs = queryAllChildNodes(nodeId, nodeType);
                deleteNodes( childs, nodeId, nodeType, isDeleteCascade);
                deleteCurrentNode(nodeId,nodeType,parentId,parentType,isDeleteCascade);
                orgResponse.setFlag(true);
                orgResponse.setMessage("删除成功");
            }

        }
        return orgResponse;
    }

    public OrgTreeNode[] queryAllChildNodes(String nodeId, String nodeType) {
        Organization[] organizations = null;
        Position[] positions = null;
        Employee[] employees = null;
        QueryPositionEmp[] queryPositionEmp = null;
        if("Organization".equals(nodeType)){
            organizations = organizationMapper.querySubOrgs(Integer.parseInt(nodeId));
            positions = organizationMapper.queryPositionsOfOrg(Integer.parseInt(nodeId));
            employees = organizationMapper.queryEmployeesOfOrg(nodeId);
            return OrgTreeNodeHelper.buildOrgTreeNodes(organizations, positions, employees);
        }else if("Position".equals(nodeType)){
            positions = positionMapper.querySubPositions(Integer.parseInt(nodeId));
            queryPositionEmp = positionMapper.queryEmployeesOfPosition(Integer.parseInt(nodeId));
            employees = convertDataObjects(employees,queryPositionEmp);
            return OrgTreeNodeHelper.buildOrgTreeNodes(organizations, positions, employees);
        }else{
            return OrgTreeNodeHelper.buildOrgTreeNodes(organizations, positions, employees);
        }
    }

    public void deleteOrganization(Organization[] orgOrganizations) {

    }

    public void deleteOrganization(String id) {
        if (!StringUtils.isBlank(id)) {
            organizationMapper.deleteOrganization(id);
        }
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

    /**
     * 查询机构下的所有员工
     *
     * @param orgid
     * @return
     */
    public Employee[] queryEmployeesOfOrg(String orgid) {
        if (StringUtils.isBlank(orgid)) {
            return new Employee[0];
        }
       return organizationMapper.queryEmployeesOfOrg(orgid);
    }
    public Employee[] convertDataObjects(Employee[] employees,QueryPositionEmp[]queryPositionEmps){
        employees = (Employee[]) queryPositionEmps;
        return employees;
    }
    public void deleteCurrentNode(String nodeId,String nodeType,String parentId,String parentType,String isDeleteCascade ){
        if("Organization".equals(nodeType)){
            deleteOrganization(nodeId);
        }else if("Position".equals(nodeType)){
            positionMapper.deletePosition(nodeId);
        }else {
           employeeService.deleteEmployee(nodeId,parentId,parentType,isDeleteCascade);
        }
    }
}
