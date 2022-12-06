package com.zimax.mcrs.device.pojo;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 终端更新
 * @author 林俊杰
 * @date 2022/12/1
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("cap_device_update")
public class DeviceUpdate {

    /**
     * 终端更新编码
     */
    @TableId(type = IdType.AUTO)
    private int deviceUpdateId;


    /**
     * 版本号
     */
    private String deviceVersion;

    /**
     * 终端软件类型
     */
    private String deviceSoftwareType;

    /**
     * 更新策略
     */
    private String updateStrategy;

    /**
     * 上传人
     */
    private String uploadPeople;

    /**
     * 上传时间
     */
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date uploadTime;

    /**
     * 备注
     */
    private String remarks;

}
