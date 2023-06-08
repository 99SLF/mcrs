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
<div class="layui-card">
	<script type="text/html" id="toolbar">
		<div class="layui-form layuiadmin-card-header-auto"
			 lay-filter="layuiadmin-feeding-form" id="layuiadmin-feeding-form">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">设备资源号：</label>
					<div class="layui-input-inline">
						<input type="text" class="layui-input" name="resource" autocomplete="off" />
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">上料轴：</label>
					<div class="layui-input-inline">
						<input type="text" class="layui-input" name="axis" autocomplete="off" />
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">来料SFC号：</label>
					<div class="layui-input-inline">
						<input type="text" class="layui-input" name="sfcPre" autocomplete="off" />
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">创建时间：</label>
					<div class="layui-input-inline">
						<input type="text" name="CREATED_TIME" id="CREATED_TIME" placeholder="请选择创建日期" autocomplete="off" class="layui-input" readonly>
					</div>
				</div>
				<div class="layui-inline layui-hide">
					<button id="LAY-app-feeding-search" class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-feeding-search">
						<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
					</button>
				</div>
			</div>
		</div>
	</script>
	<div class="layui-card-body">
		<table id="LAY-app-feeding-list" lay-filter="LAY-app-feeding-list"></table>
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
	var admin = layui.admin;
	var view = layui.view;
	var laydate = layui.laydate;
	// 过滤字段
	var hiddenFields = [];
	// 功能名
	var funName = "feeding_list";
	// 高级查询参数
	var advancedFormData = {};
	// 焦点名称
	var focusName = null;
	// 开始时间选择器
	// 监听搜索
	form.on("submit(LAY-app-feeding-search)", function(data) {
		var startTime = "";
		var endTime = "";
		var field = data.field;
		if(field.CREATED_TIME != null){
			startTime = field.CREATED_TIME.substring(0,field.CREATED_TIME.indexOf("~"));
			endTime = field.CREATED_TIME.substring(field.CREATED_TIME.indexOf("~")+1);
		}
		field["startTime"]=startTime
		field["endTime"]=endTime
        reloadData(field);
        var formData = {
            resource: field.resource,
            axis: field.axis,
			sfcPre: field.sfcPre,
			CREATED_TIME:field.CREATED_TIME
        };
        form.val("layuiadmin-feeding-form", formData);
        advancedFormData = $.extend(advancedFormData, formData);
	});


	function reloadData(formData) {
		//读取表格数据 表格id
		table.reload("LAY-app-feeding-list-reload", {
			page: {
				curr: 1
			},
			where: formData
		});
        formReder();
        if (focusName) {
            $("input[name=" + focusName + "]").focus();
		}
	}
	
	function setFormData(data) {
		advancedFormData = data;
        reloadData(data);
        form.val("layuiadmin-feeding-form", {
            resource: data.resource,
            axis: data.axis,
            sfcPre: data.sfcPre,
			CREATED_TIME:data.CREATED_TIME
        });
	}
	
	function getFullSize() {
		var header = $(".layui-card-header");
		var cardbody = $(".layui-card-body");
		return header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height()) + 1;
	}
	
	// 监听按钮点击事件
	var active = {
		search: function() {
			var submit = $("#LAY-app-feeding-search");
			submit.click();
			return false;
		},
		query: function() {
		    var url = "<%=request.getContextPath() %>/report/feeding_form_query.jsp";
			admin.popupRight({
				type: 2,
                content: [url, "yes"],
				btn: ["查询", "重置", "取消"],
				success: function(layero, index) {
					var dataJson = {
						win : window,
						data: advancedFormData
					};
					layero.find("iframe")[0].contentWindow.SetData(dataJson);
				},
				yes: function(index, layero) {
					var submit = layero.find("iframe").contents().find("#LAY-app-feeding-search-advanced");
					submit.click();
					top.layer.close(index);
				},
				btn2: function(index, layero) {
					layero.find("iframe")[0].contentWindow.reset();
				}
			});
		}
	};
	
	// 右侧表头按钮事件监听
	table.on("toolbar(LAY-app-feeding-list)", function(obj) {
		var type = obj.event;
		active[type] ? active[type].call(this) : "";
	});
	
	// 表格排序
	table.on("sort(LAY-app-feeding-list)", function(obj) {
		table.reload("LAY-app-feeding-list-reload", {
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
				hiddenFields = result.data;
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
		elem: "#LAY-app-feeding-list",
		id: "LAY-app-feeding-list-reload",
		url: "<%=request.getContextPath() %>/report/feeding/query",
		method: "get",
		height: "full-" + getFullSize(),
		page: true,
		limit: 100,
		toolbar: "#toolbar",
		defaultToolbar: [{
			title: "查询",
			layEvent: "search",
			icon: "layui-icon layui-icon-search layuiadmin-button-btn",
		}, {
			title: "高级查询",
			layEvent: "query",
			icon: "icon iconfont icon-gaojichaxun",
		}, "filter","export"],
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
		limits: [100, 150, 200, 300],
		parseData: function (res) {
			return {
				code: res.code,
				msg: res.msg,
				count: res.total,
				data: res.data
			};
		},
		cols: [[{
			title: "序号",
			type: "numbers",
			width: 100
		}, {
			field: "resource",
			title: "设备资源号",
			align: "center",
			hide: isHidden("resource"),
			minWidth: 120
		}, {
			field: "operation",
			title: "工位",
			align: "center",
			minWidth: 100,
			hide: isHidden("operation")
		},{
			field: "actionType",
			title: "动作类型",
			align: "center",
			minWidth: 100,
			hide: isHidden("actionType"),
			templet: function(d) {
				if (d.actionType==1) {
					return "上料";
				} else if (d.actionType==2){
					return "卸料"
				}
			}

		}, {
			field: "axis",
			title: "上料轴",
			align: "center",
			hide: isHidden("axis"),
			minWidth: 80
		}, {
			field: "sfcPre",
			title: "来料SFC号",
			align: "center",
			hide: isHidden("sfcPre"),
			minWidth: 100
		}, {
			field: "processLotPre",
			title: "载具号",
			align: "center",
			hide: isHidden("processLotPre"),
			minWidth: 100
		}, {
			field: "qty",
			title: "上料数量",
			align: "center",
			hide: isHidden("qty"),
			minWidth: 100
		},{
			field: "sfc",
			title: "MES返回SFC号",
			align: "center",
			minWidth: 150,
			hide: isHidden("sfc")
		},{
			field: "isFinish",
			title: "是否完工",
			align: "center",
			minWidth: 100,
			hide: isHidden("isFinish"),
			templet: function(d) {
				if (d.isFinish==0) {
					return "否";
				} else if (d.isFinish==1){
					return "是"
				}else{
					return "";
				}
			}
		}, {
			field: "diamRealityValue",
			title: "上料卷径",
			align: "center",
			hide: isHidden("diamRealityValue"),
			minWidth: 100
		}, {
			field: "downInfo",
			title: "卸滚筒信息",
			align: "center",
			hide: isHidden("downInfo"),
			minWidth: 120
		}, {
			field: "createdBy",
			title: "创建人",
			align: "center",
			hide: isHidden("createdBy"),
			minWidth: 100
		}, {
			field: "createdTime",
			title: "创建时间",
			align: "center",
			hide: isHidden("createdTime"),
			templet: function(d) {
				return d.createdTime ==null?"":util.toDateString(d.createdTime, "yyyy-MM-dd HH:mm:ss");
			},
			minWidth: 160
		}, {
			field: "updatedBy",
			title: "更新人",
			align: "center",
			hide: isHidden("updatedBy"),
			minWidth: 100
		}, {
			field: "updatedTime",
			title: "更新时间",
			align: "center",
			hide: isHidden("updatedTime"),
			templet: function(d) {
				return d.updatedTime==null?"":util.toDateString(d.updatedTime, "yyyy-MM-dd HH:mm:ss");
			},
			minWidth: 160
		}]]
	});

    formReder();
	
    function formReder() {
		laydate.render({
			elem: "#CREATED_TIME",
			type: "datetime",
			trigger: "click",
			range:"~"
			,done: function(value, date, endDate){

			}
		});
        // 文本框回车事件
        $(".layui-input").on("keydown", function (event) {
            if (event.keyCode == 13) {
                focusName = event.target.name;
                var submit = $("#LAY-app-feeding-search");
                submit.click();
                return false;
            }
        });
    }
	
    $(window).resize(function() {
		table.reload("LAY-app-feeding-list-reload", {
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