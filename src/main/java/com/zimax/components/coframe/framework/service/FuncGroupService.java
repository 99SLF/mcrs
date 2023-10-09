package com.zimax.components.coframe.framework.service;

import com.zimax.components.coframe.framework.IFunctionService;
import com.zimax.components.coframe.framework.mapper.FuncGroupMapper;
import com.zimax.components.coframe.framework.mapper.FunctionMapper;
import com.zimax.components.coframe.framework.pojo.FuncGroup;
import com.zimax.components.coframe.framework.pojo.FuncResource;
import com.zimax.components.coframe.framework.pojo.Function;
import com.zimax.components.coframe.tools.service.ApplicationUtil;
import com.zimax.mcrs.config.ChangeString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author 施林丰
 * @Date:2022/12/7 10:33
 * @Description
 */
@Service
public class FuncGroupService {
    /**
     * 功能组数据操作
     */
    @Autowired
    private FuncGroupMapper funcGroupMapper;
    @Autowired
    private FunctionService functionService;

    public FuncGroupMapper getFuncGroupMapper() {
        return funcGroupMapper;
    }

    /**
     * 查询所有功能组信息
     *
     * @param page  页码
     * @param limit 记录数
     * @param order 排序方式
     * @param field 排序字段
     * @return
     */
    public List<FuncGroup> queryFuncGroups(String page, String limit, String appId, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "display_order");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("appId", appId);
        return funcGroupMapper.queryFuncGroups(map);
    }

    /**
     * 添加功能组信息
     *
     * @param funcGroup 应用
     */
    public void addFuncGroup(FuncGroup funcGroup) {
        funcGroup.setGroupLevel(1);
        funcGroup.setIsLeaf('n');
        funcGroup.setSubCount(0);
        funcGroupMapper.addFuncGroup(funcGroup);
        funcGroup.setFuncGroupSeq("." + funcGroup.getFuncGroupId() + ".");
        funcGroupMapper.updateFuncGroup(funcGroup);
    }

    /**
     * 根据功能组编号删除
     *
     * @param funcGroupId 功能组编号
     */
    public void deletefuncGroup(int funcGroupId) {
        funcGroupMapper.deleteFuncGroup(funcGroupId);
    }

    /**
     * 更新应用
     *
     * @param funcGroup 应用信息
     */
    public void updatefuncGroup(FuncGroup funcGroup) {
        funcGroupMapper.updateFuncGroup(funcGroup); ApplicationContext context = ApplicationUtil.getInstance();
        IFunctionService functionService = context.getBean("FunctionBean", IFunctionService.class);
        Function[] functions= functionService.getFunctionsByFuncGroupIds((funcGroup.getFuncGroupId()));
        functionService.updateResoucesBatch(functions);

    }

    /**
     * 根绝功能组编码查询
     *
     * @param funcGroupId 应用编号
     */
    public FuncGroup getfuncGroup(int funcGroupId) {
        return funcGroupMapper.getFuncGroup(funcGroupId);
    }

    /**
     * 批量删除应用
     *
     * @param funcGroupIds 功能组编号集合
     */
    public void deletefuncGroups(List<Integer> funcGroupIds) {
        if(funcGroupIds.size()==0)
            return;;
        for (int i = 0; i < funcGroupIds.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            map.put("funcGroupId", funcGroupIds.get(i));
            List<Function> functions = functionService.getFunctionMapper().queryFunctions(map);
            List<String> funcCodes = new ArrayList<>();
            for (Function function : functions) {
                funcCodes.add(function.getFuncCode());
            }
            if(funcCodes.size()!=0){
                functionService.deleteFunctions(funcCodes);
            }
        }
        funcGroupMapper.deleteFuncGroups(funcGroupIds);
    }

    /**
     * 查询记录
     */
    public int count(String appId) {
        return funcGroupMapper.count(appId);
    }

    /**
     * 查询所有的功能组
     *
     * @return 所有的功能组
     */
    public List<FuncGroup> queryAllFuncGroups() {
        Map<String, Object> map = new HashMap<>();
        map.put("field", "display_order");
        map.put("order", "asc");
        return funcGroupMapper.queryFuncGroups(map);
    }

}
