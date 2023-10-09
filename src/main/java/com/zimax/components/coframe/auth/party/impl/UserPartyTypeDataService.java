package com.zimax.components.coframe.auth.party.impl;

import com.zimax.cap.party.IPartyTypeDataService;
import com.zimax.cap.party.Party;
import com.zimax.components.coframe.auth.party.manager.DefaultUserManager;
import com.zimax.components.coframe.rights.pojo.User;
import com.zimax.components.coframe.tools.IConstants;
import com.zimax.components.coframe.tools.service.ApplicationUtil;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.ArrayList;
import java.util.List;

/**
 * @author 苏尚文
 * @date 2022/12/12 11:00
 */
public class UserPartyTypeDataService implements IPartyTypeDataService {

	// 默认用户管理Bean
	private DefaultUserManager bean = null;

	/**
	 * 构造方法
	 */
	public UserPartyTypeDataService() {
		ApplicationContext context = ApplicationUtil.getInstance();
		this.bean = context.getBean(DefaultUserManager.SPRING_BEAN_NAME, DefaultUserManager.class);
	}

	/**
	 * 获取所有参与者列表
	 *
	 * @return 参与者列表
	 */
	@Override
	public List<Party> getAllPartyList() {
		User[] userArray = this.bean.getAllUserList();
		List<Party> returnList = new ArrayList<Party>();
		if (userArray != null) {
			for (User user : userArray) {
				returnList.add(adapt(user));
			}
		}
		return returnList;
	}

	/**
	 * 根据参与者编号获取参与者对象
	 *
	 * @param partyId  参与者编号
	 * @return 参与者对象
	 */
	@Override
	public Party getPartyByPartyId(String partyId) {
		User user = this.bean.getUserByUserId(partyId);
		if (user != null) {
			return adapt(user);
		}
		return null;
	}

	/**
	 * 获取根参与者列表
	 *
	 * @return 根参与者列表
	 */
	public List<Party> getRootPartyList() {
		return this.getAllPartyList();
	}

	/**
	 * 改变用户类型,使其为参与者类型
	 *
	 * @param capUser cap用户
	 * @return 参与者
	 */
	private Party adapt(User capUser) {
		Party party = new Party(IConstants.USER_PARTY_TYPE_ID, capUser.getUserId(), null, capUser.getUserName());
		party.putExtAttribute(IConstants.EMAIL, capUser.getEmail());
		party.putExtAttribute(IConstants.MENU_TYPE, capUser.getMenuType());
		return party;
	}

}