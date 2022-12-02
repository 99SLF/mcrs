package com.zimax.mcrs.log.service;

import com.zimax.mcrs.log.mapper.InterfaceLogMapper;
import com.zimax.mcrs.log.pojo.InterfaceLog;
import com.zimax.mcrs.rights.mapper.RoleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 接口日志
 * @author 林俊杰
 * @date 2022/12/2
 */
@Service
public class InterfaceLogService {

    /**
     * 接口日志操作
     */
    @Autowired
    private InterfaceLogMapper interfaceLogMapper;

    /**
     * 查询所有接口日志信息
     */
    public List<InterfaceLog> queryInterfaceLog(){
        return null;
    }
}
