package com.zimax.mcrs.update.pojo;

import lombok.Data;

import java.util.Date;

/**
 * @author 李伟杰
 * @date 2023/1/2 19:54
 */
@Data
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
     * APPId
     */
    private String APPId;

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
