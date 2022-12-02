package com.zimax.mcrs.log.pojo;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 接口日志
 * @author 林俊杰
 * @date 2022/12/2
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("interfaceLog")
public class InterfaceLog {

    /**
     * 接口日志Id
     */
    @TableId(type = IdType.AUTO)
    private int interfaceLogId;

    /**
     * 操作时间
     */
    private Date operationTime;

    /**
     * 接口类型
     */
    private String interfaceType;

    /**
     * 接口名称
     */
    private String interfaceName;

    /**
     * 操作人
     */
    private String operator;

    /**
     * 操作角色
     */
    private String operationRole;


}
