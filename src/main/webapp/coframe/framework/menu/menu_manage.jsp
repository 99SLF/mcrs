<%@page pageEncoding="UTF-8"%>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
<title>菜单管理</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.0">
</head>
<body>
<div class="layui-fluid">
	<div class="layui-card">
		<div class="layui-form layui-card-header layuiadmin-card-header-auto">
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
		<div class="layui-card-body">
			<div class="layui-toolbar" id="toolbar" hidden="true">
				<button class="layui-btn layuiadmin-btn-list layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-circle-fine"></i>添加</button>
				<button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="batchdel"><i class="layui-icon layui-icon-delete"></i>删除</button>
			</div>
			<table id="LAY-app-menu-list" lay-filter="LAY-app-menu-list"></table>
			<script type="text/html" id="table-menu-list">
				<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>
				<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>
			</script>
		</div>
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
	var funName = "subfuncgroup_list"; 
	
	form.render();
	var menuData = {};
	var parentMenuId = null;

	var active = {
		//传值，判断
		add: function() {
			top.layer.open({
				type: 2,
				title: "添加菜单",
				content:  '<%= request.getContextPath() %>/coframe/framework/menu/menu_add.jsp',
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
					$.ajax({
						url: "com.zimax.components.coframe.framework.MenuManager.deleteMenus.biz.ext",
						type: "POST",
						data: JSON.stringify({
							nodes: nodes
						}),
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
	
	//查询过滤字段
	$.ajax({
		url: "com.zimax.components.coframe.tools.ColsFilter.queryHiddenField.biz.ext",
		type: "POST",
		async: false ,
		data: JSON.stringify({
			funName: funName
		}),
		cache: false,
		contentType: "text/json",
		success: function(result) {
			if (result) {
				hiddenFields = result.colsFilters;
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
		url: "com.zimax.components.coframe.framework.MenuManager.queryMenu.biz.ext",
		method: "post",
		height: "full-" + getFullSize(),
		page: true,
		limit: 10,
		limits: [10, 15, 20, 30],
		colHideChange: function(col, checked) {
			var field = col.field;
			var hidden = col.hide;
			$.ajax({
				url: "com.zimax.components.coframe.tools.ColsFilter.setHiddenField.biz.ext",
				type: "POST",
				data: JSON.stringify({
					hidden: hidden,
					colsFilter: {
						funName: funName,
						field: field
					}
				}),
				cache: false,
				contentType: "text/json",
				success: function(result) {
					if (!result) {
						layer.msg("列筛选失败");		
					}
				}
			});	
		},
		toolbar: "#toolbar",
		defaultToolbar: ["filter"],
		parseData: function(res) {
			return {
				code: res.code,
				msg: res.msg,
				count: res.total,
				data: res.menus
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
				url: "com.zimax.components.coframe.framework.MenuManager.queryMenuList.biz.ext",
				type: "post",
				cache: false,
				contentType: "text/json",
				success: function (json) {
					$('#menuId').append(new Option("",""));
					if (json != null) {
						for (var i = 0; i < json.menus.length; i++) {
							if (json.menus[i].isLeaf == 0) {
								$('#menuId').append(new Option(json.menus[i].menuName,json.menus[i].menuId));// 下拉菜单里添加元素
							}
						}
					}
					form.render("select");//刷新表单select选择框渲染
				}
			});
		}
	}
	
	//下拉框数据
	$.ajax({
		url: "com.zimax.components.coframe.framework.MenuManager.queryMenuList.biz.ext",
		type: "post",
		cache: false,
		contentType: "text/json",
		success: function (json) {
			if (json != null) {
				for (var i = 0; i < json.menus.length; i++) {
					if (json.menus[i].isLeaf == 0) {
						$('#menuId').append(new Option(json.menus[i].menuName,json.menus[i].menuId));// 下拉菜单里添加元素
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
		if (data.value) {
		  	var data = {
		  		parentMenuId: data.value
		  	};
		  	parentMenuId = data.parentMenuId;
   		} else {
   			var data = { 
   				parentMenuId: "root"
   			};
   			parentMenuId = null;
   		}
	  	table.reload('LAY-app-menu-list', {
  			where: data
		});
	});
	
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
					    data: data,
					   	win: window
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
				var nodes = [];
				nodes.push({menuId:data.menuId});
				$.ajax({
					url: "com.zimax.components.coframe.framework.MenuManager.deleteMenus.biz.ext",
					type: "POST",
					data: JSON.stringify({
						"nodes": nodes
					}),
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