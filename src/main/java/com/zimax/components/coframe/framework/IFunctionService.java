package com.zimax.components.coframe.framework;

import com.zimax.components.coframe.framework.pojo.Function;

/**
 * 功能服务接口
 *
 * @author 苏尚文
 * @date 2022/12/7 12:00
 */
public interface IFunctionService {

    /**
     * 新增功能
     *
     * @param Function
     */
    void addFunction(Function Function);

    /**
     * 删除功能
     *
     * @param Functions
     */
    void deleteFunction(Function[] Functions);

    /**
     * 根据模板查询功能
     *
     * @param appFunction
     */
    void getFunction(Function appFunction);

    /**
     * 分页查询
     *
     * @param criteria
     * @param pageCond
     * @return
     */
//    Function[] queryFunctions(CriteriaType criteria, PageCond pageCond);

    /**
     * 修改功能
     *
     * @param appFunction
     */
    void updateFunction(Function appFunction);

    /**
     * 查询功能记录数
     *
     * @param criteria
     * @return
     */
//    int countFunction(CriteriaType criteria);

    /**
     * 根据查询条件查询功能
     *
     * @param criteria
     * @return
     */
//    Function[] queryFunctions(CriteriaType criteria);

    /**
     * 根据功能id删除功能
     *
     * @param id
     */
    void deleteFunctionById(String id);

    /**
     *
     * 初始化功能，server启动时候调用
     */
    void initFunctions();

    /**
     * 批量更新功能资源
     *
     * @param functions
     */
    void updateResoucesBatch(Function[] functions);

    /**
     * 查询所有功能
     *
     * @return 所有功能
     */
    Function[] queryAllFunctions();

    /**
     * 查询应用下所有的功能
     *
     * @param appId
     * @return
     */
    Function[] getFunctionsByAppId(String appId);

    /**
     * 查询功能组下所有的功能
     *
     * @param funcGroupIds
     * @return
     */
    Function[] getFunctionsByFuncGroupIds(String[] funcGroupIds);

    /**
     * 验证是否存在，0不存在，1存在
     *
     * @param appFunction
     * @return
     */
    int validateFunction(Function appFunction);

}