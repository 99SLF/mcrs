<%@page pageEncoding="UTF-8"%>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<title>添加功能</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.0">
</head>
<body>
<div class="layui-fluid">
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list" style="padding: 20px 30px 0 0;">
  <input id="funcGroupId" name="funcGroupId" type="hidden" />
	<input type="hidden" name="tenantId" value="default">
  <div class="layui-row layui-col-space10 layui-form-item">
		<div class="layui-col-sm6">
			<label class="layui-form-label " >功能名称：<span style="color:red">*</span></label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="funcName" id="funcName"  lay-verify="required" autocomplete="off" placeholder="">
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label " >功能编码：<span style="color:red">*</span></label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="funcCode" id="appCode" lay-verify="required" autocomplete="off" placeholder="">
			</div>
		</div>
	</div>
	<div class="layui-row layui-col-space10 layui-form-item">
		<div class="layui-col-sm6">
			<label class="layui-form-label " >是否定义菜单：</label>
			<div class="layui-input-block">
				<select name="isMenu" id="isMenu" lay-filter="isMenu" type="select">
				</select>
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label " >是否验证权限：</label>
			<div class="layui-input-block">
				<select name="isCheck" id="isCheck" lay-filter="isCheck" type="select">
				</select>
			</div>
		</div>
	</div>
	<div class="layui-row layui-col-space10 layui-form-item">
		<div class="layui-col-sm6">
			<label class="layui-form-label">功能类型：</label>
			<div class="layui-input-block">
				<select name="funcType" id="funcType" lay-filter=" " >
				</select>
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label">显示顺序：<span style="color:red">*</span></label>
			<div class="layui-input-block">
				<input type="text" name="displayOrder" id="displayOrder"   lay-verify="required" class="layui-input field-title" autocomplete="off"   class="layui-input">
			</div>
		</div>
	</div>
	<div class="layui-row layui-form-item">
		<label class="layui-form-label layui-form-project">功能调用入口：</label>
			<div class="layui-input-block layui-textarea-block">
				<input type="text" class="layui-input "  name="funcAction" id="funcAction" lay-verify="" autocomplete="off" >
			</div>
	</div>
	<div class="layui-row layui-form-item">
		<label class="layui-form-label layui-form-project">输入参数：</label>
			<div class="layui-input-block layui-textarea-block">
				<input id="paraInfo" type="text" class="layui-input field-title"  name="paraInfo"  autocomplete="off" placeholder="">
			</div>
	</div>		
	<div class="layui-row layui-form-item">
		<label class="layui-form-label layui-form-project">功能描述：</label>
			<div class="layui-input-block layui-textarea-block">
				<textarea   class="layui-textarea field-effect field-content" name="funcDesc" id="funcDesc" autocomplete="off" placeholder="" lay-verify=""></textarea>
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
	var i=0;
	var submit = false;

	var win = null;
	function SetData(data) {
		win = data.win ? data.win : window;	 	 
		var funcGroupId= data.num;      
		layui.jquery('#funcGroupId').val(funcGroupId); 
		var cpnoValue = layui.jquery('#funcGroupId').val();
	}
	
	
	
  $("#btn").click(function(){	   		
		var url = '<%= request.getContextPath() %>/coframe/framework/function/entrance_select.jsp';
		top.layer.open({
			type:2,
			title: "资源路径",
			area: ["800px", "530px"],
			resize: false,
			content: [url, 'yes'],
			end: function (action) {
	    	}
    	});
	});	
	
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
					url: "<%= request.getContextPath() %>/framework/function/add",
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
							win.layui.table.reload('LAY-app-function-list-reload');
							top.layer.close(index); 
							win.window.updateFuncresourceSelect();    
		        		});
					}
				});
			}			 
		} else {
			layer.msg("正在添加..请稍等！");
		}
		return false;                
	});
	
	layui.admin.renderDictSelect({
		elem: "#funcType",
		dictTypeId: "COF_FUNCTYPE"
	});

	layui.admin.renderDictSelect({
		elem: "#isMenu",
		dictTypeId: "COF_YESORNO"
	});

	layui.admin.renderDictSelect({
		elem: "#isCheck",
		dictTypeId: "COF_YESORNO"
	});
	    	
	$("#funcType").val("page");    	
	form.render();
</script>
</body>
</html>