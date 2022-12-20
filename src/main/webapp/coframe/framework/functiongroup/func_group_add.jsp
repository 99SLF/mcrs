<%@page pageEncoding="UTF-8"%>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<title>添加功能组</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.1">
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list" style="padding: 20px 30px 0 0;">
	<input type="hidden" name="tenantId" value="default">
	<input id="appId" name="appId" type="hidden" />
	<div class="layui-form-item">
		<label class="layui-form-label"><span style="color:red">*</span>功能组名称：</label>
		<div class="layui-input-inline">
			<input type="text" class="layui-input" name="funcGroupName" id="funcGroupName"  lay-verify="required" autocomplete="off" placeholder="" style="width: 300px;">
			<input name="funcGroupId" type="hidden"/>
        	<input name="groupLevel" type="hidden"/>
        	<input name="funcGroupSeq" type="hidden"/>
        	<input name="isLeaf" type="hidden"/>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label"><span style="color:red">*</span>显示顺序：</label>
		<div class="layui-input-inline">
			<input type="text" class="layui-input" name="displayOrder" id="displayOrder"  lay-verify="number" autocomplete="off" placeholder="" style="width: 300px;">
		</div>
	</div>
	<div class="layui-form-item layui-hide">
		<input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="确认添加">
	</div>
</div>

<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script>
	layui.config({
		base: "<%=request.getContextPath()%>/"
	});
</script>
<script type="text/javascript">
	var layer = layui.layer;
	var form = layui.form;
	var $ = layui.jquery;
	var isExist = false;
	var i=0;
	var submit = false;
    
  var win = null;
	function SetData(data) {
	 win = data.win ? data.win : window;		 
   var funcGroupId= data.num;   
	 layui.jquery('#appId').val(funcGroupId); 
	 var cpnoValue = layui.jquery('#appId').val();	
	}
	
	//监听提交
	form.on("submit(layuiadmin-app-form-submit)", function(data) {
		if (submit == false) {
			submit = true;
			var submitData = JSON.stringify(data.field);
			debugger;
			if (submitData != null) {
				i=i+1;
			}
			if (i == 1) {		
				$.ajax({
					url: "<%= request.getContextPath() %>/framework/funcGroup/add",
					type: "POST",
					data: submitData,
					cache: false,
					contentType: 'text/json',
					success: function(result) {
						layer.msg("添加成功", {
							icon: 1
							,time: 2000
						}, function() {
							var index = parent.layer.getFrameIndex(window.name);
							win.layui.table.reload('LAY-app-funcgroup-list-reload');
							top.layer.close(index); 
							win.window.updateFunSelect();  
	        			});
					}
				});
			}		
		} else {
			layer.msg("正在添加...请稍等！");
		}
		return false;                
	});
</script>
</body>
</html>