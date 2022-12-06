package com.zimax.components.coframe.dict.service;

import com.zimax.components.coframe.dict.mapper.DictMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 字典项
 * @author 李伟杰
 * @date 2022/12/1
 */
@Service
public class DictService {
    @Autowired
    private DictMapper dictMapper;
}
