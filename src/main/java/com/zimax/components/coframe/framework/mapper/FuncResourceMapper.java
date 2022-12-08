package com.zimax.components.coframe.framework.mapper;

import com.zimax.components.coframe.framework.pojo.FuncResource;
import com.zimax.components.coframe.framework.pojo.Function;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @Author 施林丰
 * @Date:2022/12/7 10:31
 * @Description
 */
public interface FuncResourceMapper {
    /**
     * 查询所有的功能资源
     *
     * @return 所有的功能资源
     */
    List<FuncResource> queryAllFuncResources();

    List<FuncResource> queryFuncResources(Map map);

    void addFuncResource(FuncResource funcResource);

    void deleteFuncResources(List<Integer> resIds);

    void updateFuncResource(FuncResource funcResource);

    int count(@Param("funcCode") String funcCode);

}
