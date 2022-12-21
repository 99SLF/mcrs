package com.zimax.mcrs.log.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.log.mapper.OperationLogMapper;
import com.zimax.mcrs.log.pojo.InterfaceLog;
import com.zimax.mcrs.log.pojo.OperationLog;
import com.zimax.mcrs.log.pojo.OperationLogVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 操作日志
 * @author 林俊杰
 * @date 2022/12/2
 */
@Service
public class OperationLogService {

    /**
     * 操作日志
     */
    @Autowired
    private OperationLogMapper operationLogMapper;

    /**
     * 查询所有操作日志信息
     */
    public List<OperationLogVo> queryOperationLog(String limit, String page, String logStatus, String operationType, String operationTime,String operationResult, String operator,String order, String field){
        ChangeString changeString = new ChangeString();
        Map<String,Object> map= new HashMap<>();
        if(order==null){
            map.put("order","desc");
            map.put("field","operation_time");
        }else{
            map.put("order",order);
            map.put("field",changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("logStatus",logStatus);
        map.put("operationType",operationType);
        map.put("operationTime",operationTime);
        map.put("operationResult",operationResult);
        map.put("operator",operator);
        return operationLogMapper.queryAll(map);
    }

    /**
     * 查询记录
     */
    public int count(String logStatus) {
        return operationLogMapper.count(logStatus);
    }

    /**
     * 新增操作日志
     */
    public void addOperationLog(OperationLog operationLog) {
        operationLogMapper.addOperationLog(operationLog);
    }

}
