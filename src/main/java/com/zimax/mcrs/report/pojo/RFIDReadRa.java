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
 * RFID读取率报表
 * @author 李伟杰
 * @date 2022/12/8 19:10
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("rep_rfid")
public class RFIDReadRa {
    
    /**
     * RFID读取编码
     */
    @TableId(type = IdType.AUTO)
    private int RFIDReadId;

    /**
     * 设备资源号
     */
    private String equipmentId;

    /**
     * RFID编码
     */
    private String RFIDId;

    /**
     * 天线ID
     */
    private String antennaId;

    /**
     * 读取率
     */
    private int readRate;

    /**
     * 记录时间
     */
//    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
//    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private String recordTime;

}
