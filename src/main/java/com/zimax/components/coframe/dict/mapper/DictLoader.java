package com.zimax.components.coframe.dict.mapper;

import com.zimax.components.coframe.dict.pojo.DictType;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @author 李伟杰
 * @date 2022/12/5 16:07
 */
@Mapper
public interface DictLoader {

    /**
     * 获取字典数据
     *
     */
    public DictType getDict(String dictTyp);


}
