package com.zimax.mcrs.systemFile.service;

import com.zimax.mcrs.systemFile.mapper.SystemFileMapper;
import com.zimax.mcrs.systemFile.pojo.SystemFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author 施林丰
 * @Date:2023/1/13 17:06
 * @Description
 */
@Service
public class SystemFileService {
    @Autowired
    private SystemFileMapper systemFileMapper;
    public List<SystemFile> querySystemFile(){
        return systemFileMapper.querySystemFile();
    }
    public void updateSystemFile(SystemFile systemFile){
        systemFileMapper.updateSystemFile(systemFile);
    }

    public void addSystemFile(SystemFile systemFile){
        systemFileMapper.addSystemFile(systemFile);
    }
}
