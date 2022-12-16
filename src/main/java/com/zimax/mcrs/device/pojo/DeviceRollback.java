package com.zimax.mcrs.device.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 终端回退信息
 *
 * @author 林俊杰
 * @date 2022/12/13
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("dev_rollback")
public class DeviceRollback {

    /**
     * 终端回退信息主键
     */
    @TableId(type = IdType.AUTO)
    private int deviceRollbackId;

    /**
     * 设备资产主键
     */
    private int equipmentInt;

    /**
     * 终端主键
     */
    private int deviceId;

    /**
     * 更新包主键
     */
    private int uploadId;

    /**
     * 升级版本
     */
    private String upgradeVersion;

    /**
     * 升级状态
     */
    private String upgradeStatus;

    /**
     * 版本回退人
     */
    private String versionRollbackPeople;

    /**
     * 版本回退时间
     */
    private String versionRollbackTime;


}