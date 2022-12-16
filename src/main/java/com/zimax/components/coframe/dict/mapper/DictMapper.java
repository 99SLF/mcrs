package com.zimax.components.coframe.dict.mapper;

import com.zimax.components.coframe.dict.pojo.DictEntry;
import com.zimax.components.coframe.dict.pojo.DictType;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 字典数据操作
 *
 * @author 李伟杰
 * @date 2022/12/1
 */
@Mapper
public interface DictMapper {

    /**
     * 保存业务字典类型
     */
    void saveDictType(DictType dictType);

     DictEntry getDictByIdAndPid(String dictId, String dictTypeId);
    List<DictEntry> getDictByIdAndSeq(Map map);
    /**
     * 保存业务字典项
     */
    void saveDict(DictEntry dictEntry);


    /**
     * 查询业务字典类型,刷新业务字典缓存
     */
    List<DictType> queryDictTypes(Map map);
    List<String> queryDictIds(Map map);

    int countType(@Param("dictTypeId") String dictTypeId, @Param("dictTypeName") String dictTypeName);

    /**
     * 查询业务字典项
     */
    List<DictEntry> queryDicts(Map map);

    int count(@Param("dictTypeId") String dictTypeId, @Param("dictId") String dictId, @Param("parentId") String parentId);

    /**
     * 更新(修改)字典类型
     *
     * @param dictType 字典类型
     */

    void updateDictType(DictType dictType);

    /**
     * 更新(修改)字典项数据
     *
     * @param dictEntry 字典类型
     */
    void updateDict(DictEntry dictEntry);

    /**
     * 删除字典类型
     *
     * @param dictTypeId 字典类型编号
     */
    void removeDictType(String dictTypeId);

    /**
     * 删除字典项
     *
     * @param dictId 字典项代码
     */
    void removeDict(String dictId);

    /**
     * 批量删除字典类型
     *
     * @param dictTypeIds 字典类型编号数组
     */
    void deleteDictTypes(List<String> dictTypeIds);

    /**
     * 批量删除字典项
     *
     * @param dictIds 字典项数组
     */
    void deleteDicts(List<String> dictIds);

    /**
     * 获取字典类型信息
     *
     * @param dictTypeId 字典类型编号
     * @return 字典类型信息
     */
    DictType getDictType(String dictTypeId);

    /**
     * 获取字典项信息
     *
     * @param dictId 字典类型编号
     * @return 字典类型信息
     */
    DictEntry getDict(String dictId);
    DictEntry getDictByPrimary(@Param("dictId") String dictId, @Param("dictTypeId")String dictTypeId);

    /**
     * 导入业务字典
     */
    public void importDict(List<DictType> dictTypes);

    /**
     * 导出业务字典
     */
    public List<DictEntry> exportDict();

}
