package com.zimax.components.coframe.dict.mapper;

import com.zimax.components.coframe.dict.pojo.DictEntry;
import com.zimax.components.coframe.dict.pojo.DictType;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Result;

import java.util.List;

/**
 * 字典数据操作
 * @author 李伟杰
 * @date 2022/12/1
 */
@Mapper
public interface DictMapper {

    /**
     * 查询业务字典类型,刷新业务字典缓存
     */
    public List<DictType> queryDictType();

    /**
     *查询业务字典项
     */
    public List<DictEntry> queryDict();

    /**
     *保存业务字典类型
     */
    public void saveDictType(DictType dictType);

    /**
     *保存业务字典项
     */
    public  void saveDict(DictEntry dictEntry);

    /**
     *级联删除字典类型
     */
    public void removeDictTypeCascade(List<String> dictTypeId );

    /**
     *删除业务字典类型
     */
    public void removeDictType(DictType dictType);

    /**
     *导入业务字典
     */
    public void importDict(List<DictType> dictTypes);

    /**
     *导出业务字典
     */
    public List<DictEntry> exportDict();



}
