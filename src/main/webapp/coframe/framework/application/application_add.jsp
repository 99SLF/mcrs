<%@page pageEncoding="UTF-8"%>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<title>添加应用</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.1">
</head>
<body>
<div class="layui-fluid">
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list" style="padding: 20px 30px 0 0;">
	<input type="hidden" name="tenantId" value="default">
	<div class="layui-row layui-col-space10 layui-form-item">
		<div class="layui-col-sm6">
			<label class="layui-form-label " ><span style="color:red">*</span>应用名称：</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="appName" id="appName"  lay-verify="required" autocomplete="off" placeholder="">
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label " ><span style="color:red">*</span>应用代码：</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="appCode" id="appCode" lay-verify="required" autocomplete="off" placeholder="">
			</div>
		</div>
	</div>
	<div class="layui-row layui-col-space10 layui-form-item">
		<div class="layui-col-sm6">
			<label class="layui-form-label " >开通日期：</label>
			<div class="layui-input-block">
				<input type="text" name="openDate" id="openDate" autocomplete="off" class="layui-input" readonly>
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label " >协议类型：</label>
			<div class="layui-input-block">
				<select name="protocolType" id="protocolType" lay-filter="protocolType" type="select">
					<option value="http">http</option>
					<option value="https">https</option>
				</select>
			</div>
		</div>
	</div>
	<div class="layui-row layui-col-space10 layui-form-item">
		<div class="layui-col-sm6">
			<label class="layui-form-label " >应用类型：</label>
			<div class="layui-input-block">
				<select name="appType" id="appType" lay-filter="appType" type="select">
				</select>
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label " >是否开通：</label>
			<div class="layui-input-block">
				<select name="isOpen" id="isOpen" lay-filter="isOpen" type="select">
				</select>
			</div>
		</div>
	</div>
	<div class="layui-row layui-col-space10 layui-form-item">
		<div class="layui-col-sm6">
			<label class="layui-form-label " >应用IP或域名：</label>
			<div class="layui-input-block">
				<input type="text" name="ipAddr" id="ipAddr"  autocomplete="off"  class="layui-input">
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label " >应用端口：</label>
			<div class="layui-input-block">
				<input type="text" name="ipPort" id="ipPort"  autocomplete="off"   class="layui-input">
			</div>
		</div>
	</div>
	<div class="layui-row layui-col-space10 layui-form-item">
		<div class="layui-col-sm6">
			<label class="layui-form-label " >应用上下文：</label>
			<div class="layui-input-block">
				<input type="text" name="url" class="layui-input field-title"  autocomplete="off"  class="layui-input">
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label " >显示顺序：</label>
			<div class="layui-input-block">
				<input type="text" name="displayOrder" id="displayOrder" class="layui-input field-title" lay-verify="number"autocomplete="off"   class="layui-input">
			</div>
		</div>
	</div>	
	<div class="layui-row layui-form-item">
			<label class="layui-form-label layui-form-project">应用描述：</label>
			<div class="layui-input-block layui-textarea-block">
				<textarea  class="layui-textarea field-effect field-content" name="appDesc" id="appDesc" autocomplete="off" placeholder="" lay-verify=""></textarea>
			</div>
	</div>														
	<div class="layui-form-item layui-hide">
		<input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="确认添加">
	</div>
</div>
</div>

<script src="<%= request.getContextPath() %>/common/layui/layui.all.js?v1" type="text/javascript"></script>
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
	var isExist = false;
	var laydate = layui.laydate; //日期
	var i=0;
	var submit = false;
	 //日期
	laydate.render({
	    elem: '#openDate'
	    ,type: 'date'
	});

	layui.admin.renderDictSelect({
		elem: "#appType",
		dictTypeId: "COF_APPTYPE"
	});
	layui.admin.renderDictSelect({
		elem: "#isOpen",
		dictTypeId: "COF_YESORNO"
	});

	$("#appType").val("0");
	$("#isOpen").val("1"); 
	form.render();
  
  var win = null;
	function SetData(data) {
		win = data.win ? data.win : window;	 
	}
	//监听提交
	form.on("submit(layuiadmin-app-form-submit)", function(data) {
		if (submit == false) {
			submit = true;
			var submitData = JSON.stringify(data.field);
			if (submitData != null) {
				i = i + 1;
			}	
			if (i == 1) {			
				$.ajax({
					url: "<%= request.getContextPath() %>/framework/application/add",
					type: "POST",
					data: submitData,
					cache: false,
					contentType: 'text/json',
					success: function(result) {
						if (result.exception) {
							layer.alert(result.exception.message, {
								icon: 2,
								title: "系统提示"
							});
						} else if (result) {
							layer.msg("添加成功", {
								icon: 1,
								time: 2000
							}, function() {
								var index = parent.layer.getFrameIndex(window.name);
								win.layui.table.reload("LAY-app-application-list-reload");
								top.layer.close(index);
								win.window.updateSelect();
								win.window.updateFuncgroupSelect();
							});
						} else {
							layer.msg("添加失败");		
						}
					},
					error: function(jqXHR, textStatus, errorThrown) {
						layer.msg(jqXHR.responseText, {
							time: 2000,
							icon: 5
						});
					}
				});	
			}		 
		} else {
			layer.msg("正在添加...请稍等！");
		}
		return false;                
	});
	$("body").on("click", ".layui-table-body table.layui-table tbody tr td", function() {
		if ($(this).attr("data-field") === "0") return;
		$(this).siblings().eq(0).find('i').click();
	});
</script>
</body>
</html>