package com.zimax.components.coframe.framework.pojo;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 角色
 * @author 施林丰
 * @date 2022/12/2
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("app_function")
public class Function {

    /**
     * 功能编码
     */
    @TableId
    private String funcCode;

    /**
     * 功能组编号
     */
    private int funcGroupId;

    /**
     * 功能名称
     */
    private String funcName;

    /**
     * 功能描述
     */
    private String funcDesc;

    /**
     * 功能URL
     */
    private String funcAction;

    /**
     * 功能参数信息
     */
    private String paraInfo;

    /**
     * 是否验证权限
     */
    private String isCheck;

    /**
     * 功能类型
     */
    private String funcType;

    /**
     * 显示顺序
     */
    private String displayOrder;

    /**
     * 是否定义为菜单
     */
    private char isMenu;

    /**
     * 应用信息
     */
    private String appInfo;

    /**
     * 租户信息
     */
    private String tenantId;

}
