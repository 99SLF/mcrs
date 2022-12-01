/**
 * 主页模块
 */
layui.define(["setter", "admin"], function(exports) {
	var setter = layui.setter;
	var element = layui.element;
	var view = layui.view;
	var $ = layui.$;
	var admin = layui.admin;
	var tabsPage = admin.tabsPage;
	
	var containerId = "#LAY_app_body";
	var tabsId = "layadmin-layout-tabs";
	
	/**
	 * 打开签页
	 * 
	 * @param url 地址
	 * @param text 标题
	 */
	var openTabsPage = function(url, text) {
		var bool = false;
		var tabs = $("#LAY_app_tabsheader>li");
		var attr = url.replace(/(^http(s*):)|(\?[\s\S]*$)/g, "");
		tabs.each(function(index) {
			var elem = $(this);
			var id = elem.attr("lay-id");
			if (id === url) {
				bool = true;
				tabsPage.index = index;
			}
		});
		text = text || "新标签页";
		var tabChange = function() {
			element.tabChange(tabsId, url);
			admin.tabsBodyChange(tabsPage.index, {
				url: url,
				text: text
			});
		};
		if (setter.pageTabs) {
			if (!bool) {
				setTimeout(function() {
					$(containerId).append(['<div class="layadmin-tabsbody-item layui-show">', '<iframe src="' + url +
					        '" frameborder="0" class="layadmin-iframe"></iframe>', "</div>"].join(""));
					tabChange();
				}, 10);
				tabsPage.index = tabs.length;
				element.tabAdd(tabsId, {
					title: "<span>" + text + "</span>",
					id: url,
					attr: attr
				});
			}
		} else {
			var iframe = admin.tabsBody(admin.tabsPage.index).find(".layadmin-iframe");
			iframe[0].contentWindow.location.href = url;
		}
		tabChange();
	};
	
	admin.screen() < 2 && admin.sideFlexible();
	
	// 设定扩展模块的所在目录
	layui.config({
		base: setter.base + "std/dist/modules/"
	});
	
	// 扩展第三方模块
	layui.each(setter.extend, function(index, name) {
		var options = {};
		options[name] = "{/}" + setter.base + "lib/extend/" + name;
		layui.extend(options);
	});
	
	view().autoRender();
	
	// 使用公共模块
	layui.use("common");
	
	var tables = {};
	
	// 扩展主页模块
	exports("index", {
		openTabsPage: openTabsPage,
		data: function(table, settings) {
			if (arguments.length == 1) {
				return tables[table];
			} else if (arguments.length == 2) {
				if (settings == null) {
					delete tables[table];
					return tables[table];
				}
				tables[table] = tables[table] || {};
				tables[table][settings.key] = settings.value;
				return tables[table];
			}
		}
	});
});