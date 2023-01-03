<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 林俊杰
  - Date: 2022-12-02 14:09:42
  - Description:
-->
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
<title>操作日志管理</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
	<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css" />
	<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v1">
</head>
<body>
<div class="layui-fluid">
	<div class="layui-card">
		<div class="layui-form layui-card-header layuiadmin-card-header-auto">
			<div class="layui-form-item layui-col-space12">
				<div class="layui-input-inline">
					<input type="text" name="logStatus"  placeholder="请输入日志状态" autocomplete="off"
						   class="layui-input">
				</div>
				<div class="layui-input-inline">
					<input type="text" name="operationType" placeholder="请输入操作类型" autocomplete="off"
						   class="layui-input">
				</div>
				<div class="layui-input-inline">
					<input type="text" name="operationTime" id="operationTime" placeholder="请输入操作时间" autocomplete="off"
						   class="layui-input">
				</div>
				<div class="layui-input-inline">
					<input type="text" name="operationResult" placeholder="请输入操作结果" autocomplete="off"
						   class="layui-input">
				</div>
				<div class="layui-input-inline">
					<input type="text" name="operator" placeholder="请输入操作人" autocomplete="off"
						   class="layui-input">
				</div>

				<div class="layui-inline layui-search">
					<button class="layui-btn layuiadmin-btn-list" lay-submit
							lay-filter="LAY-app-operationLoglist-search"
							id="LAY-app-operationLoglist-search">查询
						<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
					</button>
				</div>
			</div>
		</div>
		<div class="layui-card-body">
			<%--        <div class="layui-toolbar" id="toolbar" hidden="true">--%>
			<%--            <button class="layui-btn layuiadmin-btn-list layui-btn-sm" lay-event="add"><i--%>
			<%--                    class="layui-icon layui-icon-add-circle-fine"></i>新增规则--%>
			<%--            </button>--%>
			<%--            <button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="batchdel"><i--%>
			<%--                    class="layui-icon layui-icon-delete"></i>删除--%>
			<%--            </button>--%>
			<%--        </div>--%>


			<table id="LAY-app-operationLog-list" lay-filter="LAY-app-operationLog-list"></table>

			<%--        <script type="text/html" id="table-operationLog-list">--%>
			<%--            <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i--%>
			<%--                    class="layui-icon layui-icon-edit"></i>编辑</a>--%>
			<%--            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i--%>
			<%--                    class="layui-icon layui-icon-delete"></i>删除</a>--%>
			<%--        </script>--%>
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
	var table = layui.table;
	var form = layui.form;
	var $ = layui.jquery;
	var util = layui.util;

	//全局参数
	var req_data;

	//功能名
	var funName = "list";

	var hiddenFields = [];

	var laydate = layui.laydate;
	//日期时间选择器
	laydate.render({
		elem: '#operationTime',
		type: 'date'
	});


	//监听搜索
	form.on("submit(LAY-app-operationLoglist-search)", function (data) {
		var field = data.field;
		table.reload("LAY-app-operationLog-list-reload", {
			where: field
		});
	});


	//文本框回车事件
	$(".layui-input").on("keydown", function (event) {
		if (event.keyCode == 13) {
			var submit = $("#LAY-app-operationLoglist-search");
			submit.click();
			return false;
		}
	});

	<%--var active = {--%>
	<%--    //设备新建--%>
	<%--    add: function () {--%>
	<%--        top.layer.open({--%>
	<%--            type: 2,--%>
	<%--            title: "预警规则新建",--%>
	<%--            content: "<%= request.getContextPath() %>/warn/operationLog/alarm_rule_add.jsp",--%>
	<%--            area: ["1000px", "560px"],--%>
	<%--            resize: false,--%>
	<%--            btn: ["确定", "取消"],--%>
	<%--            success: function (layero, index) {--%>
	<%--                var dataJson = {--%>
	<%--                    win: window,--%>
	<%--                };--%>
	<%--                layero.find("iframe")[0].contentWindow.SetData(dataJson);--%>
	<%--            },--%>
	<%--            yes: function (index, layero) {--%>
	<%--                var submit = layero.find("iframe").contents().find("#layuiadmin-app-form-submit");--%>
	<%--                submit.click();--%>
	<%--            }--%>
	<%--        });--%>
	<%--    },--%>
	<%--    //批量删除--%>
	<%--    batchdel: function () {--%>
	<%--        var checkStatus = table.checkStatus("LAY-app-operationLog-list-reload");--%>
	<%--        var data = checkStatus.data;--%>
	<%--        if (data.length == 0) {--%>
	<%--            layer.msg("请至少选中一条记录！");--%>
	<%--        }--%>
	<%--        if (data.length > 0) {--%>
	<%--            var operationLogInts = new Array();--%>
	<%--            for (var i = 0; i < data.length; i++) {--%>
	<%--                operationLogInts[i] = data[i].operationLogInt;--%>
	<%--            }--%>
	<%--            layer.confirm("确定删除所选预警规则？", {--%>
	<%--                icon: 3,--%>
	<%--                title: "系统提示"--%>
	<%--            }, function (index) {--%>
	<%--                $.ajax({--%>
	<%--                    url: "<%= request.getContextPath() %>/warn/operationLog/batchDelete",--%>
	<%--                    type: "DELETE",--%>
	<%--                    data: JSON.stringify(operationLogInts),--%>
	<%--                    cache: false,--%>
	<%--                    contentType: "text/json",--%>
	<%--                    success: function (result) {--%>
	<%--                        if (result.exception) {--%>
	<%--                            layer.alert(result.exception.message, {--%>
	<%--                                icon: 2,--%>
	<%--                                title: "系统提示"--%>
	<%--                            });--%>
	<%--                        } else if (result) {--%>
	<%--                            layer.msg("删除成功", {--%>
	<%--                                icon: 1,--%>
	<%--                                time: 2000--%>
	<%--                            }, function () {--%>
	<%--                                table.reload("LAY-app-operationLog-list-reload");--%>
	<%--                            });--%>
	<%--                        } else {--%>
	<%--                            layer.msg("删除失败");--%>
	<%--                        }--%>
	<%--                    },--%>
	<%--                    error: function (jqXHR, textStatus, errorThrown) {--%>
	<%--                        layer.msg(jqXHR.responseText, {--%>
	<%--                            time: 2000,--%>
	<%--                            icon: 5--%>
	<%--                        });--%>
	<%--                    }--%>
	<%--                });--%>
	<%--            });--%>
	<%--        }--%>
	<%--    }--%>
	<%--};--%>

	table.on('sort(LAY-app-operationLog-list)', function (obj) {
		table.reload('LAY-app-operationLog-list-reload', {
			initSort: obj,
			where: {
				sortField: obj.field,
				sortOrder: obj.type
			}
		});
	});

	//左侧表头按钮事件监听
	table.on("toolbar(LAY-app-operationLog-list)", function (obj) {
		var type = obj.event;
		active[type] ? active[type].call(this) : "";
	});

	//表格排序
	table.on("sort(LAY-app-operationLog-list)", function (obj) {
		table.reload("LAY-app-operationLog-list-reload", {
			initSort: obj,
			where: {
				sortField: obj.field,
				sortOrder: obj.type
			}
		});
	});

	function getFullSize() {
		var fluid = $(".layui-fluid");
		var header = $(".layui-card-header");
		var cardbody = $(".layui-card-body");
		return header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height()) + (fluid.outerHeight(true) - fluid.height()) + 2;
	}


	$(window).resize(function () {
		table.reload("LAY-app-operationLog-list-reload", {
			height: "full-" + getFullSize()
		});
	});

	// 查询过滤字段
	$.ajax({
		url: "<%=request.getContextPath() %>/cols/filter/query/" + funName,
		type: "GET",
		async: false,
		cache: false,
		contentType: "text/json",
		success: function (result) {
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
		elem: "#LAY-app-operationLog-list",
		id: "LAY-app-operationLog-list-reload",
		url: "<%= request.getContextPath() %>/log/operationLog/query",
		method: "GET",
		height: "full-" + getFullSize(),
		page: true,
		limit: 10,
		limits: [10, 15, 20, 30],
		toolbar: "#toolbar",
		defaultToolbar: ["filter"],
		colHideChange: function (col, checked) {
			var field = col.field;
			var hidden = col.hide;
			$.ajax({
				url: "<%=request.getContextPath() %>/cols/filter/set?funName=" + funName + "&field=" + field + "&hidden=" + hidden,
				type: "GET",
				cache: false,
				contentType: "text/json",
				success: function (result) {
					if (result) {
					} else {
						layer.msg("列筛选失败");
					}
				}
			});
		},
		parseData: function (res) {
			debugger;
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
			field: "operationLogNum",
			title: "日志编号",
			align: "center",
			minWidth: 120,
			hide: isHidden("operationLogNum")
		}, {
			field: "logType",
			title: "日志类型",
			align: "center",
			minWidth: 120,
			hide: isHidden("logType")
		}, {
			field: "logStatus",
			title: "日志状态",
			align: "center",
			minWidth: 100,
			hide: isHidden("logStatus")
		}, {
			field: "operationType",
			title: "操作类型",
			align: "center",
			minWidth: 150,
			hide: isHidden("operationType")
		}, {
			field: "operationContent",
			title: "操作内容",
			align: "center",
			minWidth: 150,
			hide: isHidden("operationContent")
		}, {
			field: "operationResult",
			title: "操作结果",
			align: "center",
			minWidth: 120,
			hide: isHidden("operationResult")
		}, {
			field: "operator",
			title: "操作人",
			align: "center",
			minWidth: 120,
			hide: isHidden("operator")
		}, {
			field: "operationTime",
			title: "操作时间",
			align: "center",
			minWidth: 100,
			hide: isHidden("operationTime")
		}]]
	});

	//监听操作事件
	<%--table.on("tool(LAY-app-operationLog-list)", function (e) {--%>
	<%--    var data = e.data;--%>
	<%--    if (e.event == "edit") {--%>
	<%--        top.layer.open({--%>
	<%--            type: 2,--%>
	<%--            title: "编辑设备信息",--%>
	<%--            content: "<%= request.getContextPath() %>/warn/operationLog/alarm_rule_edit.jsp",--%>
	<%--            area: ["1000px", "560px"],--%>
	<%--            resize: false,--%>
	<%--            btn: ["确定", "取消"],--%>
	<%--            success: function (layero, index) {--%>
	<%--                var dataJson = {--%>
	<%--                    data: data,--%>
	<%--                    win: window--%>
	<%--                };--%>
	<%--                layero.find("iframe")[0].contentWindow.SetData(dataJson);--%>
	<%--            },--%>
	<%--            yes: function (index, layero) {--%>
	<%--                var edit = layero.find("iframe").contents().find("#layuiadmin-app-form-edit");--%>
	<%--                edit.click();--%>
	<%--            }--%>

	<%--        });--%>
	<%--    } else if (e.event == "del") {--%>
	<%--        layer.confirm("确定删除该设备？", {--%>
	<%--            icon: 3,--%>
	<%--            title: "系统提示"--%>
	<%--        }, function (index) {--%>
	<%--            $.ajax({--%>
	<%--                url: "<%= request.getContextPath() %>/warn/operationLog/delete/" + data.operationLogInt,--%>
	<%--                type: "DElETE",--%>
	<%--                data: JSON.stringify({--%>
	<%--                    operationLog: data--%>
	<%--                }),--%>
	<%--                cache: false,--%>
	<%--                contentType: "text/json",--%>
	<%--                success: function (result) {--%>
	<%--                    if (result.exception) {--%>
	<%--                        layer.alert(result.exception.message, {--%>
	<%--                            icon: 2,--%>
	<%--                            title: "系统提示"--%>
	<%--                        });--%>
	<%--                    } else if (result) {--%>
	<%--                        layer.msg("删除成功", {--%>
	<%--                            icon: 1,--%>
	<%--                            time: 500--%>
	<%--                        }, function () {--%>
	<%--                            table.reload("LAY-app-operationLog-list-reload");--%>
	<%--                        });--%>
	<%--                    } else {--%>
	<%--                        layer.msg("删除失败！", {--%>
	<%--                            icon: 2,--%>
	<%--                            time: 2000--%>
	<%--                        });--%>
	<%--                    }--%>
	<%--                },--%>
	<%--                error: function (jqXHR, textStatus, errorThrown) {--%>
	<%--                    layer.msg(jqXHR.responseText, {--%>
	<%--                        time: 500,--%>
	<%--                        icon: 5--%>
	<%--                    });--%>
	<%--                }--%>
	<%--            });--%>
	<%--        });--%>
	<%--    }--%>
	<%--});--%>

	// //批量选中
	// $("body").on("click", ".layui-table-body table.layui-table tbody tr td", function () {
	//     if ($(this).attr("data-field") === "0") return;
	//     $(this).siblings().eq(0).find("i").click();
	// });
</script>
</body>
</html>