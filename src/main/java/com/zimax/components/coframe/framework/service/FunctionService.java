package com.zimax.components.coframe.framework.service;

import com.zimax.cap.management.resource.IManagedResource;
import com.zimax.cap.management.resource.impl.DefaultManagedResource;
import com.zimax.cap.management.resource.manager.ResourceRuntimeManager;
import com.zimax.components.coframe.framework.IFunctionService;
import com.zimax.components.coframe.framework.constants.IAppConstants;
import com.zimax.components.coframe.framework.mapper.ApplicationMapper;
import com.zimax.components.coframe.framework.mapper.FuncGroupMapper;
import com.zimax.components.coframe.framework.mapper.FuncResourceMapper;
import com.zimax.components.coframe.framework.mapper.FunctionMapper;
import com.zimax.components.coframe.framework.pojo.Application;
import com.zimax.components.coframe.framework.pojo.FuncGroup;
import com.zimax.components.coframe.framework.pojo.FuncResource;
import com.zimax.components.coframe.framework.pojo.Function;
import com.zimax.components.coframe.tools.IAuthConstants;
import org.apache.log4j.Logger;
import org.springframework.util.NumberUtils;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import com.zimax.mcrs.config.ChangeString;

import java.util.HashMap;
import java.util.Map;

/**
 * @Author 施林丰
 * @Date:2022/12/7 10:32
 * @Description
 */
public class FunctionService implements IFunctionService {

    private Logger log = Logger.getLogger(FunctionService.class);

    /**
     * 功能信息数据操作
     */
    private FuncResourceMapper funcResourceMapper;
    private FunctionMapper functionMapper;

    private FuncGroupMapper funcGroupMapper;

    private ApplicationMapper applicationMapper;

    public FunctionMapper getFunctionMapper() {
        return functionMapper;
    }

    public void setFunctionMapper(FunctionMapper functionMapper) {
        this.functionMapper = functionMapper;
    }

    public FuncGroupMapper getFuncGroupMapper() {
        return funcGroupMapper;
    }

    public void setFuncGroupMapper(FuncGroupMapper funcGroupMapper) {
        this.funcGroupMapper = funcGroupMapper;
    }

    public ApplicationMapper getApplicationMapper() {
        return applicationMapper;
    }

    public void setApplicationMapper(ApplicationMapper applicationMapper) {
        this.applicationMapper = applicationMapper;
    }
    public void setFuncResourceMapper(FuncResourceMapper funcResourceMapper) {
        this.funcResourceMapper = funcResourceMapper;
    }

    @Override
    public void getFunction(Function appFunction) {

    }

    /**
     * 添加功能信息
     * @param function 功能信息
     */
    public void addFunction(Function function) {
        functionMapper.addFunction(function);
    }
    /**
     * 更新功能信息
     * @param function 功能信息
     */
    public void updateFunction(Function function) {
       functionMapper.updateFunction(function);
    }


    public int validateFunction(Function Function) {
//        return getDASTemplate().expandEntity(Function);
        return 0;
    }


//    public int countFunction(CriteriaType criteria) {
//        criteria.set_entity(Function.QNAME);
//        IDASCriteria dasCriteria = getDASTemplate().criteriaTypeToDASCriteria(
//                criteria);
//        return getDASTemplate().count(dasCriteria);
//    }

//    public Function[] queryFunctions(CriteriaType criteria, PageCond pageCond) {
//        criteria.set_entity(Function.QNAME);
//        IDASCriteria dasCriteria = getDASTemplate().criteriaTypeToDASCriteria(
//                criteria);
//        Function[] results = getDASTemplate()
//                .queryEntitiesByCriteriaEntityWithPage(Function.class,
//                        dasCriteria, pageCond);
//        return results;
//    }

//    public Function[] queryFunctions(CriteriaType criteria) {
//        criteria.set_entity(Function.QNAME);
//        List<OrderbyType> orderbyTypes = new ArrayList<OrderbyType>();
//        OrderbyType orderbyType = OrderbyType.FACTORY.create();
//        orderbyType.set_property("displayOrder");
//        orderbyType.set_sort("asc");
//        orderbyTypes.add(orderbyType);
//        criteria.set_orderby(orderbyTypes);
//        IDASCriteria dasCriteria = getDASTemplate().criteriaTypeToDASCriteria(
//                criteria);
//        Function[] results = getDASTemplate().queryEntitiesByCriteriaEntity(
//                Function.class, dasCriteria);
//        return results;
//    }

    public void deleteFunctionById(String id) {
//        Function function = Function.FACTORY.create();
//        function.setFuncCode(id);
//        try {
//            getDASTemplate().deleteEntityCascade(function);
//            ResourceRuntimeManager.getInstance().unRegisterManagedResource(
//                    function.getFuncCode(),
//                    IAuthConstants.FUNCTION_TO_RESOURCE_TYPE);
//        } catch (Throwable t) {
//            log.error(
//                    "Delete function [funCode="
//                            + function.get("funcCode")
//                            + "] failure, please do the operation again or contact the sysadmin.",
//                    t);
//        }
    }

    @Override
    public void initFunctions() {
        Function[] functions = queryAllFunctions();
        for (Function function : functions) {
            ResourceRuntimeManager.getInstance().registerManagedResource(
                    adapt(function));
        }
    }

    public void updateResoucesBatch(Function[] functions) {
        for (Function function : functions) {
            ResourceRuntimeManager.getInstance()
                    .updateRegisteredManagedResource(adapt(function));
        }
    }

