package com.zimax.mcrs.update.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UpgradeData {

    /**
     * 是否更新:
     *  false否
     *  true是
     */
    private boolean ifUpdate;

    /**
     * 状态码：
     * 0:升级
     * 1:回退
     */
    private String updatetype;

    /**
     * 是否强制升级：
     *  false：否
     *  true：是
     */
    private String isForcedUpdate;

    /**
     * 版本号：
     */
    private String versionID;


    /**
     * 终端程序安装路径
     */
    private String programInstallationPath;

    /**
     * 终端执行程序安装路径
     */
    private String executorInstallationPath;
}
