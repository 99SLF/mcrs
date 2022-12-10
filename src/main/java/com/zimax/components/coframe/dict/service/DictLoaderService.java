package com.zimax.components.coframe.dict.service;

import com.zimax.components.coframe.dict.mapper.DictLoaderMapper;
import com.zimax.components.coframe.dict.pojo.DictData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 李伟杰
 * @date 2022/12/5 16:25
 */
@Service
public class DictLoaderService {

	@Autowired
	private DictLoaderMapper dictLoader;

	/**
	 * 根据字典类型编号获取字典数据
	 *
	 * @param dictTypeId 字典类型编号
	 * @return 字典数据
	 */
	public List<DictData> getDictDatas(String dictTypeId) {
		return dictLoader.getDictDatas(dictTypeId);
	}

}
