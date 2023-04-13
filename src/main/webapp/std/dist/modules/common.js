/**
 * 公共模块
 */
layui.define(function(exports) {
	var setter = layui.setter;
	var admin = (layui.$, layui.layer, layui.laytpl, layui.view, layui.admin);
	admin.events.logout = function() {
		admin.req({
			url: setter.base + "auth/logout",
			type: "get",
			data: {},
			done: function(e) {
				admin.exit(function() {
					top.location.href = layui.setter.base + "coframe/auth/login.jsp";
				});
			}

		});

	},
	
	// 扩展公共模块
	exports("common", {});
});