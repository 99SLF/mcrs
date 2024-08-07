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
	<meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
	<title>菜单管理</title>
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
		<div class="layui-form layuiadmin-card-header-auto" lay-filter="layuiadmin-feeding-form" id="layuiadmin-feeding-form">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">选择菜单：</label>
					<div class="layui-input-inline">
						<select name="menuId" lay-filter="refreshtable" class="field-menuId" id="menuId" type="select">
							<option value=""></option>
						</select>
						<input type="hidden" name="isLeaf" value="1" />
					</div>
				</div>
			</div>
		</div>
	</script>
	<div class="layui-card-body">
		<table id="LAY-app-menu-list" lay-filter="LAY-app-menu-list"></table>
		<script type="text/html" id="table-menu-list">
			<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>
			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>
		</script>
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
	//过滤字段
	var hiddenFields = [];
	//功能名
	var funName = "subfuncgroup_list"; 
	
	form.render();
	var menuData = {};
	var parentMenuId = null;
	var focusName = null;
	var active = {
		//传值，判断
		add: function() {
			top.layer.open({
				type: 2,
				title: "添加菜单",
				content: '<%= request.getContextPath() %>/coframe/framework/menu/menu_add.jsp',
				area: ["820px", "400px"],
				resize: false,
				btn: ["确定", "取消"],
				success: function(layero, index) {
			    var dataJson = {
						win: window,
						parentMenuId: $("#menuId").val()
					};
					layero.find("iframe")[0].contentWindow.SetData(dataJson);
				},
				yes: function(index, layero) {
					var submit = layero.find('iframe').contents().find("#layuiadmin-app-form-submit");
					submit.click();
				}
			});
		},
		batchdel: function() {
			var checkStatus = table.checkStatus("LAY-app-menu-list");
      		var data = checkStatus.data;
			if (data.length > 0) {
				var nodes=[];
				for (var i = 0; i < data.length; i++) {
				  	nodes.push({
				  		menuId: data[i].menuId
				  	});
				}
				layer.confirm("确定删除所选菜单？", {
			  		icon: 3, 
			  		title: "系统提示"
				}, function(index) {
					var menuIds = new Array();
					for (var i=0; i<data.length;i++) {
						menuIds[i] = data[i].menuId;
					}
					$.ajax({
						url: "<%= request.getContextPath() %>/framework/menu/batchDelete",
						type: "DELETE",
						data: JSON.stringify(menuIds),
						cache: false,
						contentType: "text/json",
						success: function(result) {
							if (result) {
								layer.msg("删除成功", {
									icon: 1,
									time: 2000
								}, function() {
									table.reload("LAY-app-menu-list");
									updata_select();
								});
							} else {
								layer.msg("删除失败");		
							}
						},
						error: function(result) {
							layer.msg(result.retMsg);
		        		}
					});
				});
			} else {
				layer.msg("请至少选择一行记录");
			}
		}
	};
	
	$(".layui-btn.layuiadmin-btn-list").on("click", function() {
		var type = $(this).data("type");
		active[type] ? active[type].call(this) : "";
	});
	
	function getFullSize() {
		var fluid = $(".layui-fluid");
		var header = $(".layui-card-header");
		var cardbody = $(".layui-card-body");
		var size = 2;
		size += (fluid.outerHeight(true) - fluid.height());
		size += header.outerHeight(true);
		size += (cardbody.outerHeight(true) - cardbody.height());
		return size;
	}
	
	$(window).resize(function () {
		table.reload("LAY-app-menu-list", {
			height: "full-" + getFullSize()
		});
	});
	
	//左侧表头按钮事件监听
	table.on('toolbar(LAY-app-menu-list)', function (obj) {
		var type = obj.event;
		active[type] ? active[type].call(this) : "";
	});
	
	//表格排序
	table.on("sort(LAY-app-menu-list)", function (obj) { 
  		table.reload("LAY-app-menu-list", {
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
		elem: "#LAY-app-menu-list",
		where: {
			parentMenuId: "root"
		},     //传参,判断是否为父节点
		url: "<%= request.getContextPath() %>/framework/menu/queryList",
		method: "get",
		height: "full-" + getFullSize(),
		page: true,
		limit: 10,
		limits: [10, 15, 20, 30],
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
		toolbar: "#toolbar",
		defaultToolbar: [{
			title: "添加",
			layEvent: "add",
			icon: "layui-icon layui-icon-add-circle-fine",
		},{
			title: "删除",
			layEvent: "batchdel",
			icon: "layui-icon layui-icon-delete",
		},"filter"],
		parseData: function(res) {
			return {
				code: res.code,
				msg: res.msg,
				count: res.total,
				data: res.data
			};
		},
		cols:[[{
			type: "checkbox"
		}, {
			title: "序号",
			type: "numbers"
		}, {
			field: "menuCode",
			title: "菜单代码",
			align: "left",
			hide: isHidden("menuCode"),
			sort: true,
			minWidth: 100
		}, {
			field: "menuName",
			title: "菜单名称",
			align: "center",
			hide: isHidden("menuName"),
			sort: true,
			minWidth: 120
		}, {
			field: "menuLabel",
			title: "菜单显示名称",
			align: "center",
			hide: isHidden("menuLabel"),
			minWidth: 150
		}, {
			field: "isLeaf",
			title: "是否叶子菜单",
			align: "center",
			minWidth: 150,
			hide: isHidden("isLeaf"),
			templet:function(d){
				if (d.isLeaf == 1) {
					return "是";
				} else {
					return "否";
				}
			}
		}, {
			field: "menuLevel",
			title: "菜单层次",
			align: "center",
			hide: isHidden("menuLevel"),
			minWidth: 150
		}, {
			field: "displayOrder",
			title: "显示顺序", 
			align: "center",
			hide: isHidden("displayOrder"),
			minWidth: 150
		}, {
			title: "操作",
			align: "center",
			fixed: "right",
			width: 150,
			toolbar: "#table-menu-list"
		}]]
	});
	
	function updata_select() {
	if($("#menuId").val() == "" || $("#menuId").val() == null){
		$("#menuId").empty();
			//下拉框数据
			$.ajax({
				url: "<%= request.getContextPath() %>/framework/menu/queryList",
				type: "GET",
				cache: false,
				contentType: "text/json",
				success: function (json) {
					$('#menuId').append(new Option("",""));
					if (json != null) {
						for (var i = 0; i < json.data.length; i++) {
							if (json.data[i].isLeaf == 0) {
								$('#menuId').append(new Option(json.data[i].menuName,json.data[i].menuId));// 下拉菜单里添加元素
							}
						}
					}
					form.val("layuiadmin-feeding-form",{
						menuId: parentMenuId,
					});
					form.render();
					//form.render("select");//刷新表单select选择框渲染
				}
			});
		}
	}
	
	//下拉框数据
	$.ajax({
		url: "<%= request.getContextPath() %>/framework/menu/queryList",
		type: "GET",
		cache: false,
		contentType: "text/json",
		success: function (json) {
			if (json != null) {
				for (var i = 0; i < json.data.length; i++) {
					if (json.data[i].isLeaf == 0) {
						$('#menuId').append(new Option(json.data[i].menuName,json.data[i].menuId));// 下拉菜单里添加元素
					}
				}
			}
			form.render("select");//刷新表单select选择框渲染
		}
	});
	
	  
	function select(num) {
		var data = {
			isLeaf: num
		};
		table.reload("LAY-app-menu-list", {
			page: {
				curr: 1 //重新从第 1 页开始
			},
      		where:data
 		});
 	}
 		
 	form.on("select(refreshtable)", function(data) {
 		var formData = {
			parentMenuId: data.value
		}
		parentMenuId = data.value;
		reloadData(formData);
		updata_select();

	});
	function reloadData(formData) {
		table.reload("LAY-app-menu-list", {
			where: formData
		});
		if (focusName) {
			$("input[name=" + focusName + "]").focus();
		}
	}
	
	//监听操作事件
	table.on("tool(LAY-app-menu-list)", function(e) {
		var data = e.data;
		if (e.event == "edit") {
			top.layer.open({
				type: 2,
				title: "编辑菜单",
				content: "<%= request.getContextPath() %>/coframe/framework/menu/menu_edit.jsp",
				area: ["820px", "400px"],
				resize: false,
				btn: ["确定", "取消"],
				success: function(layero, index) {
					var dataJson = {
						parentMenuId: $("#menuId").val(),
					   	win: window,
						data: data
				    };	
					layero.find("iframe")[0].contentWindow.SetData(dataJson);
				},
				yes: function(index, layero) {
					var iframe = window["layui-layer-iframe" + index];
					var edit = layero.find("iframe").contents().find("#layuiadmin-app-form-edit");
					edit.click();
				}
			});
		} else if (e.event == "del") {
			layer.confirm("确定删除此菜单？", {
				icon: 3, 
				title: "系统提示"
			}, function(index) {
				var menuIds = new Array();
				menuIds[0] = data.menuId;
				$.ajax({
					url: "<%= request.getContextPath() %>/framework/menu/batchDelete",
					type: "DELETE",
					data: JSON.stringify(menuIds),
					cache: false,
					contentType: "text/json",
					success: function(result) {
						if (result) {
							layer.msg("删除成功", {
								icon: 1,
								time: 2000
							}, function() {
								table.reload('LAY-app-menu-list');
								updata_select();
							});
						} else {
							layer.msg("删除失败");		
						}
					},
					error: function(result) {
						layer.msg(result.retMsg);
	      			}
				});	
			});
		}
	});
	
	$("body").on("click", ".layui-table-body table.layui-table tbody tr td", function() {
		if ($(this).attr("data-field") === "0") return;
		$(this).siblings().eq(0).find('i').click();
	});
</script>
</body>
</html>