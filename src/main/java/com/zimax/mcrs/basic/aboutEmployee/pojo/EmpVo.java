package com.zimax.mcrs.basic.aboutEmployee.pojo;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
public class EmpVo {
    /**
     * 主键
     */
    private int jobId;

    /**
     * 工号
     */
    private  String jobNo;

    /**
     * 等级
     */
    private  int grade;

    /**
     * 创建人
     */
    private String creator;

    /**
     * 角色id
     */
    private int roleId;

    /**
     * 角色名字
     */
    private String roleName;

    /**
     * 角色名称集合
     */
    private String roleNameList;

    /**
     * 创建人姓名
     */
    private String userName;

    /**
     * 创建时间
     */
    private String createTime;
}
