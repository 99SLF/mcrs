package com.zimax.components.coframe.org;

import com.zimax.cap.party.Party;
import com.zimax.components.coframe.org.interfaces.IOrgConstants;
import com.zimax.components.coframe.org.interfaces.IOrganizationService;
import com.zimax.components.coframe.org.pojo.Employee;
import com.zimax.components.coframe.org.pojo.OrgTreeNode;
import com.zimax.components.coframe.org.pojo.Organization;
import com.zimax.components.coframe.org.pojo.Position;
import com.zimax.components.coframe.org.pojo.vo.QueryPositionEmp;
import com.zimax.components.coframe.tools.IconCls;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @Author 施林丰
 * @Date:2023/2/13 15:00
 * @Description
 */
public class OrgTreeNodeHelper {
    private static IOrganizationService organizationService;

    public void setOrganizationService(IOrganizationService orgService) {
        organizationService = orgService;
    }
    /**
     * 将机构、岗位、员工结点构造为treeNodes
     * @param orgs
     * @param positions
     * @param emps
     * @return
     */
    public static OrgTreeNode[] buildOrgTreeNodes(Organization[] orgs, Position[] positions, Employee[] emps) {
        List<OrgTreeNode> results = new ArrayList<OrgTreeNode>();
        results.addAll(Arrays.asList(OrgTreeNodeConvertor.convert(orgs)));
        results.addAll(Arrays.asList(OrgTreeNodeConvertor.convert(positions)));
        results.addAll(Arrays.asList(OrgTreeNodeConvertor.convert(emps)));
        return results.toArray(new OrgTreeNode[results.size()]);
    }
    public static OrgTreeNode[] buidPositionTreeNodes(Position[] positions, QueryPositionEmp[] emps){
        List<OrgTreeNode> results = new ArrayList<OrgTreeNode>();
        results.addAll(Arrays.asList(OrgTreeNodeConvertor.convert(emps)));
        results.addAll(Arrays.asList(OrgTreeNodeConvertor.convert(positions)));
        return results.toArray(new OrgTreeNode[results.size()]);
    }

    /**
     * @param orgPartyList
     * @return
     */
    public static OrgTreeNode[] buildOrgTreeNodes(List<Party> orgPartyList) {
        List<OrgTreeNode> results = new ArrayList<OrgTreeNode>();
        List<Integer> list = new ArrayList<Integer>();
        Integer[] ids = new Integer[orgPartyList.size()];
        for(Party orgParty : orgPartyList) {
            list.addAll(getListData(Integer.parseInt(orgParty.getId())));
        }
        ids = list.toArray(new Integer[0]);

        Organization[] orgs = organizationService.queryOrganizationsByIds(ids);

        for(Organization orgOrganization : orgs) {
            OrgTreeNode node = new OrgTreeNode();
            node.setNodeId(String.valueOf(orgOrganization.getOrgId()));
            node.setNodeType(IOrgConstants.NODE_TYPE_ORG);
            node.setNodeName(orgOrganization.getOrgName());
            node.setIconCls(IconCls.ORGANIZATION);
            node.setOrgId(orgOrganization.getOrgId());
            node.setOrgName(orgOrganization.getOrgName());
            if(orgOrganization.getOrganization()!= null){
                node.setPid(orgOrganization.getOrganization().getOrgId());
            } else {
                node.setPid(null);
            }
            node.setIsLeaf("false");
            node.setExpanded("false");
            results.add(node);
        }

        return results.toArray(new OrgTreeNode[results.size()]);
    }
    public static List<Integer> getListData(Integer id){
        List<Integer> list = new ArrayList<Integer>();
        Organization[] orgs = organizationService.querySubOrgs(id);
        list.add(id);
        if(orgs != null){
            for(Organization org : orgs){
                //list.add(org.getOrgid().toString());
                list.addAll(getListData(org.getOrgId()));
            }
        }
        return list;
    }
}
