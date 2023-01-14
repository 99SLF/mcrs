package com.zimax.mcrs.systemFile.mapper;

import com.zimax.mcrs.systemFile.pojo.SystemFile;

import java.util.List;

/**
 * @Author 施林丰
 * @Date:2023/1/13 16:32
 * @Description
 */
public interface SystemFileMapper {
    void addSystemFile(SystemFile systemFile);
    void updateSystemFile(SystemFile systemFile);
    List<SystemFile> querySystemFile();
}
