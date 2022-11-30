package com.zimax.mcrs.warn.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.zimax.mcrs.warn.pojo.WarningRule;
import org.apache.ibatis.annotations.Mapper;

/**
 * 预警规则操作
 */
@Mapper
public interface WarningRuleMapper extends BaseMapper<WarningRule> {
}
