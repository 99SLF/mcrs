package com.zimax.mcrs.update.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 配置文件信息
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("dev_config_file")
public class ConfigurationFile {

    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    private  Integer fileId;

    /**
     * 文件名
     */
    private String fileName;

    /**
     * 获取路径
     */
    private String filePath;

    /**
     * 配置文件路径
     */
    private String configPath;

    /**
     * 配置文件状态
     */
    private String fileStatus;

    /**
     * 配置人
     */
    private String creator;

    /**
     * 终端修改时间
     */
    private String terminalTime;

    /**
     * WEB修改时间
     */
    private String webTime;

    /**
     * APPID
     */
    private String appId;
}
