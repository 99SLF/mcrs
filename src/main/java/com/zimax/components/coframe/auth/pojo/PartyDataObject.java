package com.zimax.components.coframe.auth.pojo;

import lombok.Data;

/**
 * 参与者数据对象
 *
 * @author 苏尚文
 * @date 2022/12/12 10:06
 */
@Data
public class PartyDataObject {

	/**
	 * 参与者编号
	 */
	public String id;

	/**
	 * 参与者编码
	 */
	public String code;

	/**
	 * 参与者名称
	 */
	public String name;

	/**
	 * 参与者类型
	 */
	public String partyType;

	/**
	 * 是否可管理
	 */
	public String isManaged;

}
