package com.zimax.components.coframe.org.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

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
    String orgDegree;
    Integer parentOrgId;
    String orgSeq;
    String orgType;
    String status;
    Date createTime;
    Date lastUpdate;
    Integer sortNo;
    String isLeaf;
    Integer subCount;
    String remark;
    String tenantId;
    @TableField(exist = false)
    Organization organization;//父节点
}
