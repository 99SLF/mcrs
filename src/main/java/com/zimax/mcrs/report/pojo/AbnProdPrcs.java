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
 * 生产过程异常报表
 * @author 李伟杰
 * @date 2022/12/8 18:51
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("rep_abn_prod_prcs")
public class AbnProdPrcs {

    /**
     * 生产过程异常编号
     */
    @TableId(type = IdType.AUTO)
    private int abnPPId;

    /**
     * 站点号
     */
    private String siteId;

    /**
     * 膜卷号
     */
    private String rollId;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * 轴名称
     */
    private String axisName;

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
     * 执行步骤
     */
    private String performStep;

    /**
     * 是否完工
     */
    private String isEnd;

    /**
     * 创建时间
     */
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;

    /**
     * 开始生产时间
     */
    private Date startProdTime;

    /**
     * 结束生产时间
     */
    private Date endProdTime;
}
