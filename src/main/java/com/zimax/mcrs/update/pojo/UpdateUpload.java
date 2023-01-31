package com.zimax.mcrs.update.pojo;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 更新包管理
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
     * 更新包文件名
     */
    private  String fileName;


    /**
     * 制单人（上传人）
     */
    private String uploader;

    /**
     * 制单时间
     * 版本上传时间
     * 即更新包上传的时间
     */
//    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
//    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
//    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date versionUploadTime;

    /**
     * 备注
     */
    private String remarks;

    /**
     * 是否为主版本号
     */
    private String majorVersion;

    /**
     *  存放路径
     */
    private String downloadUrl;


    /**
     *  资源文件生成的uuid
     */
    private  String uploadUuid;

//    /**
//     *  资源文件原始名称
//     */
//    private String OriginalFilename;

    /**
     *  文件大大小
     */
    private  double  uploadFileSize;

    /**
     *  文件类型
     */

    private  String  uploadFileType;

    /**
     *
     * uui前缀和文件名(用户下载截取，获取文件名，或其他字段)
     */
    private  String  uuidFile;

    /**
     * 修改人
     */
    private String updater;

    /**
     * 修改时间
     */
    private Date versionUpdateTime;

    /**
     * 上传人
     */
    @TableField(exist = false)
    private String uplName;


}
