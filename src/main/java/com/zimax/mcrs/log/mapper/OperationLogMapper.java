package com.zimax.mcrs.log.mapper;

import com.zimax.mcrs.log.pojo.InterfaceLog;
import com.zimax.mcrs.log.pojo.OperationLog;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

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
    public List<OperationLog> queryAll();

    /**
     * 定时删除
     */
    public List<OperationLog> removeTime();

    /**
     * 根据条件查询
     */
    public  List<OperationLog> query();

}
