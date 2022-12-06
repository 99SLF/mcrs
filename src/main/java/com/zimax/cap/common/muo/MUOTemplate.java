package com.zimax.cap.common.muo;

import com.zimax.cap.datacontext.DataContextService;
import com.zimax.cap.datacontext.IMUODataContext;
import com.zimax.cap.datacontext.IMapContextFactory;

import javax.servlet.http.HttpSession;

/**
 * @author 苏尚文
 * @date 2022/12/5 16:12
 */
public class MUOTemplate {

    public static Object execute(HttpSession session, MUOCallback callback)
            throws Throwable {
        IMapContextFactory factory = null;
        Object result = null;
        IMUODataContext oldMuo = DataContextService.current().getMUODataContext();
        try {
            IMUODataContext muo = MUODataContextHelper.create(session);
            factory = MUODataContextHelper.bind(muo);
            result = callback.run();
            MUODataContextHelper.flush(muo, session);
        } finally {
            MUODataContextHelper.unbind(factory);
            DataContextService.current().setMUODataContext(oldMuo);
        }
        return result;
    }

    public static Object execute(IMUODataContext muo, MUOCallback callback)
            throws Throwable {
        IMapContextFactory factory = null;
        Object result = null;
        IMUODataContext oldMuo = DataContextService.current().getMUODataContext();
        try {
            factory = MUODataContextHelper.bind(muo);
            result = callback.run();
        } finally {
            MUODataContextHelper.unbind(factory);
            DataContextService.current().setMUODataContext(oldMuo);
        }
        return result;
    }
}
