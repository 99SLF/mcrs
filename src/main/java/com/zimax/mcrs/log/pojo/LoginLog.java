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
@NoArgsConstructor
@AllArgsConstructor
@TableName("log_log")
public class LoginLog {

    /**
     * 日志主键
     */
    @TableId(type = IdType.AUTO)
    private int logId;

    /**
     * 日志类型
     */
    private String logType;

    /**
     * 设备主键
     */
    private int equipmentInt;

    /**
     * 终端主键
     */
    private int deviceId;

    /**
     * 来源
     */
    private String source;

    /**
     * 登录用户
     */
    private String userId;

    /**
     * 登录时间
     */
    private Date loginTime;

    /**
     * 创建时间
     */
    private Date createTime;
}
