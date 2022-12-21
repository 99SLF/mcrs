<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 林俊杰
  - Date: 2022-12-01 16:10:42
  - Description:
-->
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
<title>设备编辑</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list" style="padding: 20px 30px 0 0;">
	<div class="layui-form-item layui-row layui-col-space10">
<%--		需要隐藏主键--%>
	<input type="hidden" name="equipmentInt" value="default">
		<div class="layui-col-sm6">
			<label class="layui-form-label"><span style="color:red">*</span>设备资源号:</label>
			<div class="layui-input-block">
				<input id="equipmentId" type="text" name="equipmentId" lay-verify="required|equipmentId"
					   placeholder="请输入设备资源号(必填)" autocomplete="off" class="layui-input" readonly>
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label"><span style="color:red">*</span>设备名称:</label>
			<div class="layui-input-block">
				<input id="equipmentName" type="text" name="equipmentName" lay-verify="required|equipmentName"
					   placeholder="请输入设备名称(必填)" autocomplete="off" class="layui-input">
			</div>
		</div>
	</div>

	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label"><span style="color:red">*</span>设备属性:</label>
			<div class="layui-input-block">
				<select name="equipmentProperties" id="equipmentProperties" lay-filter="" type="select">
					<option value=""></option>
				</select>
			</div>
		</div>

		<div class="layui-col-sm6">
			<label class="layui-form-label"><span style="color:red">*</span>设备连接端口:</label>
			<div class="layui-input-block">
				<input id="equipmentContinuePort" type="text" name="equipmentContinuePort"
					   lay-verify="required|equipmentContinuePort"
					   placeholder="请输入设备连接端口" autocomplete="off" class="layui-input">
			</div>
		</div>
	</div>

	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label">设备安装位置:</label>
			<div class="layui-input-block">
				<input id="equipmentInstallLocation" type="text" name="equipmentInstallLocation"
					   lay-verify="required|equipmentInstallLocation"
					   placeholder="请输入设备安装位置" autocomplete="off" class="layui-input">
			</div>
		</div>


		<div class="layui-col-sm6">
			<label class="layui-form-label"><span style="color:red">*</span>MES连接IP:</label>
			<div class="layui-input-block">
				<input id="mesContinueIp" type="text" name="mesContinueIp" lay-verify="required|mesContinueIp"
					   placeholder="请输入MES连接IP" autocomplete="off" class="layui-input">
			</div>
		</div>
	</div>

	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label"><span style="color:red">*</span>是否启用:</label>
			<div class="layui-input-block">
				<select name="enabledState" id="enabledState" lay-filter="required" type="select">
					<option value="on">是</option>
					<option value="off">否</option>
				</select>
			</div>
		</div>

<%--		<div class="layui-col-sm6">--%>
<%--			<label class="layui-form-label">接入点名称:<span style="color:red">*</span></label>--%>
<%--			<div class="layui-input-block">--%>
<%--				<input id="assessType" type="text" name="assessType" lay-verify=""--%>
<%--					   placeholder="请输入接入点名称" autocomplete="off" class="layui-input">--%>
<%--			</div>--%>
<%--		</div>--%>
	</div>

	<div class="layui-col-sm12">
		<label class="layui-form-label" >备注:</label>
		<div class="layui-input-block">
			<textarea cols="50" rows="10" style="width:100%;height:100px" name="remarks" id="remarks" autocomplete="off" class="layui-input" lay-verify="remarks"></textarea>
		</div>
	</div>

	<div class="layui-form-item layui-hide">
		<input type="button" lay-submit lay-filter="layuiadmin-app-form-edit" id="layuiadmin-app-form-edit" value="确认修改">
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
	var form = layui.form;
	var laydate = layui.laydate;
	var $ = layui.jquery;
	var isExist = false;
	var submit = false;
	var win = null;


	function SetData(data) {
		win = data.win ? data.win : window;
		var data = data.data;
		form.val("layuiadmin-app-form-list", {
			"equipmentInt":data.equipmentInt,
			"equipmentId": data.equipmentId,
			"equipmentName": data.equipmentName,
			"equipmentInstallLocation": data.equipmentInstallLocation,
			"equipmentProperties": data.equipmentProperties,
			"equipmentContinuePort": data.equipmentContinuePort,
			"mesContinueIp": data.mesContinueIp,
			"enabledState": data.enabledState,
			"remarks": data.remarks,
		});
	}

	//获取设备属性的下拉值
	layui.admin.renderDictSelect({
		elem: "#equipmentProperties",
		dictTypeId: "EQUIPMENT_PROPERTY",
	});
	//设置设备属性的默认值
	$("#equipmentProperties").val("101");
	form.render();

	//判断字符
	form.verify({
		equipmentId: function(value, item) {
			if (value.length > 20) {
				return "设备资源号不能超过20个字符";
			}
		},
		equipmentName: function(value, item) {
			if (value.length > 20) {
				return "设备名称不能超过20个字符";
			}
		},
		equipmentInstallLocation: function(value, item) {
			if (value.length > 20) {
				return "设备安装位置不能超过20字符";
			}
		},
		equipmentContinuePort: function(value, item) {
			if (value.length > 20) {
				return "设备连接端口不能超过20字符";
			}
		},
		mesContinueIp: function(value, item) {
			if (value.length > 30) {
				return "MES连接IP不能超过30字符";
			}
		},
		remarks: function(value, item) {
			if (value.length > 255) {
				return "备注不能超过255个字符";
			}
		}
	});

	form.render();
	// //日期
	// laydate.render({
	// 	elem: '#invaldate',
	// 	format: 'yyyy-MM-dd',
	// 	//解决时间选择器一闪而过的情况
	// 	trigger: 'click',
	// });
	//
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
	//
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
	form.on("submit(layuiadmin-app-form-edit)", function(data) {
		var submitData = JSON.stringify(data.field);
		debugger;
		if (submit == false) {
			submit = true;
			if (isExist == false) {
				$.ajax({
					url: "<%= request.getContextPath() %>/equipment/equipment/update",
					type: "POST",
					data: submitData,
					cache: false,
					contentType: "text/json",
					success: function(result) {
						layer.msg("修改成功", {
							icon: 1,
							time: 500
						}, function() {
							var index = parent.layer.getFrameIndex(window.name);
							win.layui.table.reload("LAY-app-equipment-list-reload");
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