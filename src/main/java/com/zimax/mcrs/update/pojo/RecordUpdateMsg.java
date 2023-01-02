package com.zimax.mcrs.update.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 升级记录
 * @author 李伟杰
 * @date 2022/12/13 23:40
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("upd_record")
public class RecordUpdateMsg {

    /**
     *升级记录
     */
    @TableId(type = IdType.AUTO)
    private int recordUpdateId;

    /**
     *终端的主键
     */
    private int deviceId;

    /**
     * 更新包管理编号(主键)
     */
    private int uploadId;

    /**
     *创建时间
     */

    private Date createTime;
    /**
     * 创建人
     */
    private String creator;

    /**
     * 升级状态（未升级，升级中，已升级）
     */
    private String updateStatus;
}
