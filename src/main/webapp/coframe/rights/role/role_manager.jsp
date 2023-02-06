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
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>角色管理</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css">
<style>
	.layui-card {
		margin-bottom: 0px
	}
	.layui-layer-adminRight {
		top: 0px !important;
		bottom: 0;
		box-shadow: 1px 1px 10px rgba(0, 0, 0, .1);
		border-radius: 0;
		overflow: auto
	}
	.layui-form-item .layui-inline {
		margin-bottom: 0px !important;
		margin-right: 0px !important;
	}
	.layui-form-label {
		width: 120px !important;
		padding: 5px 0px !important;
	}
	.layui-form-item .layui-input-inline {
		float: left;
		width: 150px;
		margin-right: 10px;
	}
	.layui-input {
		height: 30px !important;
	}
</style>
</head>
<body>
<div class="layui-fluid">
	<div class="layui-card">
		<script type="text/html" id="toolbar">
			<div class="layui-form layuiadmin-card-header-auto" lay-filter="layuiadmin-feeding-form" id="layuiadmin-feeding-form">
				<div class="layui-form-item">
					<div class="layui-inline">
						<label class="layui-form-label">角色代码：</label>
						<div class="layui-input-inline">
							<input type="text" name="roleCode" placeholder="" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-inline">
						<label class="layui-form-label">角色名称：</label>
						<div class="layui-input-inline">
							<input type="text" name="roleName" placeholder="" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-inline layui-hide">
						<button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-rolelist-search" id="LAY-app-rolelist-search">
							<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
						</button>
					</div>
				</div>
			</div>
		</script>
		<div class="layui-card-body">
			<table id="LAY-app-role-list" lay-filter="LAY-app-role-list"></table>
			<script type="text/html" id="table-role-list">
			{{#  if(d.roleId > 1){ }}
				<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>
				<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>
			{{#  } else { }}
				<a class="layui-btn  layui-btn-xs layui-btn-disabled" ><i class="layui-icon layui-icon-edit"></i>编辑</a>
				<a class="layui-btn  layui-btn-xs layui-btn-disabled" ><i class="layui-icon layui-icon-delete"></i>删除</a>
			 {{#  } }}
			</script>
		</div>
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
	role.manager();
</script>
</body>
</html>