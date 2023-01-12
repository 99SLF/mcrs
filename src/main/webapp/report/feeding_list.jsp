<!--
- Author(s): 李伟杰，苏尚文
- Date: 2022-12-05 14:08:11
- Description:
-->
<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>上料报表</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/common/layui/css/layui.css"/>
<link rel="stylesheet" href="<%=request.getContextPath() %>/std/dist/style/admin.css"/>
<link rel="stylesheet" href="<%=request.getContextPath() %>/std/dist/style/custom.css?v=1.0.0">
<link rel="stylesheet" href="<%=request.getContextPath() %>/iconfont/iconfont.css">
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
</style>
</head>
<body>
<div class="layui-card">
	<script type="text/html" id="toolbar">
	<div class="layui-form layui-card-header layuiadmin-card-header-auto">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">设备资源号：</label>
				<div class="layui-input-inline">
					<input type="text" name="equipmentId" value="" placeholder="请输入设备资源号" autocomplete="off"
						   class="layui-input">
				</div>
				<label class="layui-form-label">轴名称：</label>
				<div class="layui-input-inline">
					<input type="text" name="axisName" value="" placeholder="请输入轴名称" autocomplete="off"
						   class="layui-input">
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">生产SFC编码：</label>
				<div class="layui-input-inline">
					<input type="text" name="prodSFCId" value="" placeholder="请输入生产SFC编码" autocomplete="off"
						   class="layui-input">
				</div>
				<label class="layui-form-label">载具码：</label>
				<div class="layui-input-inline">
					<input type="text" name="vehicleCode" value="" placeholder="请输入载具码" autocomplete="off"
						   class="layui-input">
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">开始时间：</label>
				<div class="layui-input-inline">
					<input type="text" name="startProdTime" value="" placeholder="请选择开始时间" id="test0" autocomplete="off"
						   class="layui-input">
				</div>
				<label class="layui-form-label">结束时间：</label>
				<div class="layui-input-inline">
					<input type="text" name="endProdTime" value="" placeholder="请选择结束时间" id="test1" autocomplete="off"
						   class="layui-input">
				</div>
				<div class="layui-inline layui-search" style="padding-left:15px">
					<button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-feeding-search"
							id="LAY-app-feeding-search" >
						<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
					</button>
				</div>
			</div>
		</div>
	</div>
	</script>
	<div class="layui-card-body">
		<table id="LAY-app-application-list" lay-filter="LAY-app-application-list"></table>
	</div>
</div>
<script src="<%=request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script>
	layui.config({
		base: "<%=request.getContextPath() %>/"
	});
