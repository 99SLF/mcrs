package com.zimax.mcrs.monitor.pojo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author 施林丰
 * @Date:2022/12/26 15:23
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class GroupByProduction {
    private String processName;
    private int total;
}
