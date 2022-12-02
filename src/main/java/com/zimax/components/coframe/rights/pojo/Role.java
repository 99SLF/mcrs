package com.zimax.components.coframe.rights.pojo;

import com.baomidou.mybatisplus.annotation.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

//import java.time.LocalDateTime;
import java.util.Date;

/**
 * 角色
 * @author 施林丰
 * @date 2022/11/28
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("cap_role")
public class Role {

    /**
     * 角色编号
     */
    @TableId(type = IdType.AUTO)
    private int roleId;

    /**
     * 角色代码
     */
    private String roleCode;

    /**
     * 角色名字
     */
    private String roleName;

    /**
     * 角色描述
     */
    private String roleDesc;

    /**
     * 创建人
     */
    private String creator;

    /**
     * 创建时间
     */
//    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date createTime;

}