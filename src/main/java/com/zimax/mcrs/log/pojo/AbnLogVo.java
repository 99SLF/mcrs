package com.zimax.mcrs.log.pojo;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;


/**
 * 异常日志
 *
 * @author 林俊杰
 * @date 2023/1/4
 */
@Data
public class AbnLogVo {



    /**
     * 设备资源号
     */
    private String equipmentId;


    /**
     * 设备名称
     */
    private String equipmentName;

    /**
     * APPId
     */
    private String APPId;

    /**
     * 终端名称
     */
    private String deviceName;

    /**
     * 预警标题
     */
    private String abnTitle;

    /**
     * 预警类型
     */
    private String abnType;

    /**
     * 预警等级
     */
    private String abnLevel;

    /**
     * 预警内容
     */
    private String abnContent;

    /**
     *交互时间
     */
    private String equipmentExchangeTime;


}
