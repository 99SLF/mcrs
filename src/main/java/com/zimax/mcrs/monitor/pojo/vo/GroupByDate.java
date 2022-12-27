package com.zimax.mcrs.monitor.pojo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @Author 施林丰
 * @Date:2022/12/26 16:07
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class GroupByDate {
    Date recordDate;
    int activeWarn;
    int hardWarn;
}