</script>
<script src="<%=request.getContextPath() %>/std/dist/index.all.js"></script>
<script type="text/javascript">
	var layer = layui.layer;
	var table = layui.table;
	var form = layui.form;
	var $ = layui.jquery;
	var util = layui.util;
	var laydate = layui.laydate;
	var admin = layui.admin;
	var view = layui.view;
	
	// 过滤字段
	var hiddenFields = [];
	// 功能名
	var funName = "feeding_list";
	
	// 日期时间选择器
	laydate.render({
		elem: "#test0",
		type: "date"
	});
	
	// 日期时间选择器
	laydate.render({
		elem: "#test1",
		type: "date"
	});
	
	// 监听搜索
	form.on("submit(LAY-app-feeding-search)", function(data) {
		var field = data.field;
		table.reload("LAY-app-application-list-reload", {
			where: field
		});
	});
	
	// 下拉框监听事件
	form.on("select(appType)", function(data) {
		var submit = $("#LAY-app-feeding-search");
		submit.click();
	});
	
	// 文本框回车事件
	$(".layui-input").on("keydown", function(event) {
		if (event.keyCode == 13) {
			var submit = $("#LAY-app-feeding-search");
			submit.click();
			return false;
		}
	});
	
	function getFullSize() {
		var header = $(".layui-card-header");
		var cardbody = $(".layui-card-body");
		return header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height()) + 1;
	}
	
	// 监听按钮点击事件
	var active = {
		search: function() {
		    debugger;
			var submit = $("#LAY-app-feeding-search");
			submit.click();
			return false;
		},
		query: function() {
			admin.popupRight({
				id: "LAY_adminPopupAbout",
				success: function() {
					view(this.id).render("system/about");
				}
			});
		}
	};
	
	// 右侧表头按钮事件监听
	table.on("toolbar(LAY-app-application-list)", function(obj) {
		var type = obj.event;
		active[type] ? active[type].call(this) : "";
	});
	
	// 表格排序
	table.on("sort(LAY-app-application-list)", function(obj) {
		table.reload("LAY-app-application-list-reload", {
			initSort: obj,
			where: {
				field: obj.field,
				order: obj.type
			}
		});
	});
	
	// 查询过滤字段
	$.ajax({
		url: "<%=request.getContextPath() %>/cols/filter/query/" + funName,
		type: "GET",
		async: false,
		cache: false,
		contentType: "text/json",
		success: function(result) {
			if (result) {
				hiddenFields = result.data
			} else {
				layer.msg("查询失败");
			}
		}
	});
	
	//判断是否隐藏函数
	function isHidden(field) {
		for (var i = 0; i < hiddenFields.length; i++) {
			if (hiddenFields[i].field == field) {
				return true;
			}
		}
		return false;
	}
	
	table.render({
		elem: "#LAY-app-application-list",
		id: "LAY-app-application-list-reload",
		url: "<%=request.getContextPath() %>/report/feeding/query",
		method: "get",
		height: "full-" + getFullSize(),
		page: true,
		limit: 10,
		toolbar: "#toolbar",
		defaultToolbar: [{
			title: "查询",
			layEvent: "search",
			icon: "layui-icon layui-icon-search layuiadmin-button-btn",
		}, {
			title: "高级查询",
			layEvent: "query",
			icon: "icon iconfont icon-gaojichaxun",
		}, "filter"],
		colHideChange: function(col, checked) {
			var field = col.field;
			var hidden = col.hide;
			$.ajax({
				url: "<%=request.getContextPath() %>/cols/filter/set?funName=" + funName + "&field=" + field + "&hidden=" + hidden,
				type: "GET",
				cache: false,
				contentType: "text/json",
				success: function(result) {
					if (result) {
					} else{
						layer.msg("列筛选失败");
					}
				}
			});
		},
		limits: [10, 15, 20, 30],
		parseData: function (res) {
			return {
				code: res.code,
				msg: res.msg,
				count: res.total,
				data: res.data
			};
		},
		cols: [[{
			type: "checkbox"
		}, {
			title: "序号",
			type: "numbers"
		}, {
			field: "equipmentId",
			title: "设备资源号",
			align: "center",
			hide: isHidden("equipmentId"),
			minWidth: 150
		}, {
			field: "axisName",
			title: "轴名称",
			align: "center",
			minWidth: 150,
			hide: isHidden("axisName")
		}, {
			field: "inSFCId",
			title: "来料SFC编码",
			align: "center",
			hide: isHidden("inSFCId"),
			minWidth: 150
		}, {
			field: "vehicleCode",
			title: "载具码",
			align: "center",
			hide: isHidden("vehicleCode"),
			minWidth: 150
		}, {
			field: "prodSFCId",
			title: "生产SFC编码",
			align: "center",
			hide: isHidden("prodSFCId"),
			minWidth: 150
		}, {
			field: "prodNumber",
			title: "生产数量",
			align: "center",
			hide: isHidden("prodNumber"),
			minWidth: 60
		}, {
			field: "createTime",
			title: "创建时间",
			align: "center",
			hide: isHidden("createTime"),
			minWidth: 200,
			templet: function(d) {
				return util.toDateString(d.createTime, "yyyy-MM-dd HH:mm:ss");
			}
		}, {
			field: "startProdTime",
			title: "开始生产时间",
			align: "center",
			hide: isHidden("startProdTime"),
			minWidth: 200,
			templet: function(d) {
				return util.toDateString(d.startProdTime, "yyyy-MM-dd HH:mm:ss");
			}
		}, {
			field: "endProdTime",
			title: "结束生产时间",
			align: "center",
			hide: isHidden("endProdTime"),
			minWidth: 200,
			templet: function(d) {
				return util.toDateString(d.endProdTime, "yyyy-MM-dd HH:mm:ss");
			}
		}]]
	});
	
	$(window).resize(function() {
		table.reload("LAY-app-application-list-reload", {
			height: "full-" + getFullSize()
		});
	});
	
	$("body").on("click", ".layui-table-body table.layui-table tbody tr td", function() {
		if ($(this).attr("data-field") === "0") return;
		$(this).siblings().eq(0).find("i").click();
	});
</script>
</body>
</html>