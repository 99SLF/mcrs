package com.zimax.mcrs.device.pojo;

import lombok.Data;

import java.util.Date;

/**
 * @author 李伟杰
 * @date 2023/1/6 19:48
 */
@Data
public class DeviceUploadUpgradeVo {

    /**
     * 终端主键
     */
    private int deviceId;

    /**
     * 更新包主键
     */
    private int uploadId;


    /**
     * 终端升级信息主键
     */

    private int deviceUpgradeId;

    /**
     * 设备资产主键
     */
    private int equipmentInt;

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
