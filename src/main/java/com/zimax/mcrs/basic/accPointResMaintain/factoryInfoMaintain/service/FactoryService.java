package com.zimax.mcrs.basic.accPointResMaintain.factoryInfoMaintain.service;

import com.zimax.mcrs.basic.accPointResMaintain.factoryInfoMaintain.mapper.FactoryMapper;
import com.zimax.mcrs.basic.accPointResMaintain.factoryInfoMaintain.pojo.FactoryInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author 李伟杰
 * @date 2022/12/19 14:16
 */
@Service
public class FactoryService {
    @Autowired
    private FactoryMapper factoryMapper;

    /**
     * 添加工厂维护信息
     * @param factoryInfo 监控信息
     */
    public void addFactoryInfo(FactoryInfo factoryInfo){

        factoryMapper.addFactoryInfo(factoryInfo);
    }

    /**
     *主键删除一条工厂信息
     */
    public void deleteFactory(int factoryId) {
        factoryMapper.deleteFactory(factoryId);
    }
}
