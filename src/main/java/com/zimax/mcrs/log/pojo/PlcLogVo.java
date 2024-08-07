package com.zimax.mcrs.log.pojo;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * PLC交互日志
 *
 * @author 林俊杰
 * @date 2023/1/13
 */
@Data
public class PlcLogVo {


    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * 设备名称
     */
    private String equipmentName;

    /**
     * APPID
     */
    private String APPId;

    /**
     * 终端名称
     */
    private String deviceName;

    /**
     * PLC组别名称
     */
    private String plcGroupName;

    /**
     *组别类型
     */
    private String groupType;

    /**
     * 映射地址
     */
    private String mapAddress;

    /**
     * 标签类型
     */
    private String tagName;

    /**
     * 创建人
     */
    private String createName;

    /**
     * 创建时间
     */
    private String createTime;
}
