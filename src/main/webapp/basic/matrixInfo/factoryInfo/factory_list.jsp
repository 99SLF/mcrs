<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>工厂产线</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/custom.css?v1">
<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/layout.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/iconfont/iconfont.css">
<style type="text/css">
.layui-card {
	margin-bottom: 0px;
}
</style>
</head>
<body>
<div class="layui-card">
	<div class="layui-form layui-card-header layuiadmin-card-header-auto">
		<div class="layui-form-item">
			<div class="layui-inline">
					<label class="layui-form-label">所属车间：</label>
					<div class="layui-input-block">
						<input type="text" name="production" id="production"  autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">产线编号：</label>
					<div class="layui-input-block">
						<input type="text" name="lineCode" id="lineCode" placeholder="请输入产线编号" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline layui-search" style="float:right">
					<button class="layui-btn layui-btn-primary layui-btn-xs" lay-submit lay-filter="searchSubmit" id="searchSubmit" title="搜索">
						<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
					</button>
					<button class="layui-btn layui-btn-primary layui-btn-xs" data-type="save" title="保存"><span class="icon iconfont icon-baocun"></span></button>		    		    
		    		<button class="layui-btn layui-btn-primary layui-btn-sm" data-type="cancel" title="取消"><span class="icon iconfont icon-quxiao"></span></button>
				</div>		
			</div>
	</div>
	<div class="layui-card-body">
		<table id="LAY-demo-list" lay-filter="LAY-demo-list">
		</table>
		<script type="text/html" id="table-user-list">
				<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="add" title="新增"><i class="layui-icon layui-icon-add-circle-fine layuiadmin-button-btn"></i></a>
				<a lay-event="del" class="layui-btn layui-btn-primary layui-btn-xs" title="删除"><i class="layui-icon layui-icon-delete"></i></a>
		</script>
	</div>
</div>
<script type="text/html" id="article-toolbar">
	<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="add" title="新增"><i class="layui-icon layui-icon-add-circle-fine layuiadmin-button-btn"></i></a>
	<a lay-event="del" class="layui-btn layui-btn-primary layui-btn-xs" title="删除"><i class="layui-icon layui-icon-delete"></i></a>
</script>	
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script>
	layui.config({
		base: "<%=request.getContextPath()%>/"
	});
</script>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
<script type="text/javascript">
	var layer = layui.layer;
	var table = layui.table;
	var form = layui.form;
	var $ = layui.jquery;

	//获取树传过来的树id（）
	var tree = <%=request.getParameter("node")%>;
	var infoId = tree.nodeId;

	function getFactory(infoId) {
		//查基地表（付给表单）

		form.val();

	}


	

	//按钮的监听 （保存/取消）
	//监听按钮点击事件
	var active = {
		save: function() {
			//有基地的主键（修改的ajax）


			//没有基地的主键（新增的ajax）

		},
		canle: function () {
			//刷新页面
		}

	};

	$(".layui-btn").on("click", function() {
		var type = $(this).data("type");
		active[type] ? active[type].call(this) : "";
	});


	
</script>
</body>
</html>