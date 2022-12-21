package com.zimax.mcrs.basic.accPointResMaintain.processInfoMaintain.mapper;

import com.zimax.mcrs.basic.accPointResMaintain.processInfoMaintain.pojo.ProcessInfo;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author 李伟杰
 * @date 2022/12/19 14:17
 */
@Mapper
public interface ProcessMapper {

    /**
     * 添加工序维护信息
     * @param processInfo 工序维护信息
     * @return
     */
    void addProcessInfo(ProcessInfo processInfo);

    /**
     * 主键删除工厂信息
     */
    void deleteProcess(int processId);
}
