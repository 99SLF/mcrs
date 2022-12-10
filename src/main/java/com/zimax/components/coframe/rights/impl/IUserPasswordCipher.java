package com.zimax.components.coframe.rights.impl;

/**
 * @Author 施林丰
 * @Date:2022/12/9 9:53
 * @Description
 */
public interface IUserPasswordCipher {
    String encrypt(String plaintext) throws Exception;

    String decrypt(String cryptograph) throws Exception;
}
