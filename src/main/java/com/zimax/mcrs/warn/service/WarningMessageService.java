package com.zimax.mcrs.warn.service;

import com.zimax.mcrs.warn.mapper.WarningMessageMapper;
import com.zimax.mcrs.warn.pojo.WarningMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 警告信息服务
 * @author 林俊杰
 * @date 2022/11/29
 */
@Service
public class WarningMessageService {

    @Autowired
    private WarningMessageMapper warningMessageMapper;

    /**
     * 根绝预警名称查询
     */
    public WarningMessage query(String warningmessage){
        return warningMessageMapper.selectById(warningmessage);
    }

    /**
     * 查询预警
     */
    public List<WarningMessage> queryAll(){
        return warningMessageMapper.selectList(null);
    }

    /**
     * 查询所有警告信息
     * @return
     */
    public List<WarningMessage> queryWarningMessage(int page, int limit){
//        QueryWrapper<WarningMessage> queryWrapper = new QueryWrapper<>();
//        List<WarningMessage> warningMessageList = warningMessageMapper.selectList(queryWrapper);
//        System.out.println(warningMessageList.toString());
        return null;
    }

}
