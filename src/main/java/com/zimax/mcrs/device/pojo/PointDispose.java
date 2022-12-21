package com.zimax.mcrs.device.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

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
    String appId;
    /**
     * 下料执行作业
     */
    String downwork;
    /**
     * 上料执行作业
     */
    String upWork;
    /**
     * 上料过账模式
     */
        String upModel;
    /**
     * 下料过账模式
     */
    String downModel;
    /**
     * 数量单位
     */
    String dataUnit;
    /**
     * 数据计算方法
     */
    String dataMethod;
    /**
     * 单片机长度
     */
    Double chipLength;
    /**
     * 比例
     */
    Double scale;
    /**
     * 系数
     */
    Double ratio;
    /**
     * 数采检查参数
     */
    Double checkParam;
    /**
     *  放卷卸料设定卷径
     */
    Double rollDiameter;
    /**
     *  验证周期
     */
    Double lableCycle;
    /**
     * 监测时间
     */
    Data monitorDate;
    /**
     * 终端名称
     */
     String  deviceName;
    /**
     * 设备资源号
     */
    String equipmentId;
    /**
     * 设备连接IP
     */
    String equipmentIp;
    /**
     * 端口
     */
     String equipmentContinuePort;
    /**
     * 接入点名称
     */
     String equipmentName;

    /**
     * 工厂名称
     */
     String factoryName;
    @TableField(exist = false)
    PlcGroup plcGroup[];
    @TableField(exist = false)
    RfidGroup rfidGroup[];

}
