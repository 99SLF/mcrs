package com.zimax.components.coframe.tools.controller;

import com.zimax.components.coframe.tools.pojo.ColsFilter;
import com.zimax.components.coframe.tools.service.ColsFilterService;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 列筛选
 *
 * @author 苏尚文
 * @date 2022/12/10 19:09
 */
@RestController
@RequestMapping("/cols/filter")
public class ColsFilterController {

	/**
	 * 列筛选服务
	 */
	@Autowired
	private ColsFilterService colsFilterService;

	/**
	 * 查询隐藏字段
	 *
	 * @param funName 功能名
	 * @return 隐藏字段
	 */
	@GetMapping("/query/{funName}")
	public Result<?> queryHiddenField(@PathVariable("funName") String funName) {
		return Result.success(colsFilterService.queryHiddenField(funName));
	}

	/**
	 * 设置隐藏字段
	 *
	 * @param funName 功能名
	 * @param field 字段名
	 * @param hidden 是否隐藏
	 * @return
	 */
	@GetMapping("/set")
	public Result<?> setHiddenField(String funName, String field, boolean hidden) {
		ColsFilter colsFilter = new ColsFilter();
		colsFilter.setFunName(funName);
		colsFilter.setField(field);
		colsFilterService.setHiddenField(colsFilter, hidden);
		return Result.success();
	}

}
