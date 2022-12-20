package com.zimax.mcrs.serialnumber.mapper;

import com.zimax.mcrs.serialnumber.pojo.Serialnumber;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @Author 施林丰
 * @Date:2022/12/19 15:33
 * @Description
 */
@Mapper
public interface SerialnumberMapper {
    void addSerialnumber(Serialnumber serialnumber);
    void batchDeleteSerialnumber(List<Integer> Ids);
    void updateSerialnumber (Serialnumber serialnumber);
    List<Serialnumber> querySerialnumbers(Map map);
    int count(@Param("functionName") String functionName, @Param("functionNum") String functionNum);
}
