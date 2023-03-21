package com.zimax.mcrs.basic.warn.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

/**
 * @Author 施林丰
 * @Date:2023/3/20 17:00
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("base_warn_dealwith")
public class WarnManager {
    int id;
    String warnGrade;
    String creator;
    Date createTime;
    @TableField(exist = false)
    List<WarnDealWith> warnByUser;
}
