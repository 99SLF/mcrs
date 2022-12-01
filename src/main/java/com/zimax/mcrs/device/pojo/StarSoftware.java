package com.zimax.mcrs.device.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 软件自启动实体类
 * @author 林俊杰
 * @date 2022/12/1
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("starSoftware")
public class StarSoftware {

    /**
     * 设备编号
     */
    @TableId(type = IdType.AUTO)
    private int deviceId;

    /**
     * 设备版本号
     */
    private String deviceVersion;

    /**
     * 用户名称
     */
    private String userName;

    /**
     * 设备状态
     */
    private String deviceStatus;

    /**
     * 创建人
     */
    private String creator;

    /**
     * 创建时间
     */
    private Date createTime;

}
