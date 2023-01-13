package com.zimax.mcrs.log.pojo;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 登录日志
 *
 * @author 林俊杰
 * @date 2023/1/5
 */
@Data
public class LoginLogVo {

    /**
     * 登录日志Id
     */
    @TableId(type = IdType.AUTO)
    private int loginLogId;
    /**
     * 设备主键
     */
    private int equipmentInt;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * 终端主键
     */
    private int deviceId;

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
    private String loginUser;

    /**
     * 登录时间
     */
    private String loginTime;

    /**
     * 备注
     */
    private String remarks;

}
