package com.zimax.components.coframe.org.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author 施林丰
 * @Date:2023/2/16 9:36
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("org_emp_position")
public class EmpPosition {
    int positionId;
    int empId;
    String isMain;
    String tenantId;
    String appId;
    @TableField(exist = false)
    Position position;
    @TableField(exist = false)
    Employee employee;
}
