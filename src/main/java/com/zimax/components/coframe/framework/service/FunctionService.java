package com.zimax.components.coframe.framework.service;

import com.zimax.components.coframe.framework.mapper.FuncGroupMapper;
import com.zimax.components.coframe.framework.mapper.FunctionMapper;
import com.zimax.components.coframe.framework.pojo.FuncGroup;
import com.zimax.components.coframe.framework.pojo.Function;
import com.zimax.mcrs.config.ChangeString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author 施林丰
 * @Date:2022/12/7 10:32
 * @Description
 */
@Service
public class FunctionService {
    /**
     * 功能信息数据操作
     */
    @Autowired
    private FunctionMapper functionMapper;

    /**
     * 查询所有功能信息
     * @param page 页码
     * @param limit 记录数
     * @param order 排序方式
     * @param field 排序字段
     * @return
     */
    public List<FuncGroup> queryFunctions(String  page, String limit, String funcGroupId, String order, String field) {
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
        return functionMapper.queryFunctions(map);
    }

    /**
     * 添加功能信息
     * @param function 功能信息
     */
    public void addFunction(Function function) {
        functionMapper.addFunction(function);
    }

    /**
     * 根据功能编号编号删除
     * @param funcCode 功能编号
     */
    public void deleteFunction(String funcCode) {
        functionMapper.deleteFunction(funcCode);
    }

    /**
     * 更新功能信息
     * @param function 功能信息
     */
    public void updateFunction(Function function) {
        functionMapper.updateFunction(function);
    }

    /**
     * 根绝功能编号查询
     * @param funcCode 功能编号
     */
    public Function getFunction(String funcCode) {
        return functionMapper.getFunction(funcCode);
    }

    /**
     * 批量删除功能
     * @param funcCodes 功能编号集合
     */
    public int deleteFunctions(List<String> funcCodes) {
        if(functionMapper.deleteFunctions(funcCodes)>0) {
            return 0;
        }
        else{
            return  1;
        }
    }

    /**
     * 查询记录
     */
    public int count(String funcCode){
        return functionMapper.count(funcCode);
    }

}
