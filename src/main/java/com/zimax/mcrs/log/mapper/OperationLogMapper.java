package com.zimax.mcrs.log.mapper;

import com.zimax.mcrs.log.pojo.InterfaceLog;
import com.zimax.mcrs.log.pojo.OperationLog;

import java.util.List;

/**
 * 操作日志操作
 * @author 林俊杰
 * @date 2022/12/2
 */
public interface OperationLogMapper {

    /**
     * 查询所有的接口日志
     * @return
     */
    public List<OperationLog> findAll();

    /**
     * 定时删除
     */
    public List<OperationLog> deleteTime();

    /**
     * 根据条件查询
     */
    public  List<OperationLog> select();

    /**
     * 根据Id查询操作内容
     */
    public  List<OperationLog> selectOperationText();

    /**
     * 根据Id查询操作结果
     */
    public  List<OperationLog> selectOperationResult();
}
