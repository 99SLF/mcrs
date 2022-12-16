<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 林俊杰
  - Date: 2022-12-01 15:57:53
  - Description:
-->
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
<title>预警规则添加</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
	 style="padding: 20px 30px 0 0;">
	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label" style="width: auto">预警规则标题:</label>
			<div class="layui-input-block">
				<input id="alarmRuleTitle" type="text" name="alarmRuleTitle" lay-verify="required"
					   placeholder="预警规则标题" autocomplete="off" class="layui-input" style="width:96%">
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label">监控层级:<span style="color:red">*</span></label>
			<div class="layui-input-block">
				<input id="monitorLevel" type="text" name="monitorLevel" lay-verify="" placeholder=""
					   autocomplete="off" class="layui-input">
			</div>
		</div>
	</div>

	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label">规则描述:<span style="color:red">*</span></label>
			<div class="layui-input-block">
				<input id="alarmRuleDescribe" type="text" name="alarmRuleDescribe" lay-verify="required"
					   placeholder="" autocomplete="off" class="layui-input">
			</div>
		</div>

		<div class="layui-col-sm6">
			<label class="layui-form-label" style="width: 100px">预警事件编码:</label>
			<div class="layui-input-block">
				<input id="alarmEventId" type="text" name="alarmEventId" lay-verify="required" placeholder=""
					   autocomplete="off" class="layui-input" style="width: 94%">
			</div>
		</div>
	</div>

	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label">是否启用<span style="color:red">*</span></label>
			<div class="layui-input-block">
				<input type="checkbox" id="enable" name="enable" lay-skin="switch" value="on"
					   lay-text="是|否">
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label">监控对象:</label>
			<div class="layui-input-block">
				<input id="monitorObject" type="text" name="monitorObject" lay-verify="required" placeholder=""
					   autocomplete="off" class="layui-input">
			</div>
		</div>
	</div>

	<div class="layui-form-item layui-row layui-col-space12">
		<div class="layui-col-sm6">
			<label class="layui-form-label">制单人:</label>
			<div class="layui-input-block">
				<input id="ruleMakeFormPeople" type="text" name="ruleMakeFormPeople" lay-verify="" placeholder=""
					   autocomplete="off" class="layui-input">
			</div>
		</div>

		<div class="layui-col-sm6">
			<label class="layui-form-label">制单时间：</label>
			<div class="layui-input-block">
				<input type="text" name="ruleMakeFormTime" id="ruleMakeFormTime" autocomplete="off" class="layui-input">
			</div>
		</div>
	</div>
	<div class="layui-form-item layui-hide">
		<input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit"
			   value="确认添加">
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
	var laydate = layui.laydate;
	var form = layui.form;
	var $ = layui.jquery;
	var submit = false;
	var isExist = false;
	var win = null;

	function SetData(data) {
		win = data.win ? data.win : window;
	}


	//判断字符
	// form.verify({
	// 	name: function(value, item) {
	// 		if (value.length > 10) {
	// 			return "学生姓名不能超过10字";
	// 		}
	// 	},
	// 	age: function(value, item) {
	// 		if(value > 150||value <=0){
	// 			return "请输入正确的年龄,";
	// 		}
	// 	},
	// 	teachr: function(value, item) {
	// 		if (value.length > 10) {
	// 			return "教师名不能超过10字";
	// 		}
	// 	}
	// });
	//
	// form.render();
	// //日期
	// laydate.render({
	// 	elem: '#invaldate',
	// 	format: 'yyyy-MM-dd',
	// 	//解决时间选择器一闪而过的情况
	// 	trigger: 'click',
	// });

	// var startDate = laydate.render({
	// 	elem: '#star_time',
	// 	//设置日期的类型
	// 	type: 'date',
	// 	trigger:'click',
	// 	done: function(value, date) {
	// 		if (value != "") {
	// 			date.month = date.month - 1;
	// 			date.date = date.date + 1;
	// 			endDate.config.min = date;
	// 		} else {
	// 			endDate.config.min = startDate.config.min;
	// 		}
	// 	},
	// });

	// var endDate = laydate.render({
	// 	//绑定的控件名称
	// 	elem: '#end_time',
	// 	//设置日期的类型
	// 	type: 'date',
	// 	//theme: '#2c78da',
	// 	trigger: 'click',
	// 	done: function(value, date) {
	// 		if (value != "") {
	// 			date.month = date.month - 1;
	// 			date.date = date.date - 1;
	// 			startDate.config.max = date;
	// 		} else {
	// 			startDate.config.max = endDate.config.max;
	// 		}
	// 	}
	// });

	//监听提交
	form.on("submit(layuiadmin-app-form-submit)", function (data) {
		var submitData = JSON.stringify(data.field);
		debugger;
		if (submit == false) {
			submit = true;
			if (isExist == false) {
				$.ajax({
					url: "<%= request.getContextPath() %>/warn/alarmRule/add",
					type: "POST",
					data: submitData,
					cache: false,
					contentType: "text/json",
					success: function (result) {
						layer.msg("添加成功", {
							icon: 1,
							time: 500
						}, function () {
							var index = parent.layer.getFrameIndex(window.name);
							win.layui.table.reload("LAY-app-alarmRule-list-reload");
							top.layer.close(index);
						});
					}
				});
			}
		} else {
			layer.msg("请稍等");
		}
		return false;
	});
</script>
</body>
</html>