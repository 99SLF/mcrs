package com.zimax.mcrs.device.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 终端升级信息
 *
 * @author 林俊杰
 * @date 2022/12/13
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("dev_upgrade")
public class DeviceUpgrade {

    /**
     * 终端升级信息主键
     */
    @TableId(type = IdType.AUTO)
    private int deviceUpgradeId;

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
     * 升级前的版本
     */
    private String upgradeBeforeVersion;

    /**
     * 升级状态
     */
    private String upgradeStatus;


    /**
     * 版本更改人
     */
    private String versionUpdater;

    /**
     * 版本更改时间
     */
    private Date versionUpdateTime;


}
