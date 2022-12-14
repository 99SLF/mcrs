package com.zimax.mcrs.update.pojo;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * @author 李伟杰
 * @date 2022/12/13 18:45
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("upd_upload")
public class UpdateUpload {

    /**
     * 更新包管理编号
     */
    @TableId(type = IdType.AUTO)
    private int uploadId;

    /**
     * 更新包单号
     */
    private String uploadNumber;

    /**
     * 是否为主版本号
     */
    private String majorVersion;

    /**
     * 版本号
     */
    private String version;

    /**
     * 终端软件类型
     */
    private String deviceSoType;

    /**
     * 更新策略
     */
    private String uploadStrategy;

    /**
     * 更新包附件（地址）
     */
    private  String uploadEnclosure;


    /**
     * 制单人（上传人）
     */
    private String uploader;

    /**
     * 制单时间
     * 版本上传时间
     * 即更新包上传的时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private String versionUploadTime;

    /**
     * 备注
     */
    private String remarks;

}
