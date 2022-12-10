package com.zimax.components.coframe.rights;

import com.zimax.cap.utility.CryptoUtil;
import com.zimax.components.coframe.rights.impl.IUserPasswordCipher;

/**
 * @Author 施林丰
 * @Date:2022/12/9 16:04
 * @Description
 */
public class DESedeUserPasswordCipher implements IUserPasswordCipher {
    private final static String ENCRYPT_KEY = "cap_user";

    public String encrypt(String plaintext) throws Exception {
        CryptoUtil cryptoUtil = new CryptoUtil();
        return cryptoUtil.encrypt(plaintext, ENCRYPT_KEY);
    }

    public String decrypt(String cryptograph) throws Exception {
        CryptoUtil cryptoUtil = new CryptoUtil();
        return cryptoUtil.decrypt(cryptograph, ENCRYPT_KEY);
    }

}
