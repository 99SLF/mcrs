package com.zimax.mcrs.warn.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.zimax.mcrs.warn.pojo.WarningMessage;
import org.apache.ibatis.annotations.Mapper;

/**
 * 预警信息操作
 */
@Mapper
public interface WarningMessageMapper extends BaseMapper<WarningMessage>{
}
