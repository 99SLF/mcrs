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
<title>上料报表高级查询</title>
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
			<input type="text" class="layui-input" name="resource" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">工位：</label>
		<div class="layui-input-block">
			<input type="text" class="layui-input" name="operation" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">动作类型：</label>
		<div class="layui-input-block">
			<select name="actionType" id="actionType" lay-filter="isFinish" type="select">
				<option value="0">上料</option>
				<option value="1">卸料</option>
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">上料轴：</label>
		<div class="layui-input-block" >
			<input type="text" class="layui-input" name="axis" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">来料SFC号：</label>
		<div class="layui-input-block">
			<input type="text" class="layui-input" name="sfcPre" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">载具号：</label>
		<div class="layui-input-block">
			<input type="text" class="layui-input" name="processLotPre" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">上料数量：</label>
		<div class="layui-input-block">
			<input type="text" class="layui-input" name="qty" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">SFC号：</label>
		<div class="layui-input-block" >
			<input type="text" class="layui-input" name="sfc" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">是否完工：</label>
		<div class="layui-input-block" >
			<select name="isFinish" id="isFinish" lay-filter="isFinish" type="select">
				<option value="0">否</option>
				<option value="1">是</option>
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">上料卷径：</label>
		<div class="layui-input-block">
			<input type="text" class="layui-input" name="diamRealityValue" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">创建人：</label>
		<div class="layui-input-block">
			<input type="text" class="layui-input" name="createdBy" autocomplete="off" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">更新人：</label>
		<div class="layui-input-block" >
			<input type="text" class="layui-input" name="updatedBy" autocomplete="off" />
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
            resource: formData.resource,
			operation: formData.operation,
			actionType: formData.actionType,
			axis: formData.axis,
			sfcPre: formData.sfcPre,
			processLotPre: formData.processLotPre,
			qty: formData.qty,
			sfc: formData.sfc,
			isFinish: formData.isFinish,
			diamRealityValue: formData.diamRealityValue,
			createdBy: formData.createdBy,
			updatedBy: formData.updatedBy,
			CREATED_TIME: formData.CREATED_TIME,

        });
	}
	
	function reset() {
		var formData = {
            resource: "",
			operation: "",
			actionType: "",
			axis: "",
			sfcPre: "",
			processLotPre: "",
			qty: "",
			sfc: "",
			isFinish: "",
			diamRealityValue: "",
			createdBy: "",
			updatedBy: "",
			CREATED_TIME: ""
		}
		win.setFormData(formData);
	}
	
	//监听提交
	form.on("submit(LAY-app-feeding-search-advanced)", function(data) {
		var rels = data.field;
		win.setFormData(rels);
        win.layer.closeAll("iframe");
	});
</script>
</body>
</html>