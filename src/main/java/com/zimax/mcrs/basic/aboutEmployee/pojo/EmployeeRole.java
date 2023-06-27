package com.zimax.mcrs.basic.aboutEmployee.pojo;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("base_role")
public class EmployeeRole {

    /**
     * 角色编号
     */
    @TableId(type = IdType.AUTO)
    private int roleId;

    /**
     * 角色代码
     */
    private String roleCode;

    /**
     * 角色名字
     */
    private String roleName;


    /**
     * 角色描述
     */
    private String roleDesc;

    /**
     * 创建人
     */
    private String creator;

    /**
     * 创建时间
     */
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date createTime;

}
