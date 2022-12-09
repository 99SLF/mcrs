package com.zimax.components.coframe.rights;

import com.zimax.components.coframe.rights.pojo.User;
import com.zimax.components.coframe.rights.UserPasswordCipherUtils;
import java.util.Date;

/**
 * @Author 施林丰
 * @Date:2022/12/9 9:43
 * @Description
 */
public class DefaultUserManager {

    public final static DefaultUserManager INSTANCE = new DefaultUserManager();

    public User setUserAttributeE(User capUser) {
        try {
            capUser.setPassword(encrypt(capUser.getPassword()));
            capUser.setCreateUser("sysadmin");
            capUser.setTenantId("default");
            capUser.setCreateTime(new Date());
            capUser.setLastLogin(new Date());
            capUser.setUnlockTime(new Date());
            if (capUser.getStartDate() == null) {
                capUser.setStartDate(new Date());
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return capUser;
    }

    /**
     * 设置用户属性
     *
     * @param capUser 用户对象
     * @return 用户对象
     */
    public User setUserAttribute(User capUser) {
//        try {
//            capUser.setPassword(encrypt(capUser.getPassword()));
//            capUser.setCreateUser(AppUserManager.getCurrentUserId());
//            capUser.setTenantId(TenantManager.getCurrentTenantID());
//            capUser.setCreateTime(new Date());
//            capUser.setLastLogin(new Date());
//            capUser.setUnlockTime(new Date());
//            if (capUser.getStartDate() == null) {
//                capUser.setStartDate(new Date());
//            }
//        } catch (Exception e) {
//            throw new RuntimeException(e);
//        }
        return capUser;
    }

    /**
     * 把字符串加密
     *
     * @param attr
     * @return
     */
    public String encodeString(String attr) {
        try {
            attr = encrypt(attr);
        } catch (Exception e) {
        }
        System.out.println("--"+attr);
        return attr;
    }

    // private final static String ENCRYPT_KEY = "cap_user";

    // 加密
    private static String encrypt(String password) throws Exception {
        UserPasswordCipherUtils userPasswordCipherUtils = new UserPasswordCipherUtils();
        // return CryptoUtil.encrypt(password, ENCRYPT_KEY);
        return userPasswordCipherUtils.encrypt(password);
    }

    // 解密
    @SuppressWarnings("unused")
    private static String decrypt(String password) throws Exception {
        // return CryptoUtil.decrypt(password, ENCRYPT_KEY);
        return UserPasswordCipherUtils.decrypt(password);
    }

    /**
     * 以,隔开的字符串转数组
     *
     * @param roles
     * @return
     */
    public String[] roles(String roles) {
        String[] role = roles.split(",");
        return role;
    }
}

