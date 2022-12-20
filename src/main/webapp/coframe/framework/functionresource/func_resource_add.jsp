<%@page pageEncoding="UTF-8"%>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<title>添加功能资源</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.0">
</head>
<body>
<div class="layui-fluid">
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list" style="padding: 20px 30px 0 0;">
	<input type="hidden" name="tenantId" value="default">
   <input id="funcCode"	name="funcCode" type="hidden"  />
   <div class="layui-row layui-col-space10 layui-form-item">
		<div class="layui-col-sm6">
			<label class="layui-form-label " ><span style="color:red">*</span>资源名称：</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="resName" id="resName" lay-verify="required" autocomplete="off">
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label " >资源类型：</label>
			<div class="layui-input-block">
				<select name="resType" id="resType" lay-filter="" >
				</select>
			</div>
		</div>
	</div>
	<div class="layui-row layui-form-item">
		<label class="layui-form-label layui-form-project">资源路径：</label>
			<div class="layui-input-block layui-textarea-block">
				<input id="resPath" type="text" class="layui-input"  name="resPath"  autocomplete="off">
			</div>
	</div>
	<div class="layui-row layui-form-item">
		<label class="layui-form-label layui-form-project">所属构建包：</label>
			<div class="layui-input-block layui-textarea-block">
				<input id="comPackName" type="text" class="layui-input" name="comPackName"  autocomplete="off">
			</div>
	</div>			
	<div class="layui-form-item layui-hide">
		<input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="确认添加">
	</div>
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
	var $ = layui.jquery;
	var isExist = false;
	var i = 0;
	var submit = false;
    	
	var win = null;
	function SetData(data) {
		win = data.win ? data.win : window;	 
	 	var funcCode= data.num;
   		layui.jquery('#funcCode').val(funcCode);
   		var cpnoValue = layui.jquery('#funcCode').val();
	}

	<%--$("#onButtonEdit").click(function(){--%>
	<%--	var btnEdit = this;--%>
   	<%--	var url = '<%= request.getContextPath() %>/coframe/framework/function/entrance_select.jsp';--%>
    <%--	top.layer.open({--%>
	<%--		type:2,--%>
	<%--    	title: "资源路径",--%>
	<%--    	area: ["800px", "530px"],--%>
	<%--    	content: [url, 'yes'],--%>
	<%--    	end: function (action) {--%>
	<%--    	}--%>
    <%--	});--%>
	<%--});	--%>
	
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
					url:"<%= request.getContextPath() %>/framework/funcResource/add",
					type: "POST",
					data: submitData,
					cache: false,
					contentType: 'text/json',
					success: function(result) {
						layer.msg("添加成功", {
							icon: 1,
							time: 2000
						}, function() {
							var index = parent.layer.getFrameIndex(window.name);
							win.layui.table.reload('LAY-app-funcresource-list-reload');
							top.layer.close(index); 
	    				});
					}
				});
			}			
		} else {
			layer.msg("正在添加...请稍等!");
		} 
		return false;                
	});
		
	layui.admin.renderDictSelect({
		elem: "#resType",
		dictTypeId: "COF_FUNCTYPE"
	});
	
	//$("#resType").val("page");
	form.render();
</script>
</body>
</html>