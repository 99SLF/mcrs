package com.zimax.components.coframe.rights;

import com.zimax.components.coframe.rights.impl.IUserPasswordCipher;

/**
 * @Author 施林丰
 * @Date:2022/12/9 16:04
 * @Description
 */
public class DESedeUserPasswordCipher implements IUserPasswordCipher {
    private final static String ENCRYPT_KEY = "cap_user";

    public String encrypt(String plaintext) throws Exception {
        //return CryptoUtil.encrypt(plaintext, ENCRYPT_KEY);
        return null;
    }

    public String decrypt(String cryptograph) throws Exception {
        //return CryptoUtil.decrypt(cryptograph, ENCRYPT_KEY);
        return null;
    }

}
