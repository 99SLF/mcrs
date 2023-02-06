<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 林俊杰
  - Date: 2023-02-03 14:54:20
  - Description:
-->
<head>
<title>预警事件高级查询</title>
<meta charset="utf-8">
<meta name="viewport" content="width=alarmEvent-width, initial-scale=1, maximum-scale=1">
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
<div class="layui-form" lay-filter="layuiadmin-alarmEvent-form" id="layuiadmin-alarmEvent-form">
	<fieldset class="layui-elem-field layui-field-title">
		<legend>高级搜索</legend>
	</fieldset>
	<div class="layui-form-item">
		<label class="layui-form-label">预警事件编码：</label>
		<div class="layui-input-inline">
			<input type="text" name="alarmEventId" placeholder="" autocomplete="off"
				   class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">预警事件标题：</label>
		<div class="layui-input-inline">
			<input type="text" name="alarmEventTitle" placeholder="" autocomplete="off"
				   class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">启用：</label>
		<div class="layui-input-inline">
			<select name="enableStatus" id="enableStatus" lay-filter="enableStatus" type="select">
				<option value=""></option>
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">预警级别：</label>
		<div class="layui-input-block" >
			<select name="alarmLevel" id="alarmLevel" lay-filter="alarmLevel" type="select">
				<option value=""></option>
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">预警类型：</label>
		<div class="layui-input-block" >
			<select name="alarmType" id="alarmType" lay-filter="alarmType" type="select">
				<option value=""></option>
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">创建人：</label>
		<div class="layui-input-block">
			<input type="text" name="createName" placeholder="" autocomplete="off"
				   class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">创建时间：</label>
		<div class="layui-input-block">
			<input id="makeFormTime" type="text" class="layui-input" name="makeFormTime" lay-filter="makeFormTime" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">修改人：</label>
		<div class="layui-input-block">
			<input type="text" name="updateName" placeholder="" autocomplete="off"
				   class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">修改时间：</label>
		<div class="layui-input-block">
			<input id="updateTime" type="text" class="layui-input" name="updateTime" lay-filter="updateTime" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item layui-hide">
		<div class="layui-inline layui-search" style="padding-left:15px">
			<button id="LAY-app-alarmEvent-search-advanced" class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-alarmEvent-search-advanced">
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
	
	// 制单时间选择器
	laydate.render({
		elem: "#makeFormTime",
		type: "date",
		trigger: "click"
	});

	// 更新时间选择器
	laydate.render({
		elem: "#updateTime",
		type: "date",
		trigger: "click"
	});


	//获取预警级别的下拉值
	layui.admin.renderDictSelect({
		elem: "#alarmLevel",
		dictTypeId: "WARNING_LEVEL",
	});
	form.render();


	//获取启用类型的下拉值
	layui.admin.renderDictSelect({
		elem: "#enableStatus",
		dictTypeId: "IS_USE",
	});
	form.render();

	//获取预警类型的下拉值
	layui.admin.renderDictSelect({
		elem: "#alarmType",
		dictTypeId: "WRANING_TYPE",
	});
	form.render();

	
	// 文本框回车事件
	$(".layui-input").on("keydown", function(event) {
		if (event.keyCode == 13) {
			var submit = $("#LAY-app-alarmEvent-search-advanced");
			submit.click();
			return false;
		}
	});

    function SetData(data) {
		win = data.win ? data.win : window;
		var formData = data.data;
		form.val("layuiadmin-alarmEvent-form", {
			alarmEventId: formData.alarmEventId,
			alarmEventTitle: formData.alarmEventTitle,
			enableStatus: formData.enableStatus,
			alarmLevel: formData.alarmLevel,
			alarmType: formData.alarmType,
			createName: formData.createName,
			makeFormTime: formData.makeFormTime ? util.toDateString(formData.makeFormTime, "yyyy-MM-dd") : "",
			updateName: formData.updateName,
			updateTime: formData.updateTime ? util.toDateString(formData.updateTime, "yyyy-MM-dd") : "",
        });
	}
	
	function reset() {
		var formData = {
			alarmEventId: "",
			alarmEventTitle: "",
			enableStatus: "",
			alarmLevel: "",
			alarmType: "",
			createName: "",
			makeFormTime: "",
			updateName: "",
			updateTime: ""
		}
		win.setFormData(formData);
	}
	
	//监听提交
	form.on("submit(LAY-app-alarmEvent-search-advanced)", function(data) {
		win.setFormData(data.field);
        win.layer.closeAll("iframe");
	});
</script>
</body>
</html>