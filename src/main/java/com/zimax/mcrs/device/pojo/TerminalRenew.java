package com.zimax.mcrs.device.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 终端更新
 * @author 林俊杰
 * @date 2022/12/1
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("terminalRenew")
public class TerminalRenew {

    /**
     * 终端更新编码
     */
    @TableId(type = IdType.AUTO)
    private int terminalRenewId;

    /**
     * 客户端地址
     */
    private String clientAddress;

    /**
     * 服务器地址
     */
    private String serverAddress;

    /**
     * 文件是否重名
     */
    private String repeatName;

    /**
     * 适用范围
     */
    private String scopeApplication;

    /**
     * APPId
     */
    private int APPId;

    /**
     * 版本号
     */
    private String deviceVersion;

    /**
     * 更新信息
     */
    private String renewText;

    /**
     * 更新人
     */
    private String renewPeople;

    /**
     * 更新时间
     */
    private Date renewTime;

    /**
     * 备注
     */
    private String remarks;

}
