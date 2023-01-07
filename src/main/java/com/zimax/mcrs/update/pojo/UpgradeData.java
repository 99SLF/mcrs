package com.zimax.mcrs.update.pojo;

import lombok.Data;

@Data
public class UpgradeData {

    /**
     * 状态码：
     *  101: 升级数据有误，无法进行升级
     *  102：已经升级为最新版本，无法升级
     *  103: 允许回滚
     *  104：允许升级
     *  105：升级失败
     *  106：升级成功
     */
    private String statusCode;

    /**
     * 是否升级:
     *  100否
     *  101是
     */
    private String isUpdate;

    /**
     * 是否强制升级：
     *  100：否
     *  101：是
     */
    private String isForcedUpdate;

    /**
     * 版本号：
     */
    private String versionID;





}
