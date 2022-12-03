<%@page pageEncoding="UTF-8"%>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
<title>功能选择调用入口</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css" media="all">
</head>
<body>
<div class="layui-fluid">
	<div class="layui-card" style="margin-bottom: 0;">
		<div class="layui-form layui-card-header layuiadmin-card-header-auto">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">功能编号：</label>
					<div class="layui-input-inline">
						 <input name="funcCode" class="layui-input" onenter="search" />
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">功能名称：</label>
					<div class="layui-input-inline">
						<input name="funcName" class="layui-input" onenter="search" />
					</div>
				</div>
				<div class="layui-inline">
					<button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-menuInfo-search">
						<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
					</button>
				</div>
			</div>
		</div>
		<div class="layui-card-body">
			<div class="layui-hide">
				<button class="layui-btn" data-type="getCheckData"></button>
			</div>
			<table id="LAY-app-menu-list" lay-filter="LAY-app-menu-list"></table>
		</div>
	</div>
	<div class="layui-form-item layui-hide">
		<input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="确认添加">
	</div>
</div>
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script type="text/javascript">
	var layer = layui.layer;
	var table = layui.table;
	var form = layui.form;
	var $ = layui.jquery;
	
	form.render();
	var menuData = {};
	
	//监听搜索
	form.on("submit(LAY-app-menuInfo-search)", function(data) {
		var field = data.field;
		var dataJson = {
			"funcCode": field.funcCode,
			"funcName":field.funcName
		};
		table.reload("LAY-app-menu-list", {
			url: "com.zimax.components.coframe.framework.MenuManager.queryFunction.biz.ext",
			where: field
		});
	}); 
	
	$(".layui-btn.layuiadmin-btn-list").on("click", function() {
		var type = $(this).data("type");
		active[type] ? active[type].call(this) : "";
	});
    
	var selData = {};      //存放选中行数据
    
    //监听行单击事件（双击事件为：rowDouble）
	table.on('row(LAY-app-menu-list)', function(obj){
		selData = obj.data;
	});
    
	function getData() {   //获取点击行的数据
		return selData;
  }
	
	form.on('submit(layuiadmin-app-form-submit)',function(rel) {
		var formData = rel.field;
	});
	
	function getFullSize() {
		var fluid = $(".layui-fluid");
		var header = $(".layui-card-header");
		var card = $(".layui-card");
		var cardbody = $(".layui-card-body");
		return header.outerHeight(true)  + (card.outerHeight(true) - card.height()) + (cardbody.outerHeight(true) - cardbody.height()) + (fluid.outerHeight(true) - fluid.height()) ;
	}
	
	$(window).resize(function () {
		table.reload("LAY-app-menu-list", {
			height: "full-" + getFullSize()
		});
	});
	
	table.render({
		elem: "#LAY-app-menu-list",
		url: "com.zimax.components.coframe.framework.MenuManager.queryFunction.biz.ext",
		method: "post",
		height: "full-" + getFullSize(),
		page: true,
		limit: 10,
		limits: [10, 15, 20, 30],
		parseData: function(res) {
			return {
				code: "0",
				msg: res.msg,
				count: res.total,
				data: res.data
			};
		},
		cols:[[{
			type: "radio"
		}, {
			title: "序号",
			type: "numbers"
		},
		 {
			field: "funcCode",
			title: "功能编号",
			align: "center",
			minWidth: 100
		}, {
			field: "funcName",
			title: "功能名称",
			align: "center",
			minWidth: 120
		}, {
			field: "funcType",
			title: "功能类型",
			align: "center",
			minWidth: 150
		}, {
			field: "funcAction",
			title: "功能调用入口地址",
			align: "center",
			minWidth: 150,
		}]]
	});
	
	
	$("body").on("click", ".layui-table-body table.layui-table tbody tr td", function() {
		var objs = $($(this).parent()).siblings();
		$.each(objs, function(i, item) {
			if ($(item).find('.layui-form-checked').length > 0) {
				$(item).find("[data-field='0']").find('i').click();
			}
		});
		if ($(this).attr("data-field") === "0") return;
		$(this).siblings().eq(0).find('i').click();
	});
</script>
</body>
</html>