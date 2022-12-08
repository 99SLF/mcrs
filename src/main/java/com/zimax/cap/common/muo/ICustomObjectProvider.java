package com.zimax.cap.common.muo;

import com.zimax.cap.party.IUserObject;

import java.io.Serializable;

/**
 * @author 苏尚文
 * @date 2022/12/7 9:37
 */
interface ICustomObjectProvider extends Serializable {

    IUserObject getVirtualUserObject(String paramString);

}
