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
     * 下料轴
     */
    private String axis;

    /**
     * -来料SFC号
     */
    private String sfcpre;

    /**
     * 载具号
     */
    private String processLot;

    /**
     * EA数
     */
    private String qty;

    /**
     * 下料绑定的SFC编码
     */
    private String sfc;

    /**
     * 收卷米数
     */
    private String metre ;

    /**
     * 上料卷径
     */
    private String diamRealityValue ;


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
