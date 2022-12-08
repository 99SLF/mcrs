package com.zimax.components.coframe.framework;

import com.zimax.components.coframe.framework.pojo.FuncResource;

/**
 * 功能资源服务接口
 *
 * @author 苏尚文
 * @date 2022/12/7 15:32
 */
public interface IFuncResourceService {

    /**
     *
     * 初始化功能资源，server启动时候调用
     */
    void initFuncResources();

    /**
     * 查询所有功能资源
     *
     * @return
     */
    FuncResource[] queryAllFuncResources();

    void addFuncResource(FuncResource funcResource);

    void deleteFuncResource(FuncResource[] funcResources);

    void deleteFuncResourceByFuncCode(String funccode);

    void getFuncResource(FuncResource funcResource);

//    FuncResource[] queryFuncResources(CriteriaType criteriaType,
//                                      PageCond pageCond);

//    FuncResource[] queryFuncResources(CriteriaType criteriaType);

    void updateFuncResource(FuncResource funcResource);

//    int countFuncResource(CriteriaType criteria);

    void getPrimaryKey(FuncResource funcResource);

}
