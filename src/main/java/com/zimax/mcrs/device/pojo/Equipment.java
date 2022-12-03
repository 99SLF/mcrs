package com.zimax.mcrs.device.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 设备
 * @author 林俊杰
 * @date 2022/11/28
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("cap_equipment")
public class Equipment {

    /**
     * 设备资源号
     */
    @TableId(type = IdType.AUTO)
    private String equipmentId;

    /**
     * 设备名称
     */
    private String equipmentName;

    /**
     * 是否启用状态
     */
    private String enabledState;

    /**
     * 设备类型
     */
    private String equipmentType;

    /**
     * 使用工序
     */
    private String useProcess;

    /**
     * 设备属性
     */
    private String equipmentProperties;

    /**
     * 设备Ip
     */
    private String equipmentIp;

    /**
     * 设备安装位置
     */
    private String equipmentInstallLocation;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 备注
     */
    private String remarks;

}
