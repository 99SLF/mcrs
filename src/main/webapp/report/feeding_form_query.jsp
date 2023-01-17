<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 苏尚文
  - Date: 2022-10-11 10:01:25
  - Description:
-->
<head>
<title>销售信息高级查询</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.0">
<style>
	.layui-form {
        padding-top: 5px !important;
        padding-left: 5px !important;
        padding-right: 5px !important;
	}
	.layui-form-item {
		margin-bottom: 10px !important;
	}
	.layui-form-label {
		width: 100px !important;
		padding: 5px 0px !important;
	}
	.layui-input {
		height: 30px !important;
	}
</style>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-feeding-form" id="layuiadmin-feeding-form">
	<fieldset class="layui-elem-field layui-field-title">
		<legend>高级搜索</legend>
	</fieldset>
	<div class="layui-form-item">
		<label class="layui-form-label">设备资源号：</label>
		<div class="layui-input-block">
			<input type="text" class="layui-input" name="equipmentId" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">轴名称：</label>
		<div class="layui-input-block">
			<input type="text" class="layui-input" name="axisName" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">生产SFC编码：</label>
		<div class="layui-input-block">
			<input type="text" class="layui-input" name="prodSFCId" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">载具码：</label>
		<div class="layui-input-block" >
			<input type="text" class="layui-input" name="vehicleCode" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">开始时间：</label>
		<div class="layui-input-block">
			<input id="startProdTime" type="text"  class="layui-input" name="startProdTime" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">结束时间：</label>
		<div class="layui-input-block">
			<input id="endProdTime" type="text" class="layui-input" name="endProdTime" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item layui-hide">
		<div class="layui-inline layui-search" style="padding-left:15px">
			<button id="LAY-app-feeding-search-advanced" class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-feeding-search-advanced">
				<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
			</button>
		</div>
	</div>
</div>
<script src="<%=request.getContextPath()%>/common/layui/layui.all.js"></script>
<script>
	layui.config({
		base: "<%=request.getContextPath()%>/"
	});
</script>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
<script type="text/javascript">
	var layer = layui.layer;
	var form = layui.form;
	var $ = layui.jquery;
	var laydate = layui.laydate;
	var util = layui.util;
	
	var win = null;
	
	// 开始时间选择器
	laydate.render({
		elem: "#startProdTime",
		type: "date",
		trigger: "click"
	});
	
	// 结束时间选择器
	laydate.render({
		elem: "#endProdTime",
		type: "date",
		trigger: "click"
	});
	
	// 文本框回车事件
	$(".layui-input").on("keydown", function(event) {
		if (event.keyCode == 13) {
			var submit = $("#LAY-app-feeding-search-advanced");
			submit.click();
			return false;
		}
	});

    function SetData(data) {
		win = data.win ? data.win : window;
		var formData = data.data;
		form.val("layuiadmin-feeding-form", {
            equipmentId: formData.equipmentId,
            axisName: formData.axisName,
            prodSFCId: formData.prodSFCId,
            vehicleCode: formData.vehicleCode,
            startProdTime: formData.startProdTime ? util.toDateString(formData.startProdTime, "yyyy-MM-dd") : "",
            endProdTime: formData.endProdTime ? util.toDateString(formData.endProdTime, "yyyy-MM-dd") : ""
        });
	}
	
	function reset() {
		var formData = {
            equipmentId: "",
            axisName: "",
            prodSFCId: "",
            vehicleCode: "",
            startProdTime: "",
            endProdTime: ""
		}
		win.setFormData(formData);
	}
	
	//监听提交
	form.on("submit(LAY-app-feeding-search-advanced)", function(data) {
		win.setFormData(data.field);
        win.layer.closeAll("iframe");
	});
</script>
</body>
</html>