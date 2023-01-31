<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 林俊杰
  - Date: 2023-1-29 10:01:25
  - Description:
-->
<head>
<title>设备高级查询</title>
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
<div class="layui-form" lay-filter="layuiadmin-equipment-form" id="layuiadmin-equipment-form">
	<fieldset class="layui-elem-field layui-field-title">
		<legend>高级搜索</legend>
	</fieldset>
	<div class="layui-form-item">
		<label class="layui-form-label">设备资源号：</label>
		<div class="layui-input-inline">
			<input type="text" name="equipmentId" placeholder="" autocomplete="off"
				   class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">设备名称：</label>
		<div class="layui-input-inline">
			<input type="text" name="equipmentName" placeholder="" autocomplete="off"
				   class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">启用：</label>
		<div class="layui-input-inline">
			<select name="enable" id="enable" lay-filter="enable" type="select">
				<option value=""></option>
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">设备安装位置：</label>
		<div class="layui-input-block" >
			<input type="text" class="layui-input" name="equipmentInstallLocation" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">设备类型：</label>
		<div class="layui-input-block" >
			<select name="equipTypeName" id="equipTypeName" lay-filter="equipTypeName"
					type="select">
				<option value=""></option>
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">支持通信协议：</label>
		<div class="layui-input-block" >
			<input type="text" class="layui-input" name="protocolCommunication" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">接入点名称：</label>
		<div class="layui-input-block">
			<input type="text"  class="layui-input" name="accPointResName" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">使用工序：</label>
		<div class="layui-input-block">
			<input type="text"  class="layui-input" name="processName" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">创建人：</label>
		<div class="layui-input-block">
			<input type="text"  class="layui-input" name="createName" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">创建时间：</label>
		<div class="layui-input-block">
			<input id="createTime" type="text" class="layui-input" name="createTime" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item layui-hide">
		<div class="layui-inline layui-search" style="padding-left:15px">
			<button id="LAY-app-equipment-search-advanced" class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-equipment-search-advanced">
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
		elem: "#createTime",
		type: "date",
		trigger: "click"
	});


	//获取设备类型类型的下拉值
	layui.admin.renderDictSelect({
		elem: "#equipTypeName",
		dictTypeId: "EQUIPMENT_PROPERTY",
	});
	form.render();


	//获取启用类型的下拉值
	layui.admin.renderDictSelect({
		elem: "#enable",
		dictTypeId: "IS_USE",
	});
	form.render();

	
	// 文本框回车事件
	$(".layui-input").on("keydown", function(event) {
		if (event.keyCode == 13) {
			var submit = $("#LAY-app-equipment-search-advanced");
			submit.click();
			return false;
		}
	});

    function SetData(data) {
		win = data.win ? data.win : window;
		var formData = data.data;
		form.val("layuiadmin-equipment-form", {
			equipmentId: formData.equipmentId,
			equipmentName: formData.equipmentName,
			enable: formData.enable,
			equipmentInstallLocation: formData.equipmentInstallLocation,
			equipTypeName: formData.equipTypeName,
			protocolCommunication: formData.protocolCommunication,
			accPointResName: formData.accPointResName,
			processName: formData.processName,
			createName: formData.createName,
            createTime: formData.createTime ? util.toDateString(formData.createTime, "yyyy-MM-dd") : ""
        });
	}
	
	function reset() {
		var formData = {
			equipmentId: "",
			equipmentName: "",
			enable: "",
			equipmentInstallLocation: "",
			equipTypeName: "",
			protocolCommunication: "",
			accPointResName: "",
			processName: "",
			createName: "",
			createTime: ""
		}
		win.setFormData(formData);
	}
	
	//监听提交
	form.on("submit(LAY-app-equipment-search-advanced)", function(data) {
		win.setFormData(data.field);
        win.layer.closeAll("iframe");
	});
</script>
</body>
</html>