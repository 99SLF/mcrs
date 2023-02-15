package com.zimax.components.coframe.org.interfaces;

/**
 * @Author 施林丰
 * @Date:2023/2/13 10:10
 * @Description
 */
public interface IOrgConstants {


    /**节点类型**/
    String NODE_TYPE_ORG = "Organization";
    String NODE_TYPE_DUTY = "Duty";
    String NODE_TYPE_ORGEMP = "Employee";
    String NODE_TYPE_ORGEMPORG = "EmpOrg";
    String NODE_TYPE_GROUP = "Group";
    String NODE_TYPE_ORGPOSI = "Position";


    /** 叶子节点 */
    String IS_LEAF_YES = "y";

    /** 不是叶子节点 */
    String IS_LEAF_NO = "n";

    /** 工作组ID标识 */
    String GROUPID_PROPERTY = "groupId";

    /** 机构ID标识 */
    String ORGID_PROPERTY = "orgId";

    /** 机构名称标识 */
    String ORGNAME_PROPERTY = "orgName";

    /** 工作组名称标识 */
    String GROUPNAME_PROPERTY = "groupName";

    /** 岗位ID标识 */
    String POSITIONID_PROPERTY = "positionId";

    /** 员工ID标识 */
    String EMPID_PROPERTY = "empId";

    /** 员工代码 */
    String EMPCODE_PROPERTY = "empCode";

    String EMP_EMAIL_PROPERTY = "oEmail";

    /** 岗位关联标识 */
    String POSITION_REF_PROPERTY = "position";

    /** 员工关联标识 */
    String EMP_REF_PROPERTY = "employee";

    /** 工作组关联标识 */
    String GROUP_REF_PROPERTY = "group";


    /** 机构关联标识 */
    String ORG_REF_PROPERTY = "organization";

    /** 主要的 */
    String IS_MAIN_YES = "y";

    /** 次要的 */
    String IS_MAIN_NO = "n";

    /** 操作员ID（用户ID） */
    String OPERATORID = "operatorId";

}
