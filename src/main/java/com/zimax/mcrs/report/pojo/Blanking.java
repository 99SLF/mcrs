package com.zimax.mcrs.report.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 下料报表
 * @author 李伟杰
 * @date 2022/12/8 18:28
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("rep_blanking")
public class Blanking {

    /**
     * 下料报表编号
     */
    @TableId(type = IdType.AUTO)
    private int blankingId;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * 轴名称
     */
    private String axisName;

    /**
     * 天线位置
     */
    private String antennaLoc;

    /**
     * 载具码
     */
    private String vehicleCode;

    /**
     * 生产SFC编码
     */
    private String prodSFCId;

    /**
     * 完工EA数量
     */
    private int endEANumber;

    /**
     * 收米卷数
     */
    private int inRiceNumber;

    /**
     * 是否完工
     */
    private String isEnd;

    /**
     * 开始生产时间
     */
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date startProdTime;

    /**
     * 结束生产时间
     */
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date endProdTime;

}
