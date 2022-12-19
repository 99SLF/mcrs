package com.zimax.mcrs.serialnumber.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.serialnumber.mapper.SerialnumberMapper;
import com.zimax.mcrs.serialnumber.pojo.Serialnumber;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author 施林丰
 * @Date:2022/12/19 15:33
 * @Description
 */
@Service
public class SerialnumberService {
    @Autowired
    SerialnumberMapper serialnumberMapper;

    /**
     * 新增编码规则
     * @param serialnumber 编码规则
     */
    public int addSerialnumber(Serialnumber serialnumber){
        int len = serialnumberMapper.count(null,serialnumber.getFunctionNum());
        if(len>0){
            return 1;
        }
        serialnumberMapper.addSerialnumber(serialnumber);
        return 0;
    }

    public void updateSerialnumber(Serialnumber serialnumber){
        serialnumberMapper.updateSerialnumber(serialnumber);
    }

    /**
     * s删除编码规则
     * @param Ids 编码规则主键
     */
    public void batchDeleteSerialnumber(List<Integer> Ids){
        serialnumberMapper.batchDeleteSerialnumber(Ids);
    }

    public List<Serialnumber> querySerialnumbers(String page, String limit, String functionName, String order, String field){
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "id");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("functionName", functionName);
        return serialnumberMapper.querySerialnumbers(map);
    }
    public int count(String functionName,String functionNum){
        return serialnumberMapper.count(functionName,functionNum);
    }
}
