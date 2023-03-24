package com.zimax.mcrs.basic.warn.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author 施林丰
 * @Date:2023/3/20 17:54
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("base_warn_dealwith")
public class WarnDealWith {
    int id;
    int warnId;
    int roleId;
    @TableField(exist = false)
    String roleCode;
    @TableField(exist = false)
    String roleName;
    @TableField(exist = false)
    String roleDesc;
}
