package com.zimax.mcrs.log.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.log.mapper.OperationLogMapper;
import com.zimax.mcrs.log.pojo.InterfaceLog;
import com.zimax.mcrs.log.pojo.OperationLog;
import com.zimax.mcrs.log.pojo.OperationLogVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
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

    @Autowired
    private AddOperationLog addOperationLog;

    /**
     * 查询所有操作日志信息
     */
    public List<OperationLogVo> queryOperationLog(String limit, String page, String logStatus, String operationType, String operationTime,String result, String operateName,String order, String field){
        if (logStatus!=null||operationType!=null||operationTime!=null||result!=null||operateName!=null){
            addOperationLog.addOperationLog(6);
        }

        ChangeString changeString = new ChangeString();
        Map<String,Object> map= new HashMap<>();
        if(order==null){
            map.put("order","desc");
            map.put("field","ll.operation_time");
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
        map.put("result",result);
        map.put("operateName",operateName);
        return operationLogMapper.queryAll(map);
    }

    /**
     * 查询记录
     */
    public int count(String logStatus, String operationType, String operationTime,String result, String operator) {
        return operationLogMapper.count(logStatus,operationType,operationTime,result,operator);
    }

    /**
     * 新增操作日志
     */
    public void addOperationLog(OperationLog operationLog) {
        operationLog.setLogType("103");
        operationLog.setCreateTime(new Date());
        operationLogMapper.addOperationLog(operationLog);
    }

}
