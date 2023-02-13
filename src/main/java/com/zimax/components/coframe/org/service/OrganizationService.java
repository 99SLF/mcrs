package com.zimax.components.coframe.org.service;

import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.zimax.cap.party.Party;
import com.zimax.components.coframe.auth.service.PartyAuthService;
import com.zimax.components.coframe.framework.mapper.FuncGroupMapper;
import com.zimax.components.coframe.framework.pojo.FuncGroup;
import com.zimax.components.coframe.org.mapper.OrganizationMapper;
import com.zimax.components.coframe.org.pojo.Employee;
import com.zimax.components.coframe.org.pojo.Organization;
import com.zimax.components.coframe.org.pojo.Position;
import com.zimax.components.coframe.rights.gradeauth.GradeAuthService;
import com.zimax.mcrs.config.ChangeString;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author 施林丰
 * @Date:2023/2/9 9:38
 * @Description
 */
@Service
public class OrganizationService {
    /**
     * 机构服务
     */
    @Autowired
    private OrganizationMapper organizationMapper;
    @Autowired
    private PartyAuthService partyAuthService;
    public List<Organization> queryOrg(String page, String limit, Integer parentOrgId, String orgCode, String orgType,String order, String field) {
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
        return organizationMapper.count(parentOrgId,orgCode,orgType);
    }

    /**
     * 渲染机构
     */
    public void queryTreeChildNodes(Integer nodeId, String nodeType) {
        if(nodeId!=null){
            Organization[] organizations = querySubOrgs(nodeId);
            Position[] positions = queryPositionsOfOrg(nodeId);
            Employee[]  employees = queryEmployeesOfOrgNotInPosition(nodeId);


        }else if("OrgPosition".equals(nodeType)){

        }else{

        }
    }

    /**
     * 查询机构下的子机构
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
     * @param orgid
     * @return
     */
    public Position[] queryPositionsOfOrg(Integer orgid) {
        if (orgid==null) {
            return new Position[0];
        }
        return organizationMapper.queryPositionsOfOrg(orgid);
    }

    /**
     * 查询机构下的岗位
     * @param orgid
     * @return
     */
    public Employee[] queryEmployeesOfOrgNotInPosition(Integer orgid) {
        if (orgid==null) {
            return new Employee[0];
        }
        return organizationMapper.queryEmployeesOfOrgNotInPosition(orgid);
    }
    public void buildOrgTreeNodes(Integer orgid) {

    }

}
