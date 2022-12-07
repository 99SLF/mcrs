<%@page pageEncoding="UTF-8"%>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<title>修改应用</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.1">
</head>
<body>
<div class="layui-fluid">
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list" style="padding: 20px 30px 0 0;">
	 <input id="appId" name="appId" type="hidden" />
	 <div class="layui-row layui-col-space10 layui-form-item">
		<div class="layui-col-sm6">
			<label class="layui-form-label " >应用名称：<span style="color:red">*</span></label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="appName" id="appName"  lay-verify="required" autocomplete="off" placeholder="">
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label " >应用代码：<span style="color:red">*</span></label>
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
				<select name="appication/appType" id="appType" lay-filter="appType" type="select">
					<option value="0">本地</option>
					<option value="1">远程</option>
				</select>
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label " >是否开通：</label>
			<div class="layui-input-block">
				<select name="isOpen" id="isOpen" lay-filter="isOpen" type="select">
					<option value="1">是</option>
					<option value="0">否</option>
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
				<input type="text" name="displayOrder" id="displayOrder"   class="layui-input field-title" autocomplete="off"   class="layui-input">
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
		<input type="button" lay-submit lay-filter="layuiadmin-app-form-edit" id="layuiadmin-app-form-edit" value="确认编辑">
	</div>
</div>
</div>
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
<script type="text/javascript">
	var layer = layui.layer;
	var form = layui.form;
	var $ = layui.jquery;
	var isExist = false;
	var laydate = layui.laydate; //日期
	var submit = false;
	
		  //日期
	laydate.render({
		elem: '#openDate',
    	type: 'date'
	});
	
	// layui.admin.renderDictSelect({
	// 	elem: "#appType",
	// 	dictTypeId: "COF_APPTYPE"
	// });
	// layui.admin.renderDictSelect({
	// 	elem: "#isOpen",
	// 	dictTypeId: "COF_YESORNO"
	// });
	
	
	function SetData(data) {
    win = data.win ? data.win : window;	
    var data = data.data;	   
	form.val('layuiadmin-app-form-list', {
		"appId": data.appId,
	    "appName": data.appName,
	  	"appCode": data.appCode,
	  	"openDate": data.openDate,
	  	"protocolType": data.protocolType,
	  	"isOpen": data.isOpen,
	  	"ipAddr": data.ipAddr,
	  	"ipPort": data.ipPort,
	  	"displayOrder": data.displayOrder,
	  	"url": data.url,
	  	"appDesc": data.appDesc
		});		
	}
		
	//监听提交
	form.on("submit(layuiadmin-app-form-edit)", function(data) {	
		if (submit == false) {
			submit = true;
			var submitData = JSON.stringify(data.field);	      
			$.ajax({
				url: "/mcrs/application/update",
				type: "PUT",
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
						layer.msg("修改成功", {
							icon: 1,
							time: 2000
						}, function() {
							var index = parent.layer.getFrameIndex(window.name);
							win.layui.table.reload('LAY-app-application-list-reload');
							top.layer.close(index);  
							win.window.updateFuncgroupSelect();  
						});
					} else {
						layer.msg("修改失败");		
					}
				},
				error: function(jqXHR, textStatus, errorThrown) {
					layer.msg(jqXHR.responseText, {
						time: 2000,
						icon: 5
					});
				}
			});		
		} else {
			layer.msg("正在修改...请稍等");
		}
		
		return false;                
	});
</script>
</body>
</html>