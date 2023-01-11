package com.zimax.mcrs.device.pojo;


import lombok.Data;

import java.util.Date;

/**
 * @author 李伟杰
 * @date 2023/1/10 21:59
 */
@Data
public class DeviceUploadRollbackVo {

    /**
     * 终端回退信息主键
     */
    private int deviceRollbackId;

    /**
     * 设备主键
     */

    private int equipmentInt;

    /**
     * 终端主键
     */

    private int deviceId;

    /**
     * 更新包管理编号
     */

    private int uploadId;

    /**
     * 回退前版本
     */
    private String rollbackBeforeVersion;


    /**
     * 回退状态
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
