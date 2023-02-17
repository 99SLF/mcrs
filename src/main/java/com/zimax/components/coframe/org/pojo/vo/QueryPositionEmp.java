package com.zimax.components.coframe.org.pojo.vo;

import com.zimax.components.coframe.org.pojo.Employee;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @Author 施林丰
 * @Date:2023/2/13 14:39
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class QueryPositionEmp extends Employee {
    int empId;
    String empCode;
    Integer operatorId;
    String userId;
    String empName;
    String realName;
    String gender;
    String empStatus;
    Date createTime;
    String orgIdList;
    Integer orgId;
    String tenantId;
    Integer sortNo;
    Integer positionId;
}
