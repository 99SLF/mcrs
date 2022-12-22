package com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.service;

import com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.mapper.ProcessMapper;
import com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.pojo.ProcessInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author 李伟杰
 * @date 2022/12/19 14:17
 */
@Service
public class ProcessService {

    @Autowired
    private ProcessMapper processMapper;
    /**
     * 添加监控信息
     * @param processInfo 监控信息
     */
    public void addProcessInfo(ProcessInfo processInfo){

        processMapper.addProcessInfo(processInfo);
    }

    /**
     *主键删除一条工序信息
     */
    public void deleteProcess(int processId) {
        processMapper.deleteProcess(processId);
    }
}
