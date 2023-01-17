<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.zimax.components.coframe.tools.tab.TabPageManager"%>
<%@page import="com.zimax.components.coframe.tools.tab.TabPage"%>
<% List<TabPage> tabList = TabPageManager.INSTANCE.getTabPageList("AuthTab");%>
<!DOCTYPE html">
<html>
<head>
<meta charset="utf-8">
<title>角色授权</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css" media="all">
<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.2">
</head>
<body>
<div class="layui-fluid">
	<div class="layui-row layui-col-space10" >
		<div class="layui-col-md5" >
			<div class="layui-card" >		
				<div class="layui-form layui-card-header layuiadmin-card-header-auto">
					<div class="layui-form-item" >角色授权</div>					
					<div class="layui-form-item">
						<div class="layui-inline">
							<input type="text" name="roleCode" value="" placeholder="角色代码" autocomplete="off" class="layui-input">
						</div>
						<div class="layui-inline">
							<input type="text" name="roleName" value="" placeholder="角色名称" autocomplete="off" class="layui-input">
						</div>
						<div class="layui-inline layui-search">
							<button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-rolelist-search" id="LAY-app-rolelist-search">
								<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
							</button>
						</div>
					</div>
				</div>
				<div class="layui-card-body" id="layui-card-body01">
					<table id="LAY-app-role-list" lay-filter="LAY-app-role-list"></table>
					<script type="text/html" id="table-role-list">
						<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="authConfig"><i class="layui-icon layui-icon-edit"></i>配置</a>
					</script>
				</div>
			</div>
		</div>
		<div class="layui-col-md7" >
			<div class="layui-card">
				<div class="layui-card-body" id="layui-card-body02">
					<div class="layui-tab" lay-filter="LAY-app-role-tab">
						<ul class="layui-tab-title">
							<%
								for (int i = 0; i < tabList.size(); i++) {
									TabPage tab = tabList.get(i);
							%>
								<li <% if (i == 0) { %>class="layui-this"<% } %>><%= tab.getTitle() %></li>
							<%
								}
							%>
						</ul>
						<div class="layui-tab-content">
							<%
								for (int i = 0; i < tabList.size(); i++) {
									TabPage tab = tabList.get(i);
							%>
								<div class="layui-tab-item<% if (i == 0) { %> layui-show<% } %>">
									<iframe id="<%=tab.getId() %>" width=100% height= 100% scrolling="yes" frameborder="0" ></iframe>
								</div>
							<%
								}
							%>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script>
	var layer = layui.layer;
	var form = layui.form;
	var table = layui.table;
	var $ = layui.jquery;
	var element = layui. element;
	
	//监听搜索
	form.on("submit(LAY-app-rolelist-search)", function(data) {
		var field = data.field;
		table.reload("LAY-app-role-list", {
			where: field,
		});
	});
	
	//文本框回车事件
	$(".layui-input").on("keydown", function(event) {
		if (event.keyCode == 13) {
			var submit = $("#LAY-app-rolelist-search");
			submit.click();
			return false;
		}
	});
	
	FrameWH();
	
	function FrameWH() {
		var parentBody = parent.layui.jquery('.layui-body');
		var tab = $(".layui-tab");
		var row = $(".layui-row");
		var cardBody = $("#layui-card-body02");
		var tabTitle = $(".layui-tab-title");
		var tabContent = $(".layui-tab-content");
		var fluid = $(".layui-fluid");
		var colHeight = $(".layui-col-md7");
		var height;
		if (parentBody.length > 0) {
			height = parentBody.height();
		} else {
			height = $(window).height() - 92;
		}
		height = height - (tab.outerHeight(true) - tab.height()) - (fluid.outerHeight(true) - fluid.height()) - (colHeight.outerHeight(true) - colHeight.height()) - (row.outerHeight(true) - row.height()) - (cardBody.outerHeight(true) - cardBody.height());
		tab.height(height);
		height = height - tabTitle.outerHeight(true) - (colHeight.outerHeight(true) - colHeight.height());
		tabContent.height(height);
	}
	
	$(window).resize(function () {
		FrameWH();
	});
	
	function getFullSize() {
		var parentBody = parent.layui.jquery('.layui-body');
		var header = $(".layui-card-header");
		var cardbody = $("#layui-card-body01");
		var fluid = $(".layui-fluid");
		var row = $(".layui-row");
		var colHeight = $(".layui-col-md5");
		var height;
		if (parentBody.length > 0) {
			height = parentBody.height();
		} else {
			height = $(window).height();
		}
		return height - (header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height()) + (fluid.outerHeight(true) - fluid.height()) + (colHeight.outerHeight(true) - colHeight.height()) + (row.outerHeight(true) - row.height()) + 1);
	}
	
	$(window).resize(function () {
		table.reload("LAY-app-role-list", {
			height: getFullSize()
		});
	});
	
	
	table.render({
		elem: "#LAY-app-role-list",
		url: "<%= request.getContextPath() %>/rights/role/query",
		height: getFullSize(),
		parseData: function(res) {
			return {
				code: "0", //解析接口状态
				msg: res.msg, //解析提示文本
				count: res.totol, //解析数据长度
				data: res.data, //解析数据列表
			};
		},
		cols : [[{
			field: "roleCode",
			minWidth: 120,
			title: "角色代码",
			align: "left"
		}, {
			field: "roleName",
			minWidth: 120,
			title: "角色名称",
			align: "left"
		}, {
			minWidth: 100,
			title: "授权配置",
			align: "center",
			fixed: "right",
			toolbar: "#table-role-list"
		}]]
	});

	//监听操作事件
	table.on('tool(LAY-app-role-list)', function(obj) {
		var data = obj.data;
		if (obj.event === "authConfig") {
			authConfig(data);
		}
	});
	
	function authConfig(data) {
		var paramObj = {
			roleId: data.roleId
		};
		reloadTab(paramObj);
	}
	
	var authTabArray = [];
<%
	for (TabPage tab : tabList) {
%>
	var <%= tab.getId() %> = {
		name: "<%= tab.getId() %>",
		title: "<%= tab.getTitle() %>",
		path: "<%=request.getContextPath() %><%= tab.getUrl() %>"
	};
	authTabArray.push(<%= tab.getId() %>);
<%
	}
%>
	
	function reloadTab(paramObj) {
		var iframe = $(".layui-tab-item.layui-show").find("iframe");
		for (var i = 0; i < authTabArray.length; i++) {
			var authTabElem = authTabArray[i];
			var settingTab = $("#" + authTabElem.name);
			settingTab.attr("url", setUrlParam(authTabElem.path, paramObj));
		}
		iframe.attr("src", iframe.attr("url"));
	}
	
	function setUrlParam(url, paramObj) {
		if (!url) {
			return url;
		}
		var params = [];
		for (var pop in paramObj) {
			params.push(pop + "=" + paramObj[pop]);
		}
		var paramStr = params.join("&");
		if (url.indexOf("?") >= 0) {
			return url + "&" + paramStr;
		} else {
			return url + "?" + paramStr;
		}
	}
	
	element.on("tab(LAY-app-role-tab)", function(data) {
		var iframe = $(data.elem.find("iframe")[data.index]);
		var src = iframe.attr("src");
		var url = iframe.attr("url");
		if (src !== url) {
			iframe.attr("src", url);
		}
	});
</script>
</body>
</html>