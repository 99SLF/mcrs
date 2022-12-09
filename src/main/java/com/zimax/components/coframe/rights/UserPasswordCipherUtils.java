package com.zimax.components.coframe.rights;

import com.zimax.components.coframe.rights.impl.IUserPasswordCipher;

/**
 * @Author 施林丰
 * @Date:2022/12/9 9:49
 * @Description
 */
public class UserPasswordCipherUtils {

    private static IUserPasswordCipher cipher;

    public static String encrypt(String password) throws Exception {
        if (cipher == null) {
            throw new NullPointerException("The UserPasswordCipher is null.");
        }
        return cipher.encrypt(password);
    }

    public static String decrypt(String password) throws Exception {
        if (cipher == null) {
            throw new NullPointerException("The UserPasswordCipher is null.");
        }
        return cipher.decrypt(password);
    }

    public static IUserPasswordCipher getCipher() {
        return cipher;
    }

    public static void setCipher(IUserPasswordCipher cipher) {
        UserPasswordCipherUtils.cipher = cipher;
    }
}
