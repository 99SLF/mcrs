package com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 工序信息
 * @author 李伟杰
 * @date 2022/12/19 11:33
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("base_process_info")
public class ProcessInfo {

    /**
     * 工序信息数据的主键
     */
    @TableId(type = IdType.AUTO)
    private int processId;

    /**
     * 上级id
     */

    private Integer factoryId;

    /**
     * 工序名称
     */
    private String processName;

    /**
     * 工序代号
     */
    private String processCode;

    /**
     * 工序信息描述
     */
    private String processRemarks;

    /**
     * 制单人
     */
    private String creator;


    /**
     * 制单时间
     */
    private Date createTime;

    /**
     * 修改人
     */
    private String updater;

    /**
     * 修改时间
     */
    private Date updateTime;
}
