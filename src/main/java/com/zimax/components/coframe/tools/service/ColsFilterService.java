package com.zimax.components.coframe.tools.service;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.components.coframe.tools.mapper.ColsFilterMapper;
import com.zimax.components.coframe.tools.pojo.ColsFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 列筛选服务
 *
 * @author 苏尚文
 * @date 2022/12/10 20:06
 */
@Service
public class ColsFilterService {

	@Autowired
	private ColsFilterMapper colsFilterMapper;

	/**
	 * 查询隐藏字段
	 *
	 * @param funName 功能名
	 * @return 隐藏字段
	 */
	public List<ColsFilter> queryHiddenField(String funName) {
		String userId = DataContextManager.current().getMUODataContext().getUserObject().getUserId();
		return colsFilterMapper.queryColsFilters(funName, userId);
	}

	/**
	 * 设置隐藏字段
	 *
	 * @param colsFilter 列筛选
	 * @param hidden 是否隐藏
	 */
	public void setHiddenField(ColsFilter colsFilter, boolean hidden) {
		String userId = DataContextManager.current().getMUODataContext().getUserObject().getUserId();
		colsFilter.setUserId(userId);
		if (hidden) {
			colsFilterMapper.addColsFilter(colsFilter);
		} else {
			colsFilterMapper.deleteColsFilter(colsFilter);
		}
	}

}
