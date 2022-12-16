<!--
- Author(s): 李伟杰
- Date: 2022-12-05 14:08:11
- Description:
-->
<%@page pageEncoding="UTF-8"%>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>终端状态</title>
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
					<input type="text" name="APPId" value="" placeholder="请输入APPId" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-inline">
				<div class="layui-input-inline" >
					<input type="text" name="deviceSoType" value="" placeholder="请输入终端软件类型" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-inline">
				<div class="layui-input-inline" >
					<input type="text" name="deviceSoRuntime" value="" placeholder="请输入终端软件运行状态" autocomplete="off" class="layui-input">
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
<script type="text/javascript">
	var layer = layui.layer;
	var table = layui.table;
	var form = layui.form;
	var $ = layui.jquery;
	//过滤字段
	var hiddenFields = [];
	//功能名
	var funName = "application_list";

	var laydate = layui.laydate;
	//日期时间选择器
	// laydate.render({
	// 	elem: '#test0'
	// 	,type: 'datetime'
	// });
	//
	// //日期时间选择器
	// laydate.render({
	// 	elem: '#test1'
	// 	,type: 'datetime'
	// });

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

	<%--var active = {--%>
	<%--	add: function() {--%>
	<%--		top.layer.open({--%>
	<%--			type: 2,--%>
	<%--			title: "添加应用",--%>
	<%--			resize: false,--%>
	<%--			content: "<%= request.getContextPath() %>/coframe/framework/application/application_add.jsp",--%>
	<%--			area: ["800px", "530px"],--%>
	<%--			btn: ["确定", "取消"],--%>
	<%--			success: function(layero, index) {--%>
	<%--				var dataJson = {--%>
	<%--					win:window,--%>
	<%--				};--%>
	<%--				debugger;--%>
	<%--				layero.find("iframe")[0].contentWindow.SetData(dataJson);--%>
	<%--			},--%>
	<%--			yes: function(index, layero) {--%>
	<%--				var submit = layero.find('iframe').contents().find("#layuiadmin-app-form-submit");--%>
	<%--				submit.click();--%>
	<%--			}--%>
	<%--		});--%>
	<%--	},--%>
	<%--	//批量删除--%>
	<%--	batchdel: function() {--%>
	<%--		var checkStatus = table.checkStatus("LAY-app-application-list-reload");--%>
	<%--		var data = checkStatus.data;--%>
	<%--		if (data.length === 0){--%>
	<%--			layer.msg('请至少选中一条记录！');--%>
	<%--		}--%>
	<%--		if (data.length > 0) {--%>
	<%--			var appIds = new Array();--%>
	<%--			for (var i=0; i<data.length;i++) {--%>
	<%--				appIds[i] = data[i].appId;--%>
	<%--			}--%>
	<%--			layer.confirm("确定删除所选应用？", {--%>
	<%--				icon: 3,--%>
	<%--				title: "系统提示"--%>
	<%--			}, function(index) {--%>
	<%--				$.ajax({--%>
	<%--					url: "<%= request.getContextPath() %>/framework/application/batchDelete",--%>
	<%--					type: "DELETE",--%>
	<%--					data: JSON.stringify(appIds),--%>
	<%--					cache: false,--%>
	<%--					contentType: "text/json",--%>
	<%--					success: function(result) {--%>
	<%--						if (result) {--%>
	<%--							layer.msg("删除成功", {--%>
	<%--								icon: 1,--%>
	<%--								time: 2000--%>
	<%--							}, function() {--%>
	<%--								table.reload("LAY-app-application-list-reload");--%>
	<%--								updateFuncgroupSelect();--%>
	<%--							});--%>
	<%--						} else {--%>
	<%--							layer.msg("删除失败");--%>
	<%--						}--%>
	<%--					},--%>
	<%--					error: function(result) {--%>
	<%--						layer.msg(result.retMsg);--%>
	<%--					}--%>
	<%--				});--%>
	<%--			});--%>
	<%--		}--%>
	<%--	}--%>
	<%--};--%>

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

	//查询过滤字段
	// $.ajax({
	// 	url: "com.zimax.components.coframe.tools.ColsFilter.queryHiddenField.biz.ext",
	// 	type: "POST",
	// 	async: false ,
	// 	data: JSON.stringify({
	// 		funName: funName
	// 	}),
	// 	cache: false,
	// 	contentType: "text/json",
	// 	success: function(result) {
	// 		if (result) {
	// 			hiddenFields = result.colsFilters;
	// 		} else {
	// 			layer.msg("查询失败");
	// 		}
	// 	}
	// });

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
		url: "<%= request.getContextPath() %>/DeviceRuntime/query",
		method: "GET",
		height: "full-" + getFullSize(),
		page: true,
		limit: 10,
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
				field: "equipmentId",
				title: "设备资源号",
				align: "center",
				// sort: true,
				hide: isHidden("equipmentId"),
				minWidth: 100
			}, {
				//field:设定字段名。字段名的设定非常重要，且是表格数据列的唯一标识;title:设定标题名称
				field: "aPPId",
				title: "APPID",
				align: "center",
				hide: isHidden("aPPId"),
				minWidth: 100
			}, {
				field: "deviceSoType",
				title: "终端软件类型",
				align: "center",
				hide: isHidden("deviceSoType"),
				minWidth: 100
			}, {
				field: "deviceSoRuntime",
				title: "软件运行",
				align: "center",
				hide: isHidden("deviceSoRuntime"),
				minWidth: 150
			}
			, {
				field: "accessStatus",
				title: "设备接入",
				align: "center",
				hide: isHidden("accessStatus"),
				minWidth: 100
			}, {
				field: "deviceWarning",
				title: "终端告警",
				align:"center",
				hide: isHidden("deviceWarning"),
				minWidth: 100
			}
		]]
	});

	$(window).resize(function () {
		table.reload("LAY-app-application-list-reload", {
			height: "full-" + getFullSize()
		});
	});

	<%--//监听操作事件--%>
	<%--table.on("tool(LAY-app-application-list)", function(e) {--%>
	<%--    var data = e.data;--%>
	<%--    if (e.event == "edit") {--%>
	<%--        top.layer.open({--%>
	<%--            type: 2,--%>
	<%--            title: "编辑应用",--%>
	<%--            content: "<%= request.getContextPath() %>/coframe/framework/application/application_edit.jsp",--%>
	<%--            area: ["800px", "530px"],--%>
	<%--            resize: false,--%>
	<%--            btn: ["确定", "取消"],--%>
	<%--            success: function(layero, index) {--%>
	<%--                var dataJson = {--%>
	<%--                    data : data,--%>
	<%--                    win: window--%>
	<%--                };--%>
	<%--                layero.find("iframe")[0].contentWindow.SetData(dataJson);--%>
	<%--            },--%>
	<%--            yes: function(index, layero) {--%>
	<%--                var edit = layero.find("iframe").contents().find("#layuiadmin-app-form-edit");--%>
	<%--                edit.click();--%>
	<%--            }--%>
	<%--        });--%>
	<%--    } else if (e.event == "del") {--%>
	<%--        layer.confirm("确定删除此应用？", {--%>
	<%--            icon: 3,--%>
	<%--            title: "系统提示"--%>
	<%--        }, function(index) {--%>
	<%--            var appIds = new Array();--%>
	<%--            appIds[0] = data.appId;--%>
	<%--            $.ajax({--%>
	<%--                url: "<%= request.getContextPath() %>/framework/application/batchDelete",--%>
	<%--                type: "DELETE",--%>
	<%--                data: JSON.stringify(appIds),--%>
	<%--                cache: false,--%>
	<%--                contentType: "text/json",--%>
	<%--                success: function(result) {--%>
	<%--                    if (result) {--%>
	<%--                        layer.msg("删除成功", {--%>
	<%--                            icon: 1,--%>
	<%--                            time: 2000--%>
	<%--                        }, function() {--%>
	<%--                            updateFuncgroupSelect();--%>
	<%--                            table.reload('LAY-app-application-list-reload');--%>
	<%--                        });--%>
	<%--                    } else {--%>
	<%--                        layer.msg("删除失败");--%>
	<%--                    }--%>
	<%--                },--%>
	<%--                error: function(result) {--%>
	<%--                    layer.msg(result.retMsg);--%>
	<%--                }--%>
	<%--            });--%>
	<%--        });--%>
	<%--    }--%>
	<%--});--%>

	<%--function updateFuncgroupSelect(){--%>
	<%--    var url = [];--%>
	<%--    url.push("iframe[src='<%= request.getContextPath() %>/coframe/framework/functiongroup/funcgroup_list.jsp']");--%>
	<%--    for (var i = 0; i < url.length; i++) {--%>
	<%--        var iframeTemp = parent.layui.$(url[i]);--%>
	<%--        if (iframeTemp.length) {--%>
	<%--            var iframe = iframeTemp[0].contentWindow;--%>
	<%--            iframe.updata_select(false);--%>
	<%--        }--%>
	<%--    }--%>
	<%--}--%>

	$("body").on("click", ".layui-table-body table.layui-table tbody tr td", function() {
		if ($(this).attr("data-field") === "0") return;
		$(this).siblings().eq(0).find('i').click();
	});
</script>
</body>
</html>