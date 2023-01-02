package com.zimax.mcrs.update.pojo;

import lombok.Data;

/**
 * @author 李伟杰
 * @date 2023/1/2 20:43
 */
@Data
public class VersionUploadStrategyVo {

    /**
     * 版本号
     */
    private String version;

    /**
     * 更新策略
     */
    private String uploadStrategy;
}
