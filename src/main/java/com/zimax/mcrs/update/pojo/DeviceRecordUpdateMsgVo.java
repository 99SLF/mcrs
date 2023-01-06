package com.zimax.mcrs.update.pojo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @author 李伟杰
 * @date 2023/1/2 19:54
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class DeviceRecordUpdateMsgVo {

    /**
     * 终端主键
     */
    private int deviceId;

    /**
     * 更新包管理编号
     */

    private int uploadId;

    /**
     *升级记录
     */

    private int recordUpdateId;

    /**
     * APPId
     */
    private String APPId;

    /**
     * 更新策略
     */
    private String uploadStrategy;

    /**
     * 版本号
     */
    private String version;

    /**
     * 升级状态（未升级，升级中，已升级）
     */
    private String updateStatus;

    /**
     *创建时间
     */

    private Date createTime;
    /**
     * 创建人
     */
    private String creator;
}
