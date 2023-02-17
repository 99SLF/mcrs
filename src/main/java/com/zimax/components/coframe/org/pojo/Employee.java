package com.zimax.components.coframe.org.pojo;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @Author 施林丰
 * @Date:2023/2/11 10:47
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("org_employee")
public class Employee {
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
}
