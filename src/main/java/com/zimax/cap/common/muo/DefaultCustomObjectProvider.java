package com.zimax.cap.common.muo;

import com.zimax.cap.common.muo.impl.MUOConfig;
import com.zimax.cap.party.IUserObject;
import com.zimax.cap.party.impl.UserObject;

import java.util.UUID;

/**
 * @author 苏尚文
 * @date 2022/12/7 9:41
 */
public class DefaultCustomObjectProvider implements ICustomObjectProvider {

    private static final long serialVersionUID = 1L;

    public IUserObject getVirtualUserObject(String userType) {
        try {
            IUserObject uo = MUOConfig.getInstance().getVirtualUserObject(userType);
            if (uo != null) {
                UserObject cloned = (UserObject) uo.clone();
//                cloned.setUniqueId(DataUtil.createID());
                cloned.setUniqueId(UUID.randomUUID().toString().replace("-", "").toLowerCase());
                return cloned;
            }
            return null;
        } catch (CloneNotSupportedException e) {
            e.printStackTrace();
        }
        return MUOConfig.getInstance().getVirtualUserObject(userType);
    }
}
