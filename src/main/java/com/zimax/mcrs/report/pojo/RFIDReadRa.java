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
 *
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
    private int id;

    /**
     * 载具号
     */
    private String epcId;

    /**
     * 读取次数
     */
    private Integer readNum;

    /**
     * RFID读写器
     */
    private String reader;

    /**
     * -RFID天线
     */
    private String antenna;
    /**
     * 天线增益
     */
    private String dBm;


    /**
     * -RSSI
     */
    private String rssi;
    /**
     * -更新时间
     */
    private Date updatedTime;


}
