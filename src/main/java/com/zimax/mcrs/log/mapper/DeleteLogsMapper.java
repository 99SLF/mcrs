package com.zimax.mcrs.log.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.Date;

/**
 * @Author 施林丰
 * @Date:2023/6/28 12:19
 * @Description
 */
@Mapper
public interface DeleteLogsMapper {
    void deleteRepBlanking(String ruleTime);
}
