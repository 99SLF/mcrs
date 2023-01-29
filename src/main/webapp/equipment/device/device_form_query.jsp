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
<title>终端高级查询</title>
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
<div class="layui-form" lay-filter="layuiadmin-device-form" id="layuiadmin-device-form">
	<fieldset class="layui-elem-field layui-field-title">
		<legend>高级搜索</legend>
	</fieldset>
	<div class="layui-form-item">
		<label class="layui-form-label">终端名称：</label>
		<div class="layui-input-inline">
			<input type="text" name="deviceName" placeholder="" autocomplete="off"
				   class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">终端类型：</label>
		<div class="layui-input-inline">
			<select name="deviceSoftwareType" id="deviceSoftwareType" lay-filter="deviceSoftwareType"
					type="select">
				<option value=""></option>
			</select>
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
		<label class="layui-form-label">版本号：</label>
		<div class="layui-input-block" >
			<input type="text" class="layui-input" name="version" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">需要更新：</label>
		<div class="layui-input-block" >
			<select name="needUpdate" id="needUpdate" lay-filter="needUpdate"
					type="select">
				<option value="">请选择</option>
				<option value="是">是</option>
				<option value="否">否</option>
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">注册状态：</label>
		<div class="layui-input-block">
			<select name="registerStatus" id="registerStatus" lay-filter="registerStatus" type="select">
				<option value=""></option>
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">程序安装路径：</label>
		<div class="layui-input-block">
			<input type="text"  class="layui-input" name="programInstallationPath" autocomplete="off" />
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
			<button id="LAY-app-device-search-advanced" class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-device-search-advanced">
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


	//获取软件类型的下拉值
	layui.admin.renderDictSelect({
		elem: "#deviceSoftwareType",
		dictTypeId: "DEVICE_SOFTWARE_TYPE",
	});
	form.render();


	//获取启用类型的下拉值
	layui.admin.renderDictSelect({
		elem: "#enable",
		dictTypeId: "IS_USE",
	});
	form.render();

	//获取注册状态的下拉值
	layui.admin.renderDictSelect({
		elem: "#registerStatus",
		dictTypeId: "REGISTER_STATUS",
	});
	form.render();

	
	// 文本框回车事件
	$(".layui-input").on("keydown", function(event) {
		if (event.keyCode == 13) {
			var submit = $("#LAY-app-device-search-advanced");
			submit.click();
			return false;
		}
	});

    function SetData(data) {
		win = data.win ? data.win : window;
		var formData = data.data;
		form.val("layuiadmin-device-form", {
			deviceName: formData.deviceName,
			deviceSoftwareType: formData.deviceSoftwareType,
			enable: formData.enable,
            version: formData.version,
            needUpdate: formData.needUpdate,
            registerStatus: formData.registerStatus,
            programInstallationPath: formData.programInstallationPath,
            createTime: formData.createTime ? util.toDateString(formData.createTime, "yyyy-MM-dd") : ""
        });
	}
	
	function reset() {
		var formData = {
			deviceName: "",
			deviceSoftwareType: "",
			enable: "",
			version: "",
			needUpdate: "",
			registerStatus: "",
			programInstallationPath: "",
			createTime: ""
		}
		win.setFormData(formData);
	}
	
	//监听提交
	form.on("submit(LAY-app-device-search-advanced)", function(data) {
		win.setFormData(data.field);
        win.layer.closeAll("iframe");
	});
</script>
</body>
</html>