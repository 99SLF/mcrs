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
</head>
<body>
<div class="layui-fluid">
	<div class="layui-card">
		<div class="layui-form layui-card-header layuiadmin-card-header-auto">
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
				<div class="layui-inline layui-search">
					<button class="layui-btn layuiadmin-btn-list " lay-submit lay-filter="LAY-app-rolelist-search" id="LAY-app-rolelist-search">
						<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
					</button>
				</div>
			</div>
		</div>
		<div class="layui-card-body">
			<div class="layui-toolbar" id="toolbar" hidden="true">
				<button class="layui-btn layuiadmin-btn-list layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-circle-fine"></i>添加</button>
				<button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="batchdel" ><i class="layui-icon layui-icon-delete"></i>删除</button>
			</div>
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