package com.zimax.mcrs.monitor.pojo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author 施林丰
 * @Date:2023/1/4 17:14
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class WarnTotalInfo {
    Integer warnTotal;
    Integer hardWarn;
    Integer activeWarn;
}
