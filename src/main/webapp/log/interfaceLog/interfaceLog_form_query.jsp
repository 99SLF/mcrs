<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 林俊杰
  - Date: 2023-1-31 17:13:46
  - Description:
-->
<head>
<title>接口日志高级查询</title>
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
<div class="layui-form" lay-filter="layuiadmin-interfaceLog-form" id="layuiadmin-interfaceLog-form">
	<fieldset class="layui-elem-field layui-field-title">
		<legend>高级搜索</legend>
	</fieldset>
	<div class="layui-inline">
		<label class="layui-form-label">来源：</label>
		<div class="layui-input-block" >
			<select name="source" id="source" lay-filter="source"
					type="select">
				<option value=""></option>
			</select>
		</div>
	</div>

	<div class="layui-inline">
		<label class="layui-form-label">接口类型：</label>
		<div class="layui-input-block" >
			<select name="interfaceType" id="interfaceType" lay-filter="interfaceType"
					type="select">
				<option value=""></option>
			</select>
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
		<label class="layui-form-label">设备资源号：</label>
		<div class="layui-input-block" >
			<input type="text" class="layui-input" name="equipmentId" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">处理结果：</label>
		<div class="layui-input-block">
            <select name="result" id="result" lay-filter="result"
                    type="select">
                <option value=""></option>
            </select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">调用者：</label>
		<div class="layui-input-block">
			<input type="text"  class="layui-input" name="invokerName" autocomplete="off" />
		</div>
	</div>

	<div class="layui-form-item">
		<label class="layui-form-label">处理时长：</label>
		<div class="layui-input-block">
			<input type="text"  class="layui-input" name="disposeTime" autocomplete="off" />
		</div>
	</div>

	<div class="layui-form-item">
		<label class="layui-form-label">接口名称：</label>
		<div class="layui-input-block">
			<input type="text"  class="layui-input" name="interfaceName" autocomplete="off" />
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
			<button id="LAY-app-interfaceLog-search-advanced" class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-interfaceLog-search-advanced">
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
		elem: "#createTime",
		type: "date",
		trigger: "click"
	});

	//获取接口类型的下拉值
	layui.admin.renderDictSelect({
		elem: "#interfaceType",
		dictTypeId: "API_TYPE",
	});
	form.render();

	//获取来源的下拉值
	layui.admin.renderDictSelect({
		elem: "#source",
		dictTypeId: "SOURCE",
	});
	form.render();

    //获取处理结果的下拉值
    layui.admin.renderDictSelect({
        elem: "#result",
        dictTypeId: "DISPOSE_RESULT",
    });
    form.render();

	// 文本框回车事件
	$(".layui-input").on("keydown", function(event) {
		if (event.keyCode == 13) {
			var submit = $("#LAY-app-interfaceLog-search-advanced");
			submit.click();
			return false;
		}
	});

    function SetData(data) {
		win = data.win ? data.win : window;
		var formData = data.data;
		form.val("layuiadmin-interfaceLog-form", {
			source: formData.source,
			equipmentId: formData.equipmentId,
			equipmentName: formData.equipmentName,
			interfaceType: formData.interfaceType,
			result: formData.result,
			invokerName: formData.invokerName,
			disposeTime: formData.disposeTime,
			interfaceName: formData.interfaceName,
			createTime: formData.createTime ? util.toDateString(formData.createTime, "yyyy-MM-dd") : ""
        });
	}

	function reset() {
		var formData = {
			source: "",
			equipmentId: "",
			equipmentName: "",
			interfaceType: "",
			result: "",
			invokerName: "",
			disposeTime: "",
			interfaceName: "",
			createTime: ""
		}
		win.setFormData(formData);
	}

	//监听提交
	form.on("submit(LAY-app-interfaceLog-search-advanced)", function(data) {
		win.setFormData(data.field);
        win.layer.closeAll("iframe");
	});
</script>
</body>
</html>