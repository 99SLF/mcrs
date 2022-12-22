package com.zimax.mcrs.device.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

/**
 * @Author 施林丰
 * @Date:2022/12/20 10:44
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("dev_point_dispose")
public class PointDispose {
    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    private String appId;
    /**
     * 下料执行作业
     */
    private String downWork;
    /**
     * 上料执行作业
     */
    private String upWork;
    /**
     * 上料过账模式
     */
    private String upModel;
    /**
     * 下料过账模式
     */
    private String downModel;
    /**
     * 数量单位
     */
    private String dataUnit;
    /**
     * 数据计算方法
     */
    private String dataMethod;
    /**
     * 单片机长度
     */
    private Integer chipLength;
    /**
     * 比例
     */
    private Integer scale;
    /**
     * 系数
     */
    private Integer ratio;
    /**
     * 数采检查参数
     */
    private Integer checkParam;
    /**
     * 放卷卸料设定卷径
     */
    private Integer rollDiameter;
    /**
     * 验证周期
     */
    private Integer lableCycle;
    /**
     * 监测时间
     */
    private Integer monitorDate;
    /**
     * 终端名称
     */
    private String deviceName;
    /**
     * 设备资源号
     */
    private String equipmentId;
    /**
     * 设备连接IP
     */
    private String equipmentIp;
    /**
     * 端口
     */
    private String equipmentContinuePort;
    /**
     * 接入点名称
     */
    private String equipmentName;

    /**
     * 工厂名称
     */
    private String factoryName;
    @TableField(exist = false)
    private List<PlcGroup> plcGroupList;
    @TableField(exist = false)
    private List<RfidGroup> rfidGroupList;


}
