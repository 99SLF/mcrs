package com.zimax.components.coframe.dict.service;

import com.zimax.components.coframe.dict.mapper.DictLoader;
import com.zimax.components.coframe.dict.pojo.DictType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author 李伟杰
 * @date 2022/12/5 16:25
 */
@Service
public class DictLoaderService {
    @Autowired
    private DictLoader dictLoader;

    /**
     * 根据字典类型编号获取字典数据
     */
    public DictType getDict(String dictTypeId){
        return null;

    }



}
