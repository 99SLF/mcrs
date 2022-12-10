package com.zimax.components.coframe.dict.mapper;

import com.zimax.components.coframe.dict.pojo.DictData;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 字典加载
 *
 * @author 李伟杰
 * @date 2022/12/5 16:07
 */
@Mapper
public interface DictLoaderMapper {

	/**
	 * 根据字典类型编号获取字典数据
	 *
	 * @param dictTypeId 字典类型编号
	 * @return 字典数据
	 */
	List<DictData> getDictDatas(String dictTypeId);

}
