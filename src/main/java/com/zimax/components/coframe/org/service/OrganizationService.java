package com.zimax.components.coframe.org.service;

import com.zimax.cap.party.Party;
import com.zimax.components.coframe.auth.service.PartyAuthService;
import com.zimax.components.coframe.framework.mapper.FuncGroupMapper;
import com.zimax.components.coframe.framework.pojo.FuncGroup;
import com.zimax.components.coframe.org.mapper.OrganizationMapper;
import com.zimax.components.coframe.org.pojo.Organization;
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

}
