package com.zimax.mcrs.device.service;

import com.zimax.mcrs.device.mapper.TerminalRenewMapper;
import com.zimax.mcrs.device.pojo.TerminalRenew;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TerminalRenewService {

    @Autowired
    private TerminalRenewMapper terminalRenewMapper;

    /**
     * 查询所有终端的版本信息
     * @return
     */
    public List<TerminalRenew> queryTerminalRenew(){
        return null;
    }

    /**
     * 依据终端更新编码查询
     * @return
     */
    public List<TerminalRenew> queryTerminalRenewId(){
        return null;
    }

    /**
     * 升级终端
     * @return
     */
    public void upgradeTerminalRenew(){

    }

    /**
     * 导出终端升级信息
     * @return
     */
    public void printTerminalRenew(){

    }
    /**
     * 上传终端的版本
     * @return
     */
    public void uploadTerminal(){

    }

    /**
     * 回退终端的版本
     * @return
     */
    public void rollBackTerminal(){

    }


    


}
