package com.zimax.components.coframe.framework.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;

/**
 * @Author 施林丰
 * @Date:2022/12/7 11:57
 * @Description
 */
public class FuncResource {
    /**
     * 资源编号
     */
    @TableId(type = IdType.AUTO)
    private int resId;

    /**
     * 功能编码
     */
    private String funcCode;

    /**
     * 资源类型
     */
    private String resType;

    /**
     * 资源路径
     */
    private String resPath;

    /**
     * 所属构件包
     */
    private String comPackName;

    /**
     * 资源名称
     */
    private String resName;

    /**
     * 应用信息
     */
    private String appInfo;

    /**
     * 租户信息
     */
    private String tenantId;
}
