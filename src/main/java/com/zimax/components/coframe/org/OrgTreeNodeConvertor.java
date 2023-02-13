//package com.zimax.components.coframe.org;
//
//import com.zimax.components.coframe.org.pojo.Employee;
//import com.zimax.components.coframe.org.pojo.OrgTreeNode;
//import com.zimax.components.coframe.org.pojo.Organization;
//import com.zimax.components.coframe.org.pojo.Position;
//import com.zimax.components.coframe.tools.IconCls;
//
///**
// * @Author 施林丰
// * @Date:2023/2/11 17:13
// * @Description
// */
//public class OrgTreeNodeConvertor {
//    public static final String NODE_ID = "nodeId";
//    public static final String NODE_TYPE = "nodeType";
//    public static final String NODE_NAME = "nodeName";
//    public static final String ICON_CLS = "iconCls";
//
//    public static OrgTreeNode[] convert(Organization[] orgs) {
//        if (orgs == null || orgs.length == 0)
//            return new OrgTreeNode[0];
//        OrgTreeNode[] nodes = new OrgTreeNode[orgs.length];
//        for (int i = 0; i < orgs.length; i++) {
//            nodes[i] = convert(orgs[i]);
//        }
//        return nodes;
//    }
//
//
//    public static OrgTreeNode[] convert(QueryPositionEmp[] posi) {
//        if (posi == null || posi.length == 0)
//            return new OrgTreeNode[0];
//        OrgTreeNode[] nodes = new OrgTreeNode[posi.length];
//        for (int i = 0; i < posi.length; i++) {
//            nodes[i] = convert(posi[i]);
//        }
//        return nodes;
//    }
//
//    public static OrgTreeNode[] convert(Position[] positions) {
//        if (positions == null || positions.length == 0)
//            return new OrgTreeNode[0];
//        OrgTreeNode[] nodes = new OrgTreeNode[positions.length];
//        for (int i = 0; i < positions.length; i++) {
//            nodes[i] = convert(positions[i]);
//        }
//        return nodes;
//    }
//
//    public static OrgTreeNode[] convert(Employee[] emps) {
//        if (emps == null || emps.length == 0)
//            return new OrgTreeNode[0];
//        OrgTreeNode[] nodes = new OrgTreeNode[emps.length];
//        for (int i = 0; i < emps.length; i++) {
//            nodes[i] = convert(emps[i]);
//        }
//        return nodes;
//    }
//
//    public static OrgTreeNode[] convert(QueryEmpOrg[] emps) {
//        if (emps == null || emps.length == 0)
//            return new OrgTreeNode[0];
//        OrgTreeNode[] nodes = new OrgTreeNode[emps.length];
//        for (int i = 0; i < emps.length; i++) {
//            nodes[i] = convert(emps[i]);
//        }
//        return nodes;
//    }
//
//    public static OrgTreeNode[] convert(QueryEmpUser[] emps) {
//        if (emps == null || emps.length == 0)
//            return new OrgTreeNode[0];
//        OrgTreeNode[] nodes = new OrgTreeNode[emps.length];
//        for (int i = 0; i < emps.length; i++) {
//            nodes[i] = convert(emps[i]);
//        }
//        return nodes;
//    }
//
//    public static OrgTreeNode convert(Organization org) {
//        OrgTreeNode node = new OrgTreeNode();
//        node.setNodeId(String.valueOf(org.getOrgId()));
//        node.setNodeType(IOrgConstants.NODE_TYPE_ORG);
//        node.setNodeName(org.getOrgName());
//        node.setIconCls(IconCls.ORGANIZATION);
//        return node;
//    }
//
//    public static OrgTreeNode convert(Group group) {
//        OrgTreeNode node = (OrgTreeNode) DataObjectUtil.convertDataObject(
//                group, OrgTreeNode.QNAME, true);
//        node.setNodeId(String.valueOf(group.getGroupId()));
//        node.setNodeType(IOrgConstants.NODE_TYPE_GROUP);
//        node.setNodeName(group.getGroupName());
//        node.setIconCls(IconCls.GROUP);
//        return node;
//    }
//
//    public static OrgTreeNode convert(Position position) {
//        OrgTreeNode node = (OrgTreeNode) DataObjectUtil.convertDataObject(
//                position, OrgTreeNode.QNAME, true);
//        node.setNodeId(String.valueOf(position.getPositionId()));
//        node.setNodeType(IOrgConstants.NODE_TYPE_ORGPOSI);
//        node.setNodeName(position.getPosiName());
//        node.setIconCls(IconCls.POSITION);
//        return node;
//    }
//
//    public static OrgTreeNode convert(Employee emp) {
//        OrgTreeNode node = (OrgTreeNode) DataObjectUtil.convertDataObject(emp,
//                OrgTreeNode.QNAME, true);
//        node.setNodeId(String.valueOf(emp.getEmpId()));
//        node.setNodeType(IOrgConstants.NODE_TYPE_ORGEMP);
//        node.setNodeName(emp.getEmpName());
//        node.setIconCls(IconCls.EMPLOYEE);
//        return node;
//    }
//
//    public static OrgTreeNode convert(QueryPositionEmp qposi) {
//        OrgTreeNode node = (OrgTreeNode) DataObjectUtil.convertDataObject(
//                qposi, OrgTreeNode.QNAME, true);
//        node.setNodeId(String.valueOf(qposi.getEmpId()));
//        node.setNodeType(IOrgConstants.NODE_TYPE_ORGEMP);
//        node.setNodeName(qposi.getEmpName());
//        node.setIconCls(IconCls.EMPLOYEE);
//        return node;
//    }
//
//    public static OrgTreeNode convert(QueryEmpUser emp) {
//        OrgTreeNode node = (OrgTreeNode) DataObjectUtil.convertDataObject(emp,
//                OrgTreeNode.QNAME, true);
//        node.setNodeId(String.valueOf(emp.getEmpId()));
//        node.setNodeType(IOrgConstants.NODE_TYPE_ORGEMP);
//        node.setNodeName(emp.getEmpName());
//        node.setIconCls(IconCls.EMPLOYEE);
//        return node;
//    }
//
//    public static OrgTreeNode convert(QueryEmpOrg emp) {
//        OrgTreeNode node = (OrgTreeNode) DataObjectUtil.convertDataObject(emp,
//                OrgTreeNode.QNAME, true);
//        node.setNodeId(String.valueOf(emp.getEmpId()));
//        node.setNodeType(IOrgConstants.NODE_TYPE_ORGEMP);
//        node.setNodeName(emp.getEmpName());
//        node.setIconCls(IconCls.EMPLOYEE);
//        return node;
//    }
//
//    public static OrgTreeNode[] convertOrgs(Organization[] orgs) {
//        if (orgs == null || orgs.length == 0)
//            return new OrgTreeNode[0];
//        List<OrgTreeNode> nodelist = new ArrayList<OrgTreeNode>();
//        for (int i = 0; i < orgs.length; i++) {
//            OrgTreeNode node = OrgTreeNode.FACTORY.create();
//            node.setNodeId(String.valueOf(orgs[i].getOrgId()));
//            node.setNodeName(orgs[i].getOrgName());
//            node.setIconCls(IconCls.ORGANIZATION);
//            node.set("parentId", orgs[i].getOrganization() == null ? null
//                    : orgs[i].getOrganization().getOrgId());
//            nodelist.add(node);
//        }
//        return nodelist.toArray(new OrgTreeNode[] {});
//    }
//}