    @Override
    public Function[] queryAllFunctions() {
        List<Function> functionList = functionMapper.queryAllFunctions();
        return functionList.toArray(new Function[functionList.size()]);
    }

    @SuppressWarnings("deprecation")
    private IManagedResource adapt(Function function) {
        IManagedResource resource = new DefaultManagedResource(null,
                function.getFuncCode(), function.getFuncName(),
                IAuthConstants.FUNCTION_TO_STATES,
                IAuthConstants.FUNCTION_TO_RESOURCE_TYPE, null,
                function.getFuncDesc(), true);
        FuncGroup funcGroup = funcGroupMapper.getFuncGroup(function.getFuncGroupId());
        Application application = applicationMapper.getApplication(funcGroup.getAppId());
        if (application != null) {
            String appType = application.getAppType();
            String protocolType = application.getProtocolType();
            String ipAddr = application.getIpAddr();
            String ipPort = application.getIpPort();
            if (ipPort == null || "".equals(ipPort)) {
                ipPort = "80";
            }
            String contextPath = application.getUrl();
            if ("1".equals(appType)) {
                try {
                    URL url = new URL(protocolType, ipAddr,
                            NumberUtils.parseNumber(ipPort, Integer.class), contextPath);
                    resource.addAttribute(IAppConstants.APP_URL, url.toString());
                } catch (MalformedURLException e) {
//                    log.error(
//                            "Get Appurl [appId="
//                                    + application.getAppId()
//                                    + "] failure, please do the operation again or contact the sysadmin.",
//                            e);
                }
            }
        }
        // add app code
        resource.addAttribute(IAppConstants.APP_CODE, application.getAppCode());
        resource.addAttribute(IAppConstants.FUNCTION_IS_CHECK,
                function.getIsCheck());
        resource.addAttribute(IAppConstants.FUNCTION_PARA_INFO,
                function.getParaInfo());
        resource.addAttribute(IAppConstants.FUNCTION_URL,
                function.getFuncAction());
        return resource;
    }

    public Function[] getFunctionsByAppId(int appId) {
        List<Function> list =  functionMapper.queryFunctionsByGroupId(appId);
        Object[] objects = list.toArray();
        return (Function[]) objects;
    }

    public Function[] getFunctionsByFuncGroupIds(String[] funcGroupIds) {
//        CriteriaType criteria = CriteriaType.FACTORY.create();
//        criteria.set_entity(Function.QNAME);
//        criteria.set("_expr[1]/funcGroup.funcGroupId", funcGroupIds);
//        criteria.set("_expr[1]/_op", "in");
//        IDASCriteria dasCriteria = getDASTemplate().criteriaTypeToDASCriteria(
//                criteria);
//        Function[] results = getDASTemplate().queryEntitiesByCriteriaEntity(
//                Function.class, dasCriteria);
//        return results;
        return null;
    }

    /**
     * 查询所有功能信息
     * @param page 页码
     * @param limit 记录数
     * @param order 排序方式
     * @param field 排序字段
     * @return
     */
    public List<Function> queryFunctions(String  page, String limit, String funcGroupId, String funcCode, String funcName, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String,Object> map= new HashMap<>();
        if(order==null){
            map.put("order","asc");
            map.put("field","func_code");
        }else{
            map.put("order",order);
            map.put("field",changeString.camelUnderline(field));
        }
        if(limit!=null){
            map.put("begin",Integer.parseInt(limit)*(Integer.parseInt(page)-1));
            map.put("limit",Integer.parseInt(limit));
        }
        map.put("funcGroupId",funcGroupId);
        map.put("funcCode",funcCode);
        map.put("funcName",funcName);
        return functionMapper.queryFunctions(map);
    }

    /**
     * 根据功能编号编号删除
     * @param funcCode 功能编号
     */
    public void deleteFunction(String funcCode) {
        functionMapper.deleteFunction(funcCode);
    }

    /**
     * 根绝功能编号查询
     * @param funcCode 功能编号
     */
    public Function getFunction(String funcCode) {
        return functionMapper.getFunction(funcCode);
    }

    @Override
    public void deleteFunction(Function[] Functions) {

    }

    /**
     * 批量删除功能
     * @param funcCodes 功能编号集合
     */
    public void deleteFunctions(List<String> funcCodes) {
        if(funcCodes.size()==0)
            return;
        for(int i = 0;i<funcCodes.size();i++){
            Map<String, Object> map = new HashMap<>();
            map.put("funcCode",funcCodes.get(i));
            List<FuncResource> funcResources = funcResourceMapper.queryFuncResources(map);
            List<Integer> resIds = new ArrayList<>();
            for(FuncResource funcResource: funcResources){
                resIds.add(funcResource.getResId());
            }
            if(resIds.size()!=0){
                funcResourceMapper.deleteFuncResources(resIds);
            }
        }
        functionMapper.deleteFunctions(funcCodes);
    }

    /**
     * 查询记录
     */
    public int count(String funcCode){
        return functionMapper.count(funcCode);
    }

    /**
     * 查询所有的功能
     *
     * @return 所有的功能
     */
    public List<Function> queryAllFunctionList() {
        return functionMapper.queryAllFunctions();
    }

    public Function getFunctionsByCode(String funcCode) {
       Function function =  functionMapper.getFunction(funcCode);
       return function;
    }

}
