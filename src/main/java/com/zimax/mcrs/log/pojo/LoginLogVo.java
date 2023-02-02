package com.zimax.mcrs.log.pojo;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;


/**
 * 登录日志
 *
 * @author 林俊杰
 * @date 2023/1/5
 */
@Data
public class LoginLogVo {

    /**
     * 日志Id
     */
    @TableId(type = IdType.AUTO)
    private int logId;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * 设备资源号
     */
    private String equipmentName;

    /**
     * APPId
     */
    private String APPId;

    /**
     * 来源
     */
    private String source;

    /**
     * 登录用户
     */
    @TableField(exist = false)
    private String loginUserName;

    /**
     * 登录时间
     */
    private String loginTime;

}
