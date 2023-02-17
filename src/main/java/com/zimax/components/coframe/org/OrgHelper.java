package com.zimax.components.coframe.org;

import com.zimax.components.coframe.org.interfaces.IOrgConstants;
import com.zimax.components.coframe.org.pojo.Organization;

import java.util.Date;

/**
 * @Author 施林丰
 * @Date:2023/2/15 9:40
 * @Description
 */
public class OrgHelper {

    public static final String POSITION_TYPE = "organization";

    /**
     * 根据父机构设置子机构部分信息：level, seq, isLeaf,subcount
     * @param org
     * @param parentOrg
     */
    public static void expandOrganizationPropertyByParent(Organization org, Organization parentOrg){
        if(org == null) return;
        if(parentOrg == null || parentOrg.getOrgId() == 0){
            org.setOrgLevel(1);
            //不存在父机构:"."+本机构ID+".";
            org.setOrgSeq("."+org.getOrgId()+".");
        }else{
            //级别在父机构的级别上增加1
            org.setOrgLevel(parentOrg.getOrgLevel()+1);
            //存在父机构:父机构顺序+本机构ID+".";
            org.setOrgSeq(parentOrg.getOrgSeq() + org.getOrgId()+".");
        }
        org.setCreateTime(new Date());
        org.setLastUpdate(new Date());
        org.setIsLeaf(IOrgConstants.IS_LEAF_YES);
        org.setSubCount(0);
    }
    /**
     * 更改父机构的信息，isLeaf,subcount
     * @param parentOrg
     */
    public static void expandParentOrganizationProperty(Organization parentOrg) {
        if(parentOrg == null || parentOrg.getOrgId() == 0){
            return ;
        }
        parentOrg.setSubCount(parentOrg.getSubCount()+1);
        parentOrg.setIsLeaf(IOrgConstants.IS_LEAF_NO);
    }
}
