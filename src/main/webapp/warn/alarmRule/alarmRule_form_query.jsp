<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 林俊杰
  - Date: 2023-02-03 16:14:20
  - Description:
-->
<head>
<title>预警规则高级查询</title>
<meta charset="utf-8">
<meta name="viewport" content="width=alarmRule-width, initial-scale=1, maximum-scale=1">
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
<div class="layui-form" lay-filter="layuiadmin-alarmRule-form" id="layuiadmin-alarmRule-form">
	<fieldset class="layui-elem-field layui-field-title">
		<legend>高级搜索</legend>
	</fieldset>
	<div class="layui-form-item">
		<label class="layui-form-label">预警规则编码：</label>
		<div class="layui-input-inline">
			<input type="text" name="alarmRuleId" placeholder="" autocomplete="off"
				   class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">预警规则标题：</label>
		<div class="layui-input-inline">
			<input type="text" name="alarmRuleTitle" placeholder="" autocomplete="off"
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
		<label class="layui-form-label">监控层级：</label>
		<div class="layui-input-block" >
			<select name="monitorLevel" id="monitorLevel" lay-filter="monitorLevel" type="select">
				<option value=""></option>
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">规则描述：</label>
		<div class="layui-input-block" >
			<input type="text" name="alarmRuleDescribe" placeholder="" autocomplete="off"
				   class="layui-input">
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
			<input id="ruleMakeFormTime" type="text" class="layui-input" name="makeFormTime" lay-filter="makeFormTime" autocomplete="off" />
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
			<input id="ruleUpdateTime" type="text" class="layui-input" name="updateTime" lay-filter="updateTime" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item layui-hide">
		<div class="layui-inline layui-search" style="padding-left:15px">
			<button id="LAY-app-alarmRule-search-advanced" class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-alarmRule-search-advanced">
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
		elem: "#ruleMakeFormTime",
		type: "date",
		trigger: "click"
	});

	// 更新时间选择器
	laydate.render({
		elem: "#ruleUpdateTime",
		type: "date",
		trigger: "click"
	});

	//获取启用类型的下拉值
	layui.admin.renderDictSelect({
		elem: "#enable",
		dictTypeId: "IS_USE",
	});
	form.render();

	//获取监控层级的下拉值
	layui.admin.renderDictSelect({
		elem: "#monitorLevel",
		dictTypeId: "WARNING_LEVEL",
	});
	form.render();

	
	// 文本框回车事件
	$(".layui-input").on("keydown", function(Rule) {
		if (Rule.keyCode == 13) {
			var submit = $("#LAY-app-alarmRule-search-advanced");
			submit.click();
			return false;
		}
	});

    function SetData(data) {
		win = data.win ? data.win : window;
		var formData = data.data;
		form.val("layuiadmin-alarmRule-form", {
			alarmRuleId: formData.alarmRuleId,
			alarmRuleTitle: formData.alarmRuleTitle,
			enable: formData.enable,
			monitorLevel: formData.monitorLevel,
			alarmRuleDescribe: formData.alarmRuleDescribe,
			createName: formData.createName,
			ruleMakeFormTime: formData.ruleMakeFormTime ? util.toDateString(formData.ruleMakeFormTime, "yyyy-MM-dd") : "",
			updateName: formData.updateName,
			ruleUpdateTime: formData.ruleUpdateTime ? util.toDateString(formData.ruleUpdateTime, "yyyy-MM-dd") : "",
        });
	}
	
	function reset() {
		var formData = {
			alarmRuleId: "",
			alarmRuleTitle: "",
			enable: "",
			monitorLevel: "",
			alarmRuleDescribe: "",
			createName: "",
			ruleMakeFormTime: "",
			updateName: "",
			ruleUpdateTime: ""
		}
		win.setFormData(formData);
	}
	
	//监听提交
	form.on("submit(LAY-app-alarmRule-search-advanced)", function(data) {
		win.setFormData(data.field);
        win.layer.closeAll("iframe");
	});
</script>
</body>
</html>