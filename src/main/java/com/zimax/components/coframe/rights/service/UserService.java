package com.zimax.components.coframe.rights.service;

import com.alibaba.excel.util.StringUtils;
import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.utility.CryptoUtil;
import com.zimax.components.coframe.rights.DefaultUserManager;
import com.zimax.components.coframe.rights.mapper.UserMapper;
import com.zimax.components.coframe.rights.pojo.User;
import com.zimax.mcrs.config.ChangeString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/3
 */
@Service
public class UserService {

	/**
	 * 用户数据操作
	 */
	@Autowired
	private UserMapper userMapper;

	/**
	 * 添加用户信息
	 *
	 * @param user 用户
	 */
	public void addUser(User user) {
		try {
			String creator = DataContextManager.current().getMUODataContext().getUserObject().getUserId();
			user.setCreator(creator);
			user.setPassword(encrypt(user.getPassword()));
			user.setCreateTime(new Date());
			user.setLastLogin(new Date());
			user.setUnlockTime(new Date());
			if (user.getStartDate() == null) {
				user.setStartDate(new Date());
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		userMapper.addUser(user);
	}
	// 加密
	private static String encrypt(String password) throws Exception {
		 return DefaultUserManager.INSTANCE.encodeString(password);
	}
	/**
	 * 通过用户状态和用户名称查询记录条数
	 * @param
	 * @return
	 */
	public int count(String status, String userName) {
		return userMapper.count(status, userName);
	}

	/**
	 * 查询所有用户信息
	 */
	public List<User> queryUsers(String page, String limit, String status, String userName, String order, String field) {
		ChangeString changeString = new ChangeString();
		Map<String, Object> map = new HashMap<>();
		if (order == null) {
			map.put("order", "asc");
			map.put("field", "create_time");
		} else {
			map.put("order", order);
			map.put("field", changeString.camelUnderline(field));
		}
		if (limit != null) {
			map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
			map.put("limit", Integer.parseInt(limit));
		}
		map.put("status", status);
		map.put("userName", userName);
		return userMapper.queryUsers(map);

	}

	/**
	 * 重置密码
	 *
	 * @param users
	 */
	public void updatePasswords(List<User> users) {
		String password = DefaultUserManager.INSTANCE
				.encodeString("000000");
		for (User user : users) {
			user.setPassword(password);
		}
		userMapper.updatePasswords(users);

	}

	/**
	 * 检测用户是否存在
	 *
	 * @param userId 用户编号
	 */
	public int  checkUser(String userId) {
		return userMapper.checkUser(userId) ;
	}

	/**
	 * 批量删除用户
	 *
	 * @param operatorIds 操作员编号
	 */
	public void deleteUsers(List<Integer> operatorIds) {
		userMapper.deleteUsers(operatorIds);
	}

	/**
	 * 编辑，更新用户
	 */
	public void updateUser(User user) {
		userMapper.updateUser(user);
	}
//	/**
//	 * 通过用户编码查询匹配密码的记录条数
//	 * @param
//	 * @return
//	 */
//	public int countPa(String userId){
//		return userMapper.countPa(userId);
//	}
//	/**
//	 * 查询匹配密码的用户信息
//	 * @param
//	 * @return
//	 */
//	public List<User> queryPassword(String page, String limit, String userId, String order, String field){
//		ChangeString changeString = new ChangeString();
//		Map<String, Object> map = new HashMap<>();
//		if (order == null) {
//			map.put("order", "desc");
//			map.put("field", "user_id");
//		} else {
//			map.put("order", order);
//			map.put("field", changeString.camelUnderline(field));
//		}
//		if (limit != null) {
//			map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
//			map.put("limit", Integer.parseInt(limit));
//		}
//		map.put("userId", userId);
//		return userMapper.queryPassword(map);
//	}





	/**
	 * 主键删除用户信息
	 */
	public void deleteUser(int operatorId) {
		userMapper.deleteUser(operatorId);
	}



	/**
	 * 根据操作员编号获取用户
	 *
	 * @param operatorId 操作员编号
	 */
	public User getUser(int operatorId) {
		return userMapper.getUser(operatorId);
	}

//	/**
//	 * 重置密码
//	 *
//	 * @param userIds 用户编号
//	 */
//	public void updatePasswords(List<String> userIds) {
//			String password = DefaultUserManager.INSTANCE
//					.encodeString("000000");
//			userMapper.updatePasswords(userIds,password);
//
//		}







	/**
	 * 获取用户
	 *
	 * @param userId 用户编号
	 */
	public User getUserByUserId(String userId) {
		if (!StringUtils.isBlank(userId)) {
			User user = userMapper.getUserByUserId(userId);
			return user;
		}
		return null;
	}

	public String encodePassword(String password) {
		return DefaultUserManager.INSTANCE.encodeString(password);
	}



}
