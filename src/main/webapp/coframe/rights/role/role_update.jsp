<%@page pageEncoding="UTF-8"%>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): SSW
  - Date: 2021-03-30 10:42:05
  - Description:
-->
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=equipment-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<title>修改角色</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list" style="padding: 20px 30px 0 0;">
	<input type="hidden" name="capRole/roleId"/>
	<input type="hidden" name="capRole/tenantId" value="default">
	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label">角色代码：</label>
			<div class="layui-input-block">
				<input id="roleCode" type="text" name="capRole/roleCode" lay-verify="required|checkRoleCode" placeholder="角色代码(必填)" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label">角色名称：</label>
			<div class="layui-input-block">
				<input id="roleName" type="text" name="capRole/roleName" lay-verify="required" placeholder="角色名称(必填)" autocomplete="off" class="layui-input">
			</div>
		</div>
	</div>
    <div class="layui-row layui-form-item">
			<label class="layui-form-label layui-form-project">角色描述：</label>
			<div class="layui-input-block layui-textarea-block">
				<textarea class="layui-textarea field-effect field-content" name="capRole/roleDesc" autocomplete="off" class="layui-textarea"></textarea>
			</div>
	</div>
	<div class="layui-form-item layui-hide">
		<input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="确认编辑">
	</div>
</div>
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script>
	layui.config({
		base: "<%=request.getContextPath()%>/"
	});
</script>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js" type="text/javascript"></script>
<script src="<%= request.getContextPath() %>/coframe/rights/role/role.js" type="text/javascript"></script>
<script type="text/javascript">
	var role = layui.role;
	role.update();
</script>
<script type="text/javascript">
	var layer = layui.layer;
	var form = layui.form;
	var $ = layui.jquery;
	var isExist = false;
	var submit = false;
	
	var win=null;
	function SetData(data) {
	    win = data.win ? data.win : window;	
	    var data =data.data;
	    console.log(data);
		form.val('layuiadmin-app-form-list', {
			"capRole/roleId": data.roleId,
			"capRole/roleCode": data.roleCode,
			"capRole/roleName": data.roleName,
			"capRole/roleDesc" : data.roleDesc
		});
	}
	
	//判断角色是否已存在
	$("#roleCode").blur(function() {
		var roleCode = $("#roleCode").val();
		if (roleCode != null && roleCode != "") {
			var sendData = {
				criteria: {
					"_expr": [{
						roleCode: roleCode,
						"_op": "="
					}]
				}
			};
			var json = JSON.stringify(sendData);
			$.ajax({
				url: "com.zimax.components.coframe.rights.RoleManager.checkRoleExist.biz.ext",
				type: "POST",
				data: json,
				cache: false,
				contentType: "text/json",
				cache: false,
				success: function (text) {
					if (text.isRoleExist == "true") {
						isExist = true;
					} else if (text.isRoleExist == "false") {
						isExist = false;
					}
				}
			});
		} else {
			return;
		}
	});
	
	//监听提交
// 	form.on("submit(layuiadmin-app-form-edit)", function(data) {
// 		var submitData = JSON.stringify(data.field);
// 		if (submit == false) {
// 			submit = true;
// 			console.log(submitData);
// 			if (isExist == false) {
// 				$.ajax({
// 					url: "com.zimax.components.coframe.rights.RoleManager.updateRole.biz.ext",
// 					type: "POST",
// 					data: submitData,
// 					cache: false,
// 					contentType: 'text/json',
// 					success: function(result) {
// 						layer.msg("修改成功", {
// 							icon: 1,
// 							time: 2000
// 						}, function() {
// 							var index = parent.layer.getFrameIndex(window.name);
// 							win.layui.table.reload('LAY-app-role-list');
// 							top.layer.close(index);   
// 	    			});
// 					}
// 				});	
// 			} else if (isExist == true) {
// 				submit = false;
// 				layer.msg("角色已存在，请重新输入", {
// 					icon: 2,
// 					time: 2000
// 				});
// 			}
// 		} else {
// 			layer.msg("请稍等");
// 		}
		
// 		return false;                
// 	});
</script>
</body>
</html>