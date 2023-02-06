package com.zimax.mcrs.monitor.pojo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author 施林丰
 * @Date:2023/2/2 16:32
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProcessOnfactory {
    private int factoryId;
    private String factoryName;
    private String processName;
    private int total;
    private int processId;
}
