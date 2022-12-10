package com.zimax.components.coframe.tools.mapper;

import com.zimax.components.coframe.tools.pojo.ColsFilter;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 列筛选数据操作
 *
 * @author 苏尚文
 * @date 2022/12/10 19:25
 */
@Mapper
public interface ColsFilterMapper {

	/**
	 * 查询列筛选列表
	 *
	 * @param funName 功能名
*      @param userId 用户编号
	 * @return 列筛选列表
	 */
	List<ColsFilter> queryColsFilters(@Param("funName") String funName, @Param("userId") String userId);

	/**
	 * 添加列筛选
	 *
	 * @param colsFilter 列筛选
	 */
	void addColsFilter(ColsFilter colsFilter);

	/**
	 * 删除列筛选
	 *
	 * @param colsFilter 列筛选
	 */
	void deleteColsFilter(ColsFilter colsFilter);

}
