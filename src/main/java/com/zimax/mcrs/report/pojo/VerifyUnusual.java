package com.zimax.mcrs.report.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 防止串读记录表
 *
 * @Author 施林丰
 * @Date:2023/3/4 11:13
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("rep_verifyUnusual")
public class VerifyUnusual {
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
     * -轴名称
     */
    private String axisName;

    /**
     * 读写器ID
     */
    private String rfidReader;

    /**
     * 天线
     */
    private Integer antenna;

    /**
     * -已读取标签值
     */
    private String processLot;

    /**
     * 替换的标签值
     */
    private String tag;

    /**
     * 读取到的次数
     */
    private Integer readNum;

    /**
     * 生产SFC
     */
    private String sfcPre;

    /**
     * 拆分后SFC
     */
    private String sfc;


    /**
     * 更新时间
     */
    private Date updatedTime;
}
