<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 林俊杰
  - Date: 2023-02-01 10:09:45
  - Description:
-->
<head>
<title>设备交换日志高级查询</title>
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
<div class="layui-form" lay-filter="layuiadmin-deviceExchangeLog-form" id="layuiadmin-deviceExchangeLog-form">
	<fieldset class="layui-elem-field layui-field-title">
		<legend>高级搜索</legend>
	</fieldset>
	<div class="layui-inline">
		<label class="layui-form-label">日志状态：</label>
		<div class="layui-input-block" >
			<select name="logStatus" id="logStatus" lay-filter="logStatus"
					type="select">
				<option value=""></option>
			</select>
		</div>
	</div>

	<div class="layui-inline">
		<label class="layui-form-label">设备资源号：</label>
		<div class="layui-input-block" >
			<input type="text" name="equipmentId" placeholder="" autocomplete="off"
				   class="layui-input">
		</div>
	</div>

	<div class="layui-inline">
		<label class="layui-form-label">设备名称：</label>
		<div class="layui-input-block" >
			<input type="text" name="equipmentName" placeholder="" autocomplete="off"
				   class="layui-input">
		</div>
	</div>

	<div class="layui-form-item">
		<label class="layui-form-label">基地名称：</label>
		<div class="layui-input-block" >
			<input type="text" class="layui-input" name="matrixName" autocomplete="off" />
		</div>
	</div>

	<div class="layui-form-item">
		<label class="layui-form-label">工厂名称：</label>
		<div class="layui-input-block" >
			<input type="text" class="layui-input" name="factoryName" autocomplete="off" />
		</div>
	</div>

	<div class="layui-form-item">
		<label class="layui-form-label">使用工序：</label>
		<div class="layui-input-block" >
			<input type="text" class="layui-input" name="processName" autocomplete="off" />
		</div>
	</div>

	<div class="layui-form-item">
		<label class="layui-form-label">操作类型：</label>
		<div class="layui-input-block">
            <select name="operationType" id="operationType" lay-filter="operationType"
                    type="select">
                <option value=""></option>
            </select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">操作人：</label>
		<div class="layui-input-block">
			<input type="text"  class="layui-input" name="operateName" autocomplete="off" />
		</div>
	</div>

	<div class="layui-form-item">
		<label class="layui-form-label">交互时间：</label>
		<div class="layui-input-block">
			<input id="equipmentExchangeTime" type="text" class="layui-input" name="equipmentExchangeTime" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item layui-hide">
		<div class="layui-inline layui-search" style="padding-left:15px">
			<button id="LAY-app-deviceExchangeLog-search-advanced" class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-deviceExchangeLog-search-advanced">
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

	// 创建时间选择器
	laydate.render({
		elem: "#equipmentExchangeTime",
		type: "date",
		trigger: "click"
	});

	//获取日志状态的下拉值
	layui.admin.renderDictSelect({
		elem: "#logStatus",
		dictTypeId: "LOG_STATUS",
	});
	form.render();

	//获取操作类型的下拉值
	layui.admin.renderDictSelect({
		elem: "#operationType",
		dictTypeId: "OPERATE_TYPE",
	});
	form.render();

	// 文本框回车事件
	$(".layui-input").on("keydown", function(event) {
		if (event.keyCode == 13) {
			var submit = $("#LAY-app-deviceExchangeLog-search-advanced");
			submit.click();
			return false;
		}
	});

    function SetData(data) {
		win = data.win ? data.win : window;
		var formData = data.data;
		form.val("layuiadmin-deviceExchangeLog-form", {
			logStatus: formData.logStatus,
			equipmentId: formData.equipmentId,
			equipmentName: formData.equipmentName,
			matrixName: formData.matrixName,
			factoryName: formData.factoryName,
			processName: formData.processName,
			operationType: formData.operationType,
			operateName: formData.operateName,
			equipmentExchangeTime: formData.equipmentExchangeTime ? util.toDateString(formData.equipmentExchangeTime, "yyyy-MM-dd") : ""
        });
	}

	function reset() {
		var formData = {
			logStatus: "",
			equipmentId: "",
			equipmentName: "",
			matrixName: "",
			factoryName: "",
			processName: "",
			operationType: "",
			operateName: "",
			equipmentExchangeTime: ""
		}
		win.setFormData(formData);
	}

	//监听提交
	form.on("submit(LAY-app-deviceExchangeLog-search-advanced)", function(data) {
		win.setFormData(data.field);
        win.layer.closeAll("iframe");
	});
</script>
</body>
</html>