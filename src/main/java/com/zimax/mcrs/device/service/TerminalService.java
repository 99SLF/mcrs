package com.zimax.mcrs.device.service;

import com.zimax.mcrs.device.mapper.TerminalMapper;
import com.zimax.mcrs.device.pojo.Terminal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 设备终端服务
 * @author 林俊杰
 * @date 2022/11/30
 */
@Service
public class TerminalService {

    @Autowired
    private TerminalMapper terminalMapper;

    /**
     * 注册终端
     * @param terminal 终端
     */
    public void registrationTerminal(Terminal terminal) {

        terminalMapper.insert(terminal);
    }

    /**
     * 注销终端
     * @param APPId 根据APPID注销
     */
    public void logoutById(int APPId) {

        terminalMapper.deleteById(APPId);
    }

    /**
     * 初始化查询
     */
    public List<Terminal> queryAll() {

        return terminalMapper.selectList(null);
    }

    /**
     * 根据APPId查询
     * @param APPId 依据APPId查询
     */
    public Terminal queryAPPId(int APPId) {

        return terminalMapper.selectById(APPId);
    }

    /**
     * 根据设备资源号查询
     * @param deviceId 依据设备资源号查询
     */
    public Terminal queryDeviceId(int deviceId) {

        return terminalMapper.selectById(deviceId);
    }

    /**
     * 根据终端软件类型查询
     * @param terminalType 依据终端软件类型查询
     */
    public Terminal queryTerminalType(String terminalType) {

        return terminalMapper.selectById(terminalType);
    }


}
