<%@page pageEncoding="UTF-8"%>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<title>修改资源</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.0">
</head>
<body>
<div class="layui-fluid">
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list" style="padding: 20px 30px 0 0;">	 
	<input id="resId" name="resId" type="hidden" />
	<input id="funcResource.function.funcCode" name="funcResource.function.funcCode" type="hidden" />
	<div class="layui-row layui-col-space10 layui-form-item">
		<div class="layui-col-sm6">
			<label class="layui-form-label " >资源名称：<span style="color:red">*</span></label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="resName" id="resName" lay-verify="required" autocomplete="off">
			</div>
		</div>
		<div class=" layui-col-sm6">
			<label class="layui-form-label " >资源类型：</label>
			<div class="layui-input-block">
				<select name="resType" id="resType" lay-filter="">
				</select>
			</div>
		</div>
	</div>
	<div class="layui-row layui-form-item">
			<label class="layui-form-label layui-form-project">资源路径：</label>
			<div class="layui-input-block layui-textarea-block">
				<input id="resPath" type="text" class="layui-input"  name="resPath" autocomplete="off">
				<button type="button" class="layui-btn layui-btn-sm layui-btn-primary" id="btn" style="position:absolute;top:0px;right:0px;height:37px">
				   <i class="layui-icon layui-icon-more" id="onButtonEdit"></i>
				</button>
			</div>
	</div>
	<div class="layui-row layui-form-item">
			<label class="layui-form-label layui-form-project">所属构建包：</label>
			<div class="layui-input-block layui-textarea-block">
				<input id="comPackName" type="text" class="layui-input"  name="comPackName" autocomplete="off">
			</div>
	</div>		
	<div class="layui-form-item layui-hide">
		<input type="button" lay-submit lay-filter="layuiadmin-app-form-edit" id="layuiadmin-app-form-edit" value="确认编辑">
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
	var laydate = layui.laydate; //日期
	var submit = false;
		  //日期
 	laydate.render({
    	elem: '#openDate',
    	type: 'datetime'
	});
	
	var win = null;
	function SetData(data) {
    win = data.win ? data.win : window;	
    var data = data.data;
		form.val('layuiadmin-app-form-list', {
			"funcCode": data.funcCode,
  		 	"resId": data.resId,
	    	"resName": data.resName,
		 	"resType": data.resType,
			"resPath": data.resPath,
			"comPackName": data.comPackName
		});		
	}
	
	<%--$("#onButtonEdit").click(function(){--%>
	<%--	var btnEdit = this;--%>
   	<%--	var url = '<%= request.getContextPath() %>/coframe/framework/function/entrance_select.jsp';--%>
    <%--	top.layer.open({--%>
    <%--		type:2,--%>
	<%--    	title: "资源路径",--%>
	<%--    	area: ['600px', '350px'],--%>
	<%--    	content: [url, 'yes'],--%>
	<%--    	end: function (action) {--%>
	<%--		}--%>
	<%--	});--%>
	<%--});	--%>
                       
	// layui.admin.renderDictSelect({
	// 	elem: "#resType",
	// 	dictTypeId: "COF_FUNCTYPE"
	//  });
		
	//监听提交
	form.on("submit(layuiadmin-app-form-edit)", function(data) {		
		if (submit == false) {
			submit = true;
			var submitData = JSON.stringify(data.field);
			$.ajax({
				url: "/mcrs/framework/funcResource/update",
				type: "PUT",
				data: submitData,
				cache: false,
				contentType: 'text/json',
				success: function(result) {
					layer.msg("修改成功", {icon: 1,time: 2000}, function() {
						var index = parent.layer.getFrameIndex(window.name);
						win.layui.table.reload('LAY-app-funcresource-list-reload');
						top.layer.close(index);  
					});
				}
			});			
		} else {
			layer.msg("正在修改...请稍等！");
		}
		return false;                
	});
</script>
</body>
</html>