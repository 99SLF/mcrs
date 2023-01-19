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
@NoArgsConstructor
@AllArgsConstructor
@TableName("log_log")
public class RfidLog {

    /**
     * 日志主键
     */
    @TableId(type = IdType.AUTO)
    private int logId;

    /**
     * 日志类型
     */
    private String logType;

    /**
     * 设备主键
     */
    private int equipmentInt;

    /**
     * 终端主键
     */
    private int deviceId;

    /**
     * RFID-ID
     */
    private String rfidId;

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
    private String creator;

    /**
     * 创建时间
     */
    private Date createTime;

}
