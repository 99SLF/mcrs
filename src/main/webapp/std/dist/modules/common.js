/**
 * 公共模块
 */
layui.define(function(exports) {
	var admin = (layui.$, layui.layer, layui.laytpl, layui.setter, layui.view, layui.admin);
	admin.events.logout = function() {
		admin.req({
			url: "./com.zimax.components.coframe.auth.LoginManager.logout.biz.ext",
			type: "get",
			data: {},
			done: function(e) {
				admin.exit(function() {
					location.href = layui.setter.base + "coframe/auth/login.jsp";
				});
			}
		});
	},
	
	// 扩展公共模块
	exports("common", {});
});