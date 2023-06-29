package com.zimax.mcrs.basic.aboutEmployee.pojo;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
@TableName("base_employee")
public class Emp {
    /**
     * 主键
     */
    private int jobId;

    /**
     * 工号
     */
    private  String jobNo;

    /**
     * 姓名
     */
    private String jobName;

    /**
     * 等级
     */
    private  int grade;

    /**
     * 创建人
     */
    private String creator;

    /**
     * 创建时间
     */
    private Date createTime;
}
