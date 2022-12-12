package com.zimax.components.coframe.auth.intercepter;

import com.zimax.cap.access.http.*;
import com.zimax.cap.common.muo.MUODataContextHelper;
import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.datacontext.IMUODataContext;
import com.zimax.cap.exception.CapRuntimeException;
import com.zimax.cap.party.IUserObject;
import com.zimax.cap.party.Party;
import com.zimax.cap.party.impl.UserObject;
import com.zimax.cap.party.manager.PartyRuntimeManager;
import org.apache.log4j.Logger;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * 用户登录拦截过滤器
 *
 * @author 苏尚文
 * @date 2022/12/2 15:54
 */
public class UserLoginWebInterceptor implements Filter {

	private static final Logger logger = Logger.getLogger(UserLoginWebInterceptor.class);

	// 是否有过滤功能
	public static final String IS_FILTER_FUNCTION_KEY = "IS_FILTER_FUNCTION";

	private static String ORIGINAL_URL = "original_url";

	private boolean hasInit = false;

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {

	}

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;

		HttpSession session = request.getSession(false);
		IMUODataContext muo = null;
		try {
			if (session != null) {
				muo = MUODataContextHelper.create(session);
				DataContextManager.current().setMUODataContext(muo);
				MUODataContextHelper.bind(muo);
				HttpMapContextFactory factory = new HttpMapContextFactory(request, response);
				DataContextManager.current().setMapContextFactory(factory);
			}

			boolean isLogin = isLogin(request, response);
			if (isLogin == true) {
				initContext(request, response, false);
				chain.doFilter(servletRequest, servletResponse);
				return;
			}
			String servletPath = HttpUrlHelper.getRequestUrl(request, response);
			if (logger.isDebugEnabled()) {
				logger.debug("checked url [" + servletPath + "] is exclude ?");
			}

			boolean isExcludeUrl = HttpUrlHelper.isIn(servletPath,
					UserLoginCheckedFilter.getExcludeUrls());
			if (isExcludeUrl == true) {
				chain.doFilter(servletRequest, servletResponse);
				return;
			}

			if (HttpUrlHelper.isIn(servletPath, UserLoginCheckedFilter.getIncludeUrls())) {
				if (logger.isTraceEnabled())
					logger.error("access url [" + servletPath + "] must be login.");
				// 是需要检查的url，并且不在前面的ExcludeUrl中，所以要跳转到错误页面
				ExceptionObject exObj = new ExceptionObject(request);
				exObj.setInvalid(true);
				exObj.setForwardPage("/coframe/auth/noLogin.jsp");
				exObj.setThrowable(new CapRuntimeException(ExceptionConstant.HTTP_12101001));
				request.setAttribute(IS_FILTER_FUNCTION_KEY, "true");
				ThrowableProcessHelper.execute(request, response, exObj, true);
			} else {
				chain.doFilter(servletRequest, servletResponse);
				return;
			}
		} catch (Throwable e) {
			int loopMax = 0;
			while (((e instanceof ServletException)) && (loopMax++ < 10) && (((ServletException) e).getRootCause() != null)) {
				e = ((ServletException) e).getRootCause();
			}
			logger.error(request.getRequestURI(), e);
			if ((e instanceof ServletException)) {
				throw ((ServletException) e);
			}
			throw new ServletException(e);
		} finally {
			if (session != null && muo != null) {
//                MUODataContextHelper.flush(muo, session);
			}
			if (!"true".equals(request.getAttribute("__keepStack"))) {
//                DataContextManager.current().reset();
			}
		}
	}

	@Override
	public void destroy() {

	}

	private boolean isLogin(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession(false);
		if (session == null)
			return false;
		boolean isLogin = false;
		if (session.getAttribute(IUserObject.KEY_IN_CONTEXT) != null
				&& !(session.getAttribute(IUserObject.KEY_IN_CONTEXT) instanceof IUserObject)) {
			throw new CapRuntimeException(ExceptionConstant.HTTP_12101011,
					new String[]{
							IUserObject.class.getName(),
							session.getAttribute(IUserObject.KEY_IN_CONTEXT)
									.getClass().getName()});
		}
		IUserObject userObject = (IUserObject) session
				.getAttribute(IUserObject.KEY_IN_CONTEXT);
		if (userObject != null) {
			if (OnlineUserManager.getUserObjectsByUniqueId(userObject
					.getUniqueId()) != null) {
				isLogin = true;
			}
		}
		return isLogin;
	}

	private void initContext(ServletRequest request, ServletResponse response, boolean isPortal) {
		if (hasInit)
			return;

		HttpServletRequest servletRequest = (HttpServletRequest) request;
		HttpSession session = servletRequest.getSession();
		String userId = null;
		UserObject userObject = null;
		if (isPortal) {
			userId = "guest";
			userObject = new UserObject();
			userObject.setUserId(userId);
		} else {
			userObject = (UserObject) session.getAttribute(IUserObject.KEY_IN_CONTEXT);
			if (userObject == null)
				throw new RuntimeException("userObject not found in session, perhaps not login");
			Object obj = userObject.get("EXTEND_USER_ID");
			if (obj != null) {
				userId = (String) obj;
			} else {
				userId = userObject.getUserId();
			}
		}
		if (userId == null) {
			throw new RuntimeException("Illegal user");
		}

		// 在BPS中此处的userID设置的是人员，需要做额外处理
//        userObject.put(ISystemConstants.USER_ID, userId);
//        // 真正的userId中存储了empId
//        // userObject.setUserId(userId);
////        userObject.put(ISystemConstants.TENENT, getTenantID(servletRequest));
//        // Map<String, List<Party>>map =
//        // PartyRuntimeManager.getInstance().getLoginPartyCache(userId, "user");
//
//        Map<String, List<Party>> map = PartyRuntimeManager.getInstance()
//                .getAllParentPartyList(userId, IConstants.USER_PARTY_TYPE_ID);
//        // if (map.isEmpty()) {
//        // logger.error("The user [" + userId + "] is illegal.");
//        // throw new RuntimeException("Illegal user");
//        // }
//        if (map != null) {
//            Iterator<String> it = map.keySet().iterator();
//            while (it.hasNext()) {
//                String partyTypeID = it.next();
//                List<Party> partyList = map.get(partyTypeID);
//
////                if (partyTypeID.equals(IConstants.USER_PARTY_TYPE_ID)) {
////                    // 用户自身的信息
////                    if (partyList != null && partyList.size() == 1) {
////                        // 表示用户合法
////                        userObject.setUserName(partyList.get(0).getName());
////                        continue;
////                    } else {
////                        logger.error("The user [" + userId + "] is illegal.");
////                        return;
////                    }
////                }
//
////                if (partyTypeID.equals(IConstants.EMP_PARTY_TYPE_ID)) {
////                    if (partyList != null && partyList.size() == 1) {
////                        userObject.setUserId(partyList.get(0).getId());
////                        continue;
////                    }
////                }
//
////                StringBuffer partyIDBuffer = new StringBuffer();
////                for (Party party : partyList) {
////                    partyIDBuffer.append(party.getId()
////                            + com.zimes.cap.auth.IConstants.SPLIET);
////                    // partyIDStr += party.getId() + IConstants.SPLIET;
////                }
//
////                String partyIDStr = partyIDBuffer.toString();
////                if (partyIDStr.endsWith(com.zimes.cap.auth.IConstants.SPLIET)) {
////                    partyIDStr = partyIDStr.substring(0,
////                            partyIDStr.length() - 1);
////                }
//
////                if (IConstants.ROLE_PARTY_TYPE_ID.equals(partyTypeID)) {
////                    userObject.put(com.zimes.cap.auth.IConstants.ROLE_LIST,
////                            partyIDStr);
////                }
//                session.setAttribute(partyTypeID, partyIDStr);
//            }
//        }

		DataContextManager.current().setMapContextFactory(new HttpMapContextFactory(request, response));
		IMUODataContext muo = null;
		if (isPortal) {
			session.setAttribute(IUserObject.KEY_IN_CONTEXT, userObject);
			muo = MUODataContextHelper.create(session);
		}
		DataContextManager.current().setMUODataContext(muo);
		hasInit = true;
	}

}