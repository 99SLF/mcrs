package com.zimax.mcrs.report.pojo;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 上料报表
 *
 * @author 李伟杰
 * @date 2022/12/8 14:25
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("rep_feeding")
public class Feeding {

    /**
     * 上料报表编号
     */
    @TableId(type = IdType.AUTO)
    private int id;

    /**
     * 工位
     */
    private String operation;

    /**
     * 设备资源号
     */
    private String resource;

    /**
     * 动作类型
     */
    private Integer actionType;

    /**
     * 上料轴
     */
    private String axis;

    /**
     * -来料SFC号
     */
    private String sfcPre;

    /**
     * 载具号
     */
    private String processLotPre;

    /**
     * 上料数量
     */
    private String qty;

    /**
     * 校验MES返回的新SFC号
     */
    private String sfc;

    /**
     * 放卷是否全部完工
     */
    private Integer isFinish;

    /**
     * 上料卷径
     */
    private String diamRealityValue;

    /**
     * -卸滚筒信息
     */
    private String downInfo;

    /**
     * 乐观锁
     */
    private String revision;

    /**
     * 创建人
     */
    private String createdBy;

    /**
     * 创建时间
     */
    private Date createdTime;

    /**
     * -更新人
     */
    private String updatedBy;

    /**
     * 更新时间
     */
    private Date updatedTime;

}
