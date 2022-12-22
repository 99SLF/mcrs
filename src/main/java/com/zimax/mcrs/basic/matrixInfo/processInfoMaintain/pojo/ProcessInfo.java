package com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 工序信息
 * @author 李伟杰
 * @date 2022/12/19 11:33
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("bas_process_info")
public class ProcessInfo {

    /**
     * 工序信息数据的主键
     */
    @TableId(type = IdType.AUTO)
    private int processId;

    /**
     * 树id
     */
    private String infoId;

    /**
     * 工序名称
     */
    private String processName;

    /**
     * 工序代号
     */
    private String processCode;

    /**
     * 工序是否启用
     */
    private String processEnable;

    /**
     * 工序信息描述
     */
    private String processRemarks;
}
