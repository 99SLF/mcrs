package com.zimax.components.coframe.dict.service;

import com.zimax.components.coframe.dict.mapper.DictMapper;
import com.zimax.components.coframe.dict.pojo.DictEntry;
import com.zimax.components.coframe.dict.pojo.DictType;
import com.zimax.mcrs.config.ChangeString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 字典项
 * @author 李伟杰
 * @date 2022/12/1
 */
@Service
public class DictService {
    @Autowired
    private DictMapper dictMapper;

    /**
     * 添加字典类型
     *
     * @param dictType 字典类型
     */
    public int saveDictType(DictType dictType) {
        DictType dictType1 = dictMapper.getDictType(dictType.getDictTypeId());
        if(dictType1 == null && dictType.getParentId() != null){
            dictType.setRank(dictType.getRank()+1);
            dictType.setSeqNo(dictType.getSeqNo()+dictType.getDictTypeId()+".");
            dictMapper.saveDictType(dictType);
            return 0;//成功
        }else if(dictType1 == null && dictType.getParentId() == null){
            dictType.setRank(1);
            dictType.setSeqNo("."+dictType.getDictTypeId()+".");
            dictMapper.saveDictType(dictType);
            return 0;
        }else {
            return 1;//已存在
        }
    }

    /**
     * 添加字典项
     *
     * @param dictEntry 字典项
     */
    public int saveDict(DictEntry dictEntry) {
        DictEntry dictEntry1 = dictMapper.getDict(dictEntry.getDictId());
        if(dictEntry1 == null && dictEntry.getParentId()!= null){
            dictEntry.setRank(dictEntry.getRank()+1);
            dictEntry.setSeqNo(dictEntry.getSeqNo()+dictEntry.getDictId()+".");
            dictMapper.saveDict(dictEntry);
            return 0;
        }else if(dictEntry1 == null && dictEntry.getParentId()== null){
            dictEntry.setRank(1);
            dictEntry.setSeqNo("." + dictEntry.getDictId() + ".");
            dictMapper.saveDict(dictEntry);
            return 0;
        }else {
           return 1;
        }
    }

    /**
     * 查询所有字典类型信息
     */
    public List<DictType> queryDictTypes(String page, String limit, String dictTypeId, String name, String id, String order, String field) {
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "dicttypeid");
        } else {
            map.put("order", order);
            map.put("field", field);
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        if(dictTypeId!=null){
            map.put("parentId",dictTypeId);
            return dictMapper.queryDictTypes(map);
        }else{
            map.put("dictTypeId", id);
            map.put("dictTypeName", name);
            return dictMapper.queryDictTypes(map);
        }
    }
    public int countType(String dictTypeId, String dictTypeName) {
        return dictMapper.countType(dictTypeId, dictTypeName);
    }

    /**
     * 查询所有字典项信息
     */
    public List<DictEntry> queryDicts(String page, String limit,String dictTypeId,  String dictId, String parentTypeId,String order, String field) {
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "parentid");
        } else {
            map.put("order", order);
            map.put("field", field);
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        if(dictId!=null){
            DictEntry dictEntry = dictMapper.getDictByIdAndPid(dictId,parentTypeId);
            map.put("seqNo", dictEntry.getSeqNo());
            map.put("parentId", dictId);
            return dictMapper.getDictByIdAndSeq(map);
        }else{
            map.put("dictTypeId", dictTypeId);
            return dictMapper.queryDicts(map);
        }

    }
    public int count(String dictTypeId,  String dictId, String parentId) {
        return dictMapper.count(dictTypeId, dictId,parentId);
    }

    /**
     * 更新(修改)字典类型
     *
     * @param dictType 字典类型
     */
    public void updateDictType(DictType dictType){
        dictMapper.updateDictType(dictType);
    }
    /**
     * 更新(修改)字典项数据
     *
     * @param dictEntry 字典类型
     */
    public void updateDict(DictEntry dictEntry){
        dictMapper.updateDict(dictEntry);
    }
    /**
     * 删除字典类型
     *
     * @param dictTypeId 字典类型编号
     */
    public void removeDictType(String dictTypeId){
        dictMapper.removeDictType(dictTypeId);
    }
    /**
     * 删除字典项
     *
     * @param dictId 字典项代码
     */
    public void removeDict(String dictId){
        dictMapper.removeDict(dictId);
    }
    /**
     * 批量删除字典类型
     *
     * @param dictTypeIds 字典类型编号数组
     */
    public void deleteDictTypes(List<String> dictTypeIds){
        dictMapper.deleteDictTypes(dictTypeIds);
    }
    /**
     * 批量删除字典项
     *
     * @param dictIds 字典项数组
     */
    public void deleteDicts(List<String> dictIds){
        dictMapper.deleteDicts(dictIds);
    }
    /**
     * 获取字典类型信息
     *
     * @param dictTypeId 字典类型编号
     * @return 字典类型信息
     */
    public DictType getDictType(String dictTypeId){
      return   dictMapper.getDictType(dictTypeId);
    }
    /**
     * 获取字典项信息
     *
     * @param dictId 字典类型编号
     * @return 字典类型信息
     */
    public DictEntry getDict(String dictId){
       return dictMapper.getDict(dictId);
    }

    /**
     * 导入业务字典
     *
     * @return状态码
     */

    /**
     * 导出业务字典
     */


}
