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
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<title>修改角色</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<style>
	.layui-textarea{
		height: 5px!important;
		/*min-height: 60px!important;*/
	}
</style>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list" style="padding: 20px 30px 0 0;">
	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label"><span style="color:red">*</span>角色代码：</label>
			<div class="layui-input-block">
				<input id="roleCode" type="text" name="roleCode" lay-verify="required|chinese|length20|onlyOne" placeholder="角色代码(必填)" autocomplete="off" class="layui-input">
			</div>
			<input type="hidden" name="roleId"/>
			<input type="hidden" name="tenantId" value="default">
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label"><span style="color:red">*</span>角色名称：</label>
			<div class="layui-input-block">
				<input id="roleName" type="text" name="roleName" lay-verify="required|length20" placeholder="角色名称(必填)" autocomplete="off" class="layui-input">
			</div>
		</div>
	</div>
    <div class="layui-row layui-form-item">
			<label class="layui-form-label layui-form-project">角色描述：</label>
			<div class="layui-input-block layui-textarea-block">
				<textarea class="layui-textarea field-effect field-content" name="roleDesc" lay-verify="length255" autocomplete="off" class="layui-textarea"></textarea>
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
	var layer = layui.layer;
	var form = layui.form;
	var table = layui.table;
	var $ = layui.jquery;
	var isExist = false;
	var submit = false;
	var win=null;
	var roleCodeCheck='';
	function SetData(data) {
		var data = data.data;
		roleCodeCheck= data.roleCode;
	    win = data.win ? data.win : window;
		roleId = data.roleId;
		form.val('layuiadmin-app-form-list', {
			"roleId": data.roleId,
			"roleCode": data.roleCode,
			"roleName": data.roleName,
			"roleDesc" : data.roleDesc
		});
	}

	//判断角色代码是否已存在
	$("#roleCode").blur(function () {
		var roleCode = $("#roleCode").val();
		debugger;
		if (roleCode != roleCodeCheck) {
			$.ajax({
				url: "<%= request.getContextPath()%>/rights/role/isExist?roleCode=" + roleCode,
				type: "GET",
				cache: false,
				contentType: "text/json",
				success: function (text) {
					if (text.code == "1") {
						isExist = true;
					} else {
						isExist = false;
					}
				}
			});
		} else {
			 isExist = false;
		}
	});
	
// 	监听提交
	form.on("submit(layuiadmin-app-form-submit)", function(data) {
		var submitData = JSON.stringify(data.field);
		if (submit == false) {
			submit = true;
			if (isExist == false) {
				$.ajax({
					url: "<%= request.getContextPath() %>/rights/role/update",
					type: "POST",
					data: submitData,
					cache: false,
					contentType: 'text/json',
					success: function(result) {
						layer.msg("修改成功", {
							icon: 1,
							time: 2000
						}, function() {
							var index = parent.layer.getFrameIndex(window.name);
							win.layui.table.reload('LAY-app-role-list');
							top.layer.close(index);
	    			});
					}
				});
			} else if (isExist == true) {
				submit = false;
				layer.msg("角色已存在，请重新输入", {
					icon: 2,
					time: 2000
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