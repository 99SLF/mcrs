package com.zimax.mcrs.version.pojo;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * 选择版本资源包
 * @author 李伟杰
 * @date 2022/12/13 17:28
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("upd_sel_res")
public class SelectResVersion {

    /**
     * 选择版本编号
     */
    @TableId(type = IdType.AUTO)
    private int selectId;

    /**
     * 资源包单号
     */
    private String resourceNumber;

    /**
     * 版本号
     */
    private String version;

    /**
     * 终端软件类型
     */
    private String deviceSoftwareType;

    /**
     * 版本上传时间
     * 即更新包上传的时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private String versionUploadTime;

    /**
     * 提交人
     */

    private String submitter;

    /**
     * 提交时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private String submitTime;
}
