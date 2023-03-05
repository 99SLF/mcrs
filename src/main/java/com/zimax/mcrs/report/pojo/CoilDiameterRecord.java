package com.zimax.mcrs.report.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 上下料卷径记录表
 *
 * @Author 施林丰
 * @Date:2023/3/4 11:10
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("rep_coilDiameterRecord")
public class CoilDiameterRecord {
    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    private int id;

    /**
     * 设备资源号
     */
    private String resource;

    /**
     * -放卷SFC
     */
    private String sfcPreData;

    /**
     * 放卷卷径
     */
    private String uDiamRealityValue;

    /**
     * 收卷轴名称
     */
    private String rAxisName;

    /**
     * -收卷载具号
     */
    private String rProcessLotPre;

    /**
     * 收卷SFC
     */
    private String sfcData;
    /**
     * 收卷卷径
     */
    private String rDiamRealityValue ;

    /**
     * 是否最后一卷
     */
    private Integer isLastVolume;


    /**
     * 放卷物料是否消耗完成，0：否，1：是
     */
    private Integer unwindIsOver;

    /**
     * 放卷异常信息记录
     */
    private String remark;

    /**
     * 更新时间
     */
    private Date updatedTime;
}
