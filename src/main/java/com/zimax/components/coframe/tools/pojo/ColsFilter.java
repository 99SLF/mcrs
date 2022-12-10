package com.zimax.components.coframe.tools.pojo;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 列筛选
 *
 * @author 苏尚文
 * @date 2022/12/10 19:18
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("base_cols_filter")
public class ColsFilter {

	/**
	 * 功能名
	 */
	private String funName;

	/**
	 * 字段名
	 */
	private String field;

	/**
	 * 用户编号
	 */
	private String userId;

}
