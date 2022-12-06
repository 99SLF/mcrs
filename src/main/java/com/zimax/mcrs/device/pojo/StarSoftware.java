package com.zimax.mcrs.device.pojo;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 软件自启动实体类
 * @author 林俊杰
 * @date 2022/12/1
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("cap_starSoftware")
public class StarSoftware {

    /**
     * 设备资源号
     */
    @TableId(type = IdType.AUTO)
    private int equipmentId;

    /**
     * 设备版本号
     */
    private String equipmentVersion;

    /**
     * 用户名称
     */
    private String userName;

    /**
     * 设备状态
     */
    private String equipmentStatus;

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
