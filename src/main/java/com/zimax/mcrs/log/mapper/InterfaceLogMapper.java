package com.zimax.mcrs.log.mapper;

import com.zimax.mcrs.log.pojo.InterfaceLog;

import java.util.List;

/**
 * 接口日志操作
 * @author 林俊杰
 * @date 2022/12/2
 */
public interface InterfaceLogMapper {
    /**
     * 查询所有的接口日志
     * @return
     */
    public List<InterfaceLog> findAll();

    /**
     * 定时删除
     */
    public List<InterfaceLog> deleteTime();

    /**
     * 根据Id查询正常目录
     */
    public  List<InterfaceLog> selectNormalLog();

    /**
     * 根据Id查询异常目录
     */
    public  List<InterfaceLog> selectUnusual();

    /**
     * 根据Id查询操作内容
     */
    public  List<InterfaceLog> selectOperationText();
}
