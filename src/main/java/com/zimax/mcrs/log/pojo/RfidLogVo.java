package com.zimax.mcrs.log.pojo;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * RFID交互日志
 *
 * @author 林俊杰
 * @date 2023/1/13
 */
@Data
public class RfidLogVo {

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
     * RFID-ID
     */
    private String rfidId;

    /**
     * 设备连接IP
     */
    private String equipmentIp;

    /**
     * 设备连接端口
     */
    private String equipmentContinuePort;

    /**
     *参数名称
     */
    private String parameterName;

    /**
     * 参数值
     */
    private String parameterNum;

    /**
     * 创建人
     */
    private String createName;

    /**
     * 创建时间
     */
    private String createTime;

}
