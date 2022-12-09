package com.zimax.mcrs.report.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * RFID读取率报表
 * @author 李伟杰
 * @date 2022/12/8 19:10
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("rep_RFID")
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
    private String readRate;

    /**
     * 记录时间
     */
    private Date recordTime;

}
