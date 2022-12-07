package com.zimax.components.coframe.framework.service;

import com.zimax.components.coframe.framework.mapper.FuncGroupMapper;
import com.zimax.components.coframe.framework.pojo.FuncGroup;
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
public class FuncGroupService {

    /**
     * 功能组数据操作
     */
    @Autowired
    private FuncGroupMapper funcGroupMapper;

    /**
     * 查询所有功能组信息
     * @return
     */
    public List<FuncGroup> queryFuncGroups(int page , int limit, int appId, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String,Object> map= new HashMap<>();
        if(order==null){
            map.put("order","asc");
            map.put("field","app_id");
        }else{
            map.put("order",order);
            map.put("field",changeString.camelUnderline(field));
        }
        map.put("begin",limit*(page-1));
        map.put("limit",limit);
        map.put("appId",appId);
        return funcGroupMapper.queryFuncGroups(map);
    }

    /**
     * 添加功能组信息
     * @param funcGroup 应用
     */
    public void addFuncGroup(FuncGroup funcGroup) {
        funcGroupMapper.addFuncGroup(funcGroup);
    }

    /**
     * 根据功能组编号删除
     * @param funcGroupId 功能组编号
     */
    public void deletefuncGroup(int funcGroupId) {
        funcGroupMapper.deleteFuncGroup(funcGroupId);
    }

    /**
     * 更新应用
     * @param funcGroup 应用信息
     */
    public void updatefuncGroup(FuncGroup funcGroup) {
        funcGroupMapper.updateFuncGroup(funcGroup);
    }

    /**
     * 根绝功能组编码查询
     * @param funcGroupId 应用编号
     */
    public FuncGroup getfuncGroup(int funcGroupId) {
        return funcGroupMapper.getFuncGroup(funcGroupId);
    }

    /**
     * 批量删除应用
     * @param funcGroupIds 功能组编号集合
     */
    public void deletefuncGroups(List<Integer> funcGroupIds) {
        funcGroupMapper.deleteFuncGroups(funcGroupIds);
    }

    /**
     * 查询记录
     */
    public int count(int appId){
        return funcGroupMapper.count(appId);
    }
}
