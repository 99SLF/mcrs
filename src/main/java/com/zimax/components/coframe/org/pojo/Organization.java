package com.zimax.components.coframe.org.pojo;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @Author 施林丰
 * @Date:2023/2/9 8:46
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("org_organization")
public class Organization {
    int orgId;
    String orgCode;
    String orgName;
    Integer orgLevel;
    String orgorgDegree;
    Integer parentOrgId;
    String orgSeq;
    String orgType;
    String orgAddr;
    String zipCode;
    Integer manaPosition;
    Integer managerId;
    String orgManager;
    String linkMan;
    String linkTel;
    String email;
    String webUrll;
    Date startDate;
    Date endDate;
    String status;
    String area;
    Date createTime;
    Date lastUpdatel;
    Integer updator;
    Integer sortNo;
    String isLeaf;
    Integer subCount;
    String remark;
    String tenantId;
    String appId;

}
