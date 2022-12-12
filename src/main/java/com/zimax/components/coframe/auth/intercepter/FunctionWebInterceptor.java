package com.zimax.components.coframe.auth.intercepter;

import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.zimax.cap.common.muo.MUODataContextHelper;
import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.datacontext.IMUODataContext;
import com.zimax.cap.management.resource.IManagedResource;
import com.zimax.cap.management.resource.manager.ResourceRuntimeManager;
import com.zimax.cap.party.Party;
import com.zimax.cap.party.impl.UserObject;
import com.zimax.cap.utility.StringUtil;
import com.zimax.components.coframe.auth.menu.DefaultMenuAuthService;
import com.zimax.components.coframe.framework.constants.IAppConstants;
import com.zimax.components.coframe.tools.IAuthConstants;
import com.zimax.components.coframe.tools.IConstants;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 功能拦截器
 *
 * @author 苏尚文
 * @date 2022/12/10 14:16
 */
public class FunctionWebInterceptor implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {

	}

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;

		request.setCharacterEncoding("UTF-8");
		if ("true".equals(request.getAttribute(UserLoginWebInterceptor.IS_FILTER_FUNCTION_KEY))) {
			chain.doFilter(servletRequest, servletResponse);
			return;
		}

		IMUODataContext muo = MUODataContextHelper.create(request.getSession());
		DataContextManager.current().setMUODataContext(muo);

		String resId = request.getParameter(IAuthConstants.FUNCTION_PARAN_RESOURCE_ID);
		String resType = request.getParameter(IAuthConstants.FUNCTION_PARAM_REAOURCE_TYPE);
		if (StringUtil.isNotEmpty(resType) && !IAuthConstants.FUNCTION_TO_RESOURCE_TYPE.equals(resType)) {
			chain.doFilter(servletRequest, servletResponse);
			return;
		}

		IManagedResource managedResource = null;
		if (StringUtils.isBlank(resId) || StringUtils.isBlank(resType)) {
			managedResource = getManagedResource(request);
		} else {
			managedResource = ResourceRuntimeManager.getInstance().getManagedResource(resId, resType);
		}

		if (hasPermission(managedResource, request)) {
			chain.doFilter(servletRequest, servletResponse);
		} else {
			String servletPath = request.getServletPath();
			int index = servletPath.lastIndexOf(".");
			if (".ext".equals(servletPath.substring(index))) {
				response.setStatus(401);
				boolean isAjaxRequest = false;
				if (!StringUtils.isBlank(request.getHeader("x-requested-with"))
						&& request.getHeader("x-requested-with").equals(
						"XMLHttpRequest")) {
					isAjaxRequest = true;
				}
				String msg = "对不起，您没有操作权限！";
				if (isAjaxRequest) {
					response.setCharacterEncoding("utf-8");
				} else {
					response.setCharacterEncoding("gbk");
				}
				response.getWriter().write(msg);
			} else {
				request.getRequestDispatcher("/coframe/auth/noAuth.jsp").forward(request, response);
			}
		}
	}

	@Override
	public void destroy() {

	}

	/**
	 * 判断是否拥有访问该角色的权限
	 *
	 * @param managedResource
	 * @param request
	 * @return
	 */
	public boolean hasPermission(IManagedResource managedResource, HttpServletRequest request) {
		if (managedResource == null) {
			return true;
		} else if (managedResource != null && "0".equals(managedResource.getAttribute(IAppConstants.FUNCTION_IS_CHECK))) {
			return true;
		}
		UserObject userObject = (UserObject) request.getSession().getAttribute("userObject");
		String roleIds = (String) userObject.get(IConstants.ROLE_LIST);
		List<Party> roles = new ArrayList<Party>();
		if (roleIds != null) {
			String[] roleIdArr = roleIds.split(com.zimax.cap.auth.IConstants.SPLIET);
			for (String roleId : roleIdArr) {
				if (!StringUtils.isBlank(roleId)) {
					roles.add(new Party(IConstants.ROLE_PARTY_TYPE_ID, roleId, roleId, roleId));
				}
			}
		}
		String funcCode = managedResource.getResourceID();
		if (managedResource.getParent() != null) {
			funcCode = managedResource.getParent().getResourceID();
		}
		DefaultMenuAuthService menuAuthService = new DefaultMenuAuthService(roles);
		if (menuAuthService.canAccessFunction(funcCode)) {
			return true;
		}
		return false;
	}

	/**
	 * 获得功能资源
	 *
	 * @param request
	 * @return
	 */
	public IManagedResource getManagedResource(HttpServletRequest request) {
		String servletPath = request.getServletPath();
		List<IManagedResource> resources = ResourceRuntimeManager.getInstance().getRootManagedResourceListByType(IAuthConstants.FUNCTION_TO_RESOURCE_TYPE);
		for (IManagedResource resource : resources) {
			String funcAction = resource.getAttribute(IAppConstants.FUNCTION_URL);
			if (StringUtil.isNotEmpty(funcAction)) {
				String funcURI = StringUtil.substringBefore(funcAction, "?");
				if (StringUtil.contains(servletPath, funcURI)) {
					String funcParam = resource.getAttribute(IAppConstants.FUNCTION_PARA_INFO);
					Map paramMap = request.getParameterMap();
					if (funcParam == null) {
						return resource;
					} else if (isContain(paramMap, funcParam)) {
						return resource;
					}
				}
			}
		}
		return null;
	}

	/**
	 * 判断用户请求某功能的参数中是否包含该功能所必需参数
	 *
	 * @param paramMap
	 *            用户请求参数Map
	 * @param funcParam
	 *            功能必需参数
	 * @return true 包含
	 */
	public boolean isContain(Map paramMap, String funcParam) {
		String[] funcParams = funcParam.split("&");
		boolean bool = true;
		for (int i = 0; i < funcParams.length; i++) {
			if (!StringUtil.isBlank(funcParams[i])) {
				bool = false;
				String[] params = funcParams[i].split("=");
				if (!StringUtil.isBlank(params[0])) {
					Object obj = paramMap.get(params[0]);
					if (obj == null)
						continue;
					String paramValue = ((String[]) obj)[0];
					if (!StringUtil.isBlank(paramValue)) {
						if (paramValue.equals(params[1])) {
							bool = true;
						}
					} else if (StringUtil.isBlank(params[1])) {
						bool = true;
					}
				} else {
					bool = true;
				}
			}
		}
		return bool;
	}
}
