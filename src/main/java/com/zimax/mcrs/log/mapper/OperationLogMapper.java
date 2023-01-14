package com.zimax.mcrs.log.mapper;

import com.zimax.mcrs.log.pojo.InterfaceLog;
import com.zimax.mcrs.log.pojo.OperationLog;
import com.zimax.mcrs.log.pojo.OperationLogVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 操作日志操作
 * @author 林俊杰
 * @date 2022/12/2
 */
@Mapper
public interface OperationLogMapper {

    /**
     * 查询所有的接口日志
     * @return
     */
    List<OperationLogVo> queryAll(Map map);


    /**
     * 计数
     * @return
     */
    int count(@Param("logStatus") String logStatus,
              @Param("operationType") String operationType,
              @Param("operationTime") String operationTime,
              @Param("operationResult") String operationResult,
              @Param("operator") String operator
    );


    /**
     * 删除功能
     */
    public void removeOperationLog(int operationLogId);

    /**
     * 新建操作日志
     */
    void addOperationLog(OperationLog operationLog);



}
