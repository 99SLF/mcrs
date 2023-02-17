package com.zimax.components.coframe.org.pojo;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @Author 施林丰
 * @Date:2023/2/11 10:39
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("org_position")
public class Position {
    int positionId;
    String posiCode;
    String posiName;
    Integer posiLevel;
    String positionSeq;
    String posiType;
    Date createTime;
    Date lastUpdate;
    Integer updator;
    Date startDate;
    Date endDate;
    String status;
    String isLeaf;
    Integer subCount;
    String tenantId;
    String appId;
    Integer dutyId;
    Integer orgId;
    Integer manaPosi;
}
