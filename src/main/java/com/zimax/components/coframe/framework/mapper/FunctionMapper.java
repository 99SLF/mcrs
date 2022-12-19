package com.zimax.components.coframe.framework.mapper;

import com.zimax.components.coframe.framework.pojo.FuncGroup;
import com.zimax.components.coframe.framework.pojo.Function;
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
public interface FunctionMapper {

    /**
     * 获取功能
     *
     * @param funcCode 功能编码
     * @return 功能
     */
    Function getFunction(String funcCode);

    /**
     * 查询所有的功能
     *
     * @return 所有的功能
     */
    List<Function> queryAllFunctions();

    List<Function> queryAllFunctionsBylike(Map map);

    List<Function> queryFunctions(Map map);

    Function[] queryFunctionsByGroupId(int funcGroupId);

    Function[] getFunctionsByFuncGroupId(int funcGroupId);

    void addFunction(Function function);

    void deleteFunction(String funcCode);

    void deleteFunctions(List<String> funcCodes);

    void updateFunction(Function function);

    int count(@Param("funcGroupId") String funcGroupId, @Param("isMenu") String isMenu);
}
