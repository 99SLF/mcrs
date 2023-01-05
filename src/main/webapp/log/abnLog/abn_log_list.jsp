<!--
- Author(s): 林俊杰
- Date: 2023-1-4 16:06:11
- Description:
-->
<%@page pageEncoding="UTF-8"%>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>异常日志页面</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
	<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css" />
	<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v1">
	<style type="text/css">
		.layui-card {
			margin-bottom: 0px
		}
	</style>
</head>
<body>
<div class="layui-card">
	<div class="layui-form layui-card-header layuiadmin-card-header-auto">
		<div class="layui-form-item">

			<div class="layui-inline">

				<div class="layui-input-inline" >
					<input type="text" name="equipmentId" value="" placeholder="请输入设备资源号" autocomplete="off" class="layui-input">
				</div>
			</div>

			<div class="layui-inline">

				<div class="layui-input-inline" >
					<input type="text" name="deviceName" value="" placeholder="请输入终端名称" autocomplete="off" class="layui-input">
				</div>
			</div>

			<div class="layui-inline">
				<div class="layui-input-inline" >
					<select name="abnType" id="abnType" lay-filter="" type="select">
						<option value=""></option>
					</select>
				</div>
			</div>

			<div class="layui-inline">

				<div class="layui-input-inline" >
					<input type="text" name="abnLevel" value="" placeholder="请输入预警等级" autocomplete="off" class="layui-input">
				</div>
			</div>

			<div class="layui-inline">

				<div class="layui-input-inline" >
					<input type="text" name="exchangeTime" value="" placeholder="请选择交互时间" id="exchangeTime" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-inline layui-search">
				<button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-rolelist-search" id="LAY-app-rolelist-search">
					<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
				</button>
			</div>
		</div>
	</div>
	<div class="layui-card-body">
		<%--        <div class="layui-toolbar" id="toolbar" hidden="true">--%>
		<%--            <button class="layui-btn layuiadmin-btn-list layui-btn-sm"  lay-event="add"><i class="layui-icon layui-icon-add-circle-fine"></i>添加</button>--%>
		<%--            <button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="batchdel"><i class="layui-icon layui-icon-delete"></i>删除</button>--%>
		<%--        </div>--%>
		<table id="LAY-app-application-list" lay-filter="LAY-app-application-list"></table>
		<%--        <script type="text/html" id="table-role-list">--%>
		<%--            <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>--%>
		<%--            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>--%>
		<%--        </script>--%>
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
	var table = layui.table;
	var form = layui.form;
	var $ = layui.jquery;

	//时间工具类引用
	var util =layui.util;
	//过滤字段
	var hiddenFields = [];
	//功能名
	var funName = "application_list";

	var laydate = layui.laydate;
	//日期时间选择器
	laydate.render({
		elem: '#exchangeTime'
		,type: 'date'
	});

	//获取预警类型的下拉值
	layui.admin.renderDictSelect({
		elem: "#abnType",
		dictTypeId: "WRANING_TYPE",
	});
	form.render();


	//监听搜索
	form.on("submit(LAY-app-rolelist-search)", function(data) {
		var field = data.field;
		table.reload("LAY-app-application-list-reload", {
			where: field
		});
	});

	//下拉框监听事件
	form.on('select(appType)', function(data){
		var submit = $("#LAY-app-rolelist-search");
		submit.click();
	});

	//文本框回车事件
	$(".layui-input").on("keydown", function(event) {
		if (event.keyCode == 13) {
			var submit = $("#LAY-app-rolelist-search");
			submit.click();
			return false;
		}
	});


	/* //按钮事件监听
    $(".layui-btn.layuiadmin-btn-list").on("click", function() {
        var type = $(this).data("type");
        active[type] ? active[type].call(this) : "";
    }); */

	function getFullSize() {
		var header = $(".layui-card-header");
		var cardbody = $(".layui-card-body");
		return header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height())+1;
	}

	// //左侧表头按钮事件监听
	// table.on('toolbar(LAY-app-application-list)', function(obj){
	//     var type = obj.event;
	//     active[type] ? active[type].call(this) : "";
	// });

	//表格排序
	table.on('sort(LAY-app-application-list)', function(obj){
		table.reload('LAY-app-application-list-reload', {
			initSort: obj ,
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
			if (hiddenFields[i].field == field ) {
				return true;
			}
		}
		return false;
	}


	table.render({
		elem: "#LAY-app-application-list",
		id: "LAY-app-application-list-reload",
		url: "<%= request.getContextPath() %>/log/abnLog/query",
		method: "get",
		height: "full-" + getFullSize(),
		page: true,
		limit: 10,
		toolbar: "#toolbar",
		defaultToolbar: ["filter"],
		//列筛选
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
		// toolbar: "#toolbar",
		// defaultToolbar: ["filter"],
		// colHideChange: function(col, checked) {
		// 	var field = col.field;
		// 	var hidden = col.hide;
		// 	$.ajax({
		// 		url: "com.zimax.components.coframe.tools.ColsFilter.setHiddenField.biz.ext",
		// 		type: "POST",
		// 		data: JSON.stringify({
		// 			hidden: hidden,
		// 			colsFilter: {
		// 				funName: funName,
		// 				field: field
		// 			}
		// 		}),
		// 		cache: false,
		// 		contentType: "text/json",
		// 		success: function(result) {
		// 			if (result) {
		// 			} else{
		// 				layer.msg("列筛选失败");
		// 			}
		// 		}
		// 	});
		// },
		limits: [10, 15, 20, 30],
		parseData: function(res) {
			return {
				code: res.code,
				msg: res.msg,
				count: res.total,
				data: res.data
			};
		},
		//设置表头。值是一个二维数组。方法渲染方式必填
		cols:[[
			// 		{
			// 	type: "checkbox"
			// },
			{
				field: "abnLogNum",
				title: "日志编号",
				align: "center",
				// sort: true,
				hide: isHidden("abnLogNum"),
				minWidth: 100
			}, {
				//field:设定字段名。字段名的设定非常重要，且是表格数据列的唯一标识;title:设定标题名称
				field: "logType",
				title: "日志类型",
				align: "center",
				minWidth: 100,
				hide: isHidden("logType")

			}, {
				field: "equipmentId",
				title: "设备资源号",
				align: "center",
				hide: isHidden("equipmentId"),
				minWidth: 100

			}, {
				field: "aPPId",
				title: "APPId",
				align: "center",
				hide: isHidden("aPPId"),
				minWidth: 150
			}, {
				field: "deviceName",
				title: "终端名称",
				align: "center",
				hide: isHidden("deviceName"),
				minWidth: 100
			}, {
				field: "abnTitle",
				title: "预警标题",
				align:"center",
				hide: isHidden("abnTitle"),
				minWidth: 100
			}, {
				field: "abnType",
				title: "预警类型",
				align:"center",
				hide: isHidden("abnType"),
				minWidth: 100,
				templet: function (d) {
					return layui.admin.getDictText("WRANING_TYPE", d.abnType);
				}
			}, {
				field: "abnLevel",
				title: "预警等级",
				align:"center",
				hide: isHidden("abnLevel"),
				minWidth: 100
			}, {
				field: "abnContent",
				title: "预警内容",
				align:"center",
				hide: isHidden("abnContent"),
				minWidth: 100
			}, {
				field: "exchangeTime",
				title: "交互时间",
				align:"center",
				hide: isHidden("exchangeTime"),
				minWidth: 100
			}

		]]
	});

	$(window).resize(function () {
		table.reload("LAY-app-application-list-reload", {
			height: "full-" + getFullSize()
		});
	});



	$("body").on("click", ".layui-table-body table.layui-table tbody tr td", function() {
		if ($(this).attr("data-field") === "0") return;
		$(this).siblings().eq(0).find('i').click();
	});
</script>
</body>
</html>