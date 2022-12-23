/**
 * 配置模块
 */
layui.define(["laytpl", "layer", "element", "util"], function(exports) {
	// 扩展配置模块
	exports("setter", {
		// 容器ID
		container: "LAY_app",
		
		// 记录静态资源所在路径
		base: layui.cache.base,
		
		// 动态模板所在目录
		views: layui.cache.base + "std/dist/tpl/",
		
		// 默认视图文件名
		entry: "index",
		
		// 视图文件后缀名
		engine: ".html",
		
		// 是否开启页面选项卡功能。iframe版推荐开启
		pageTabs: true,
		
		name: "RFID运维管理一体平台",
		
		// 本地存储表名
		tableName: "layuiAdmin",
		
		// 模块事件名
		MOD_NAME: "admin",
		
		// 是否开启调试模式。如开启，接口异常时会抛出异常 URL 等信息
		debug: true,
		
		// 自定义请求字段
		request: {
			// 自动携带 token 的字段名（如：access_token）。可设置 false 不携带。
			tokenName: false
		},
		
		// 自定义响应字段
		response: {
			// 数据状态的字段名称
			statusName: "code",
			
			statusCode: {
				// 数据状态一切正常的状态码
				ok: 0,
				
				// 登录状态失效的状态码
				logout: 1001
			},
			
			// 状态信息的字段名称
			msgName: "msg",
			
			// 数据详情的字段名称
			dataName: "data"
		},
		
		/**
		 * 扩展的第三方模块
		 * 
		 * echarts ECHARTS 核心包
		 * echartsTheme ECHARTS 主题
		 */
		extend: ["echarts", "echartsTheme"],
		
		//主题配置
		theme: {
			//内置主题配色方案
			color: [{
				// 主题色
				main: "#20222A",
				
				// 选中色
				selected: "#009688",
				
				// 默认别名
				alias: "default"
			}, {
				main: "#03152A",
				selected: "#3B91FF",
				
				// 藏蓝
				alias: "dark-blue"
			}, {
				main: "#2E241B",
				selected: "#A48566",
				
				// 咖啡
				alias: "coffee"
			}, {
				main: "#50314F",
				selected: "#7A4D7B",
				
				// 紫红
				alias: "purple-red"
			}, {
				main: "#344058",
				logo: "#1E9FFF",
				selected: "#1E9FFF",
				
				// 海洋
				alias: "ocean"
			}, {
				main: "#3A3D49",
				logo: "#2F9688",
				selected: "#5FB878",
				
				// 墨绿
				alias: "green"
			}, {
				main: "#20222A",
				logo: "#F78400",
				selected: "#F78400",
				
				// 橙色
				alias: "red"
			}, {
				main: "#28333E",
				logo: "#AA3130",
				selected: "#AA3130",
				
				// 时尚红
				alias: "fashion-red"
			}, {
				main: "#24262F",
				logo: "#3A3D49",
				selected: "#009688",
				
				// 经典黑
				alias: "classic-black"
			}, {
				logo: "#226A62",
				header: "#2F9688",
				
				// 墨绿头
				alias: "green-header"
			}, {
				main: "#344058",
				logo: "#0085E8",
				selected: "#1E9FFF",
				header: "#1E9FFF",
				
				// 海洋头
				alias: "ocean-header"
			}, {
				header: "#393D49",
				
				// 经典黑头
				alias: "classic-black-header"
			}, {
				main: "#50314F",
				logo: "#50314F",
				selected: "#7A4D7B",
				header: "#50314F",
				
				// 紫红头
				alias: "purple-red-header"
			}, {
				main: "#28333E",
				logo: "#28333E",
				selected: "#AA3130",
				header: "#AA3130",
				
				// 时尚红头
				alias: "fashion-red-header"
			}, {
				main: "#28333E",
				logo: "#009688",
				selected: "#009688",
				header: "#009688",
				
				// 墨绿头
				alias: "green-header"
			}],
			
			// 初始的颜色索引，对应上面的配色方案数组索引
			// 如果本地已经有主题色记录，则以本地记录为优先，除非请求本地数据（localStorage）
			initColorIndex: 0
		}
	});
});