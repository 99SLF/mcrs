package com.zimax.mcrs.log.service;

import com.zimax.mcrs.log.mapper.OperationLogMapper;
import com.zimax.mcrs.log.pojo.OperationLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
    public List<OperationLog> queryOperationLog(){
        return null;
    }
}
