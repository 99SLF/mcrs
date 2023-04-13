<!--
- Author(s): 李伟杰
- Date: 2023-4-13 14:12:11
- Description:
-->
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>文本弹窗</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/custom.css?v1">
<style type="text/css">
.layui-card {
	margin-bottom: 0px;
}
</style>
</head>
<body style="height: 100%">
<div class="layui-card" style="height: 100%">
	<div class="layui-form layui-card-header layuiadmin-card-header-auto" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list">
				<textarea name="text" class="layui-textarea" disabled="disabled" style="height: 428px"></textarea>
	</div>
</div>
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script>
	layui.config({
		base: "<%=request.getContextPath()%>/"
	});
</script>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
<script type="text/javascript">
	var layer = layui.layer;
	var table = layui.table;
	var form = layui.form;
	var $ = layui.jquery;	
	
	var win=null;
	function SetData(data) {
		win = data.win ? data.win : window;	
		var data = data.data;
		form.val("layuiadmin-app-form-list", {
			"text": data,
		});
	}
	
</script>
</body>
</html>