package com.zimax.mcrs.update.pojo;

import lombok.Data;

/**
 * 配置文件信息
 */
@Data
public class ConfigurationFile {

    /**
     * 主键
     */
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
