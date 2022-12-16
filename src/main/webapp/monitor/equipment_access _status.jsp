<!--
- Author(s): 李伟杰
- Date: 2022-12-05 14:08:11
- Description:
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>设备接入状态</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
	<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.0">
	<style type="text/css">
		html{
			background-color: #fff;
		}
		.layui-tab-item {
			height: 100%;
		}
	</style>
</head>
<body>
<div class="layui-tab" lay-filter="LAY-app-application-tab">
	<ul class="layui-tab-title">
		<li class="layui-this">PLC</li>
		<li>RFID</li>

	</ul>
	<div class="layui-tab-content">
		<div class="layui-tab-item layui-show">
			<iframe src="<%=request.getContextPath()%>/monitor/PLC.jsp" width="100%" height="100%" scrolling="yes" frameborder="0"  ></iframe>
		</div>
		<div class="layui-tab-item">
			<iframe url="<%=request.getContextPath()%>/monitor/RFID.jsp" width="100%" height="100%" scrolling="yes" frameborder="0"  ></iframe>
		</div>
	</div>
</div>
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script>
	var $ = layui.jquery;
	var element = layui.element;

	FrameWH();

	function FrameWH() {
		var parentBody = parent.layui.jquery('.layui-body');
		var tab = $(".layui-tab");
		var tabTitle = $(".layui-tab-title");
		var tabContent = $(".layui-tab-content");
		var height;
		if (parentBody.length > 0) {
			height = parentBody.height() - (tab.outerHeight(true) - tab.height());
		} else {
			height = $(window).height()	- (tab.outerHeight(true) - tab.height()) - 1;
		}
		tab.height(height);
		height = height - tabTitle.outerHeight(true);
		tabContent.height(height);
	}

	$(window).resize(function () {
		FrameWH();
	});

	element.on("tab(LAY-app-application-tab)", function(data) {
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