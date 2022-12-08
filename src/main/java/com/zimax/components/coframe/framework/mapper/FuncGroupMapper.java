package com.zimax.components.coframe.framework.mapper;

import com.zimax.components.coframe.framework.pojo.Application;
import com.zimax.components.coframe.framework.pojo.FuncGroup;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @Author 施林丰
 * @Date:2022/12/7 10:30
 * @Description
 */
@Mapper
public interface FuncGroupMapper {
    List<FuncGroup> queryFuncGroups(Map map);
    FuncGroup getFuncGroup(int funcGroupId);
    void addFuncGroup(FuncGroup funcGroup);
    void deleteFuncGroup(int funcGroupId);
    void deleteFunctions(List<Integer> funcGroupIds);
    int deleteFuncGroups(List<Integer> funcGroupIds);
    void updateFuncGroup(FuncGroup funcGroup);
    int count(@Param("appId") String appId);
}
