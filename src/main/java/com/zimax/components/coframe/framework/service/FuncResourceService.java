package com.zimax.components.coframe.framework.service;

import com.zimax.components.coframe.framework.mapper.FuncResourceMapper;
import com.zimax.components.coframe.framework.mapper.FunctionMapper;
import com.zimax.components.coframe.framework.pojo.FuncGroup;
import com.zimax.components.coframe.framework.pojo.FuncResource;
import com.zimax.components.coframe.framework.pojo.Function;
import com.zimax.mcrs.config.ChangeString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author 施林丰
 * @Date:2022/12/7 10:33
 * @Description
 */
@Service
public class FuncResourceService {
    /**
     * 功能资源数据操作
     */
    @Autowired
    private FuncResourceMapper funcResourceMapper;

    /**
     * 查询所有功能资源信息
     *
     * @param page  页码
     * @param limit 记录数
     * @param funcCode 功能代码
     * @param order 排序方式
     * @param field 排序字段
     * @return
     */
    public List<FuncResource> queryFuncResources(String page, String limit, String funcCode, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "res_id");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("funcCode", funcCode);
        return funcResourceMapper.queryFuncResource(map);
    }

    /**
     * 添加功能资源信息
     * @param funcResource 功能资源信息
     */
    public void addFuncResource(FuncResource funcResource) {
        funcResourceMapper.addFuncResource(funcResource);
    }

    /**
     * 更新功能资源信息
     *
     * @param function 功能信息
     */
    public void updateFunc(Function function) {
        funcResourceMapper.updateFuncResource(function);
    }

    /**
     * 根据功能资源查询
     *
     * @param funcCode 功能编号
     */
    public Function getFunction(String funcCode) {
        return functionMapper.getFunction(funcCode);
    }

    /**
     * 批量删除功能资源
     *
     * @param funcCodes 功能编号集合
     */
    public int deleteFunctions(List<String> funcCodes) {
        if (functionMapper.deleteFunctions(funcCodes) > 0) {
            return 0;
        } else {
            return 1;
        }
    }

    /**
     * 查询记录
     */
    public int count(String funcCode) {
        return functionMapper.count(funcCode);
    }
}
