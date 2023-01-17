package com.zimax.mcrs.device.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 工位
 *
 * @author 林俊杰
 * @date 2023/1/16
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("eqi_work_station")
public class WorkStation {

    /**
     * 工位主键
     */
    @TableId(type = IdType.AUTO)
    private int workStationId;

    /**
     * 设备主键
     */
    private int equipmentInt;

    /**
     * 工位代码
     */
    private String workStationNum;

}
