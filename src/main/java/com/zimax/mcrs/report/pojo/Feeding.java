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
    private int feedingId;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * 轴名称
     */
    private String axisName;

    /**
     * 来料SFC编码
     */
    private String inSFCId;

    /**
     * 载具码
     */
    private String vehicleCode;

    /**
     * 生产SFC编码
     */
    private String prodSFCId;

    /**
     * 上账数量（生产数量）
     */
    private int prodNumber;

    /**
     * 创建时间
     */
//    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
//    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private String createTime;

    /**
     * 开始生产时间
     */
//    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
//    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private String startProdTime;

    /**
     * 结束生产时间
     */
//    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
//    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private String endProdTime;

}
