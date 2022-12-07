package com.zimax.components.coframe.framework.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author 施林丰
 * @Date:2022/12/7 11:56
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("app_func_group")
public class FuncGroup {
    /**
     * 功能组编号
     */
    @TableId(type = IdType.AUTO)
    private int funcGroupId;

    /**
     * 应用编号
     */
    private int appId;

    /**
     * 功能组名称
     */
    private String funcGroupName;

    /**
     * 父功能组编号
     */
    private int parentFuncGroupId;

    /**
     * 功能组层次
     */
    private int groupLevel;

    /**
     * 功能组序号
     */
    private String funcGroupSeq;

    /**
     * 显示顺序
     */
    private int displayOrder;

    /**
     * 是否为叶子
     */
    private char isLeaf;

    /**
     * 叶子节点数
     */
    private int subCount;

    /**
     * 应用信息
     */
    private String appInfo;

    /**
     * 租户信息
     */
    private String tenantId;
}
