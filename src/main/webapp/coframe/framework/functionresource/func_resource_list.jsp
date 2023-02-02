<%@page pageEncoding="UTF-8"%>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>资源列表</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.0">
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
					<label class="layui-form-label">选择功能：</label>
					<div class="layui-input-inline">
						<select name="appId" id="appId" lay-verify="required"  lay-filter="refreshtable" type="select" lay-search="">
						</select>
					</div>
				</div>
			</div>
		</div>
	</script>
	<div class="layui-card-body">
		<table id="LAY-app-funcresource-list" lay-filter="LAY-app-funcresource-list"></table>
		<script type="text/html" id="table-role-list">
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
<script type="text/javascript">
	var layer = layui.layer;
	var table = layui.table;
	var form = layui.form;
	var $ = layui.jquery;
	var num1 = $("#appId").val(); 
	var num;
	var focusName = null;
	var flag = true;
	//过滤字段
	var hiddenFields = [];
	//功能名
	var funName = "subfuncgroup_list";
	var funcName ="";
	
	var active = {
		add: function() {
			top.layer.open({
				type: 2,
				title: "添加资源",
				content: "<%= request.getContextPath() %>/coframe/framework/functionresource/func_resource_add.jsp",
				area: ["800px", "290px"],
				resize: false,
				btn: ["确定", "取消"],
				success: function(layero, index) {
					var dataJson = {
						win: window,
						num: $("#appId").val()
					};
					layero.find("iframe")[0].contentWindow.SetData(dataJson);
				},
				yes: function(index, layero) {
					var submit = layero.find("iframe").contents().find("#layuiadmin-app-form-submit");
					submit.click();
				}
			});
		},
		batchdel: function() {       //批量删除		
			var checkStatus = table.checkStatus("LAY-app-funcresource-list-reload");
      		var data = checkStatus.data;
     		if (data.length === 0 ){
      			layer.msg("请至少选中一条记录！")
      		}
			if (data.length > 0) {
				layer.confirm("确定删除所选资源？", {
					icon: 3, 
					title: "系统提示"
				}, function(index) {
					var resIds = new Array();
					for (var i=0; i<data.length;i++) {
						resIds[i] = data[i].resId;
					}
			     	$.ajax({
						url: "<%= request.getContextPath() %>/framework/funcResource/batchDelete",
						type: "DELETE",
						data: JSON.stringify(resIds),
						cache: false,
						contentType: "text/json",
						success: function(result) {
							if (result) {
								layer.msg("删除成功", {
									icon: 1,
									time: 2000
								}, function() {
									table.reload("LAY-app-funcresource-list-reload");
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
				})
		    } 
		}
	};
	
	/* $(".layui-btn.layuiadmin-btn-list").on("click", function() {
		var type = $(this).data("type");
		active[type] ? active[type].call(this) : "";
	}); */
	
	function getFullSize() {
		var header = $(".layui-card-header");
		var cardbody = $(".layui-card-body");
		return header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height())+2;
	}
		
	$(window).resize(function () {
		table.reload("LAY-app-funcresource-list", {
			height: "full-" + getFullSize()
		});
	});
	
	//表格左侧工具栏监听事件
	table.on("toolbar(LAY-app-funcresource-list)", function(obj){
		var type = obj.event;
		active[type] ? active[type].call(this) : "";
	});

	$.ajax({
		url: "<%= request.getContextPath() %>/framework/function/query",
		type: "GET",
		cache: false,
		contentType: "text/json",
		success: function (json) {
			if (json != null && json.data != null && json.data.length > 0) {
				$("#appId").empty();
				for (var i = 0;i <json.data.length; i++) {
					$("#appId").append(new Option(json.data[i].funcName,json.data[i].funcCode));// 下拉菜单里添加元素
				}
				form.render("select");//更新下拉框
				$("#refreshtable").val(json.data[0].funcCode);
				funcName = json.data[0].funcName
				num = json.data[0].funcCode;
				//var num = $("#appId").val();
				//select(num,flag);
			}
		}
	});
	//表格排序
	table.on('sort(LAY-app-funcresource-list)', function(obj){ 
  		table.reload('LAY-app-funcresource-list-reload', {
			initSort: obj ,
			where: { 
      			field: obj.field, 
				order: obj.type 
    		}
  		});
	});
	
	function updata_select(flag) {
		$("#appId").empty();
	 	$.ajax({
			url: "<%= request.getContextPath() %>/framework/function/query",
			type: "GET",
			cache: false,
			contentType: "text/json",
			success: function (json) {
				if (json != null && json.data != null && json.data.length > 0) {
					for (var i = 0;i <json.data.length; i++) {
						$("#appId").append(new Option(json.data[i].funcName,json.data[i].funcCode));// 下拉菜单里添加元素											
					}
					form.val("layuiadmin-feeding-form",{
						appId: num,
					});
					form.render();
				}
			}
	  });
	}
	
	updata_select(flag);

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
		elem: "#LAY-app-funcresource-list",
		id: "LAY-app-funcresource-list-reload",
		url: "<%= request.getContextPath() %>/framework/funcResource/query",
		method: "GET",
		height: "full-" + getFullSize(),
		page: true,
		limit: 10,
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
		defaultToolbar:[{
			title: "添加",
			layEvent: "add",
			icon: "layui-icon layui-icon-add-circle-fine",
		},{
			title: "删除",
			layEvent: "batchdel",
			icon: "layui-icon layui-icon-delete",
		},"filter"],
		limits: [10, 15, 20, 30],
		parseData: function(res) {
			return {
				code: "0",
				msg: "",
				count: res.total,
				data: res.data
			};
		},
		//数据渲染完的回调。你可以借此做一些其它的操作;curr:当前页码;count:数据总量
		done: function(res, curr, count){
			form.val("layuiadmin-feeding-form",{
				appId:num,
			});
			form.render();
		},
		where:{
			funcCode: $("#appId").val()
		},
		//设置表头。值是一个二维数组。方法渲染方式必填
		cols:[[{
			type: "checkbox"
		}, {
			field: "resName",
			title: "资源名称",
			align: "left",
			hide: isHidden("resName"),
			minWidth: 150
		}, {
			field: "resType",
			title: "资源类型",
			align: "center",
			hide: isHidden("resType"),
			minWidth: 150,
			templet:function(d){
				if (d.resType == "flow") {
					return "页面流";
				} else if (d.resType == "page"){
					return "页面";
				} else if (d.resType == "form"){
					return "表单";
				} else if (d.resType == "view"){
					return "视图";
				} else if (d.resType == "startprocess"){
					return "启动流程";
				} else {
					return "其他";
				}
			}
		}, {
			field: "resPath",
			title: "资源路径",
			align: "center",
			hide: isHidden("resPath"),
			minWidth: 150,
			templet: function(d){
				return d.resPath;
			}
		}, {
			field: "comPackName",
			title: "所属构建包",
			align: "center",
			hide: isHidden("comPackName"),
			minWidth: 150
		}, {
			title: "操作",
			align: "center",
			fixed: "right",
			width: 150,
			toolbar: "#table-role-list"
		}]]
	});
		
	form.on("select(refreshtable)", function(data){
		num  = data.value
		var data = {
			funcCode: data.value
		};
		reloadData(data);
		updata_select(flag);
	});
	function reloadData(formData) {
		table.reload("LAY-app-funcresource-list-reload", {
			page: {
				//重新从第 1 页开始
				curr: 1
			},
			where: formData
		});
		if (focusName) {
			$("input[name=" + focusName + "]").focus();
		}
	}
		
	//监听操作事件
	table.on("tool(LAY-app-funcresource-list)", function(e) {
		var data = e.data;
		if (e.event == "edit") {
			top.layer.open({
				type: 2,
				title: "编辑资源",
				content: "<%= request.getContextPath() %>/coframe/framework/functionresource/func_resource_edit.jsp",
				area: ["800px", "290px"],
				resize: false,
				btn: ["确定", "取消"],
				success: function(layero, index) {	
				  var dataJson = {
				   	data : data,
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
			layer.confirm("确定删除此资源？", {
				icon: 3, 
				title: "系统提示"
			}, function(index) {
				var resIds = new Array();
				resIds[0] = data.resId
				$.ajax({
					url: "<%= request.getContextPath() %>/framework/funcResource/batchDelete",
					type: "DELETE",
					data: JSON.stringify(resIds),
					cache: false,
					contentType: "text/json",
					success: function(result) {
						if (result) {
							layer.msg("删除成功", {
								icon: 1,
								time: 2000
							}, function() {
								table.reload("LAY-app-funcresource-list-reload");
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
		$(this).siblings().eq(0).find("i").click();
	});
</script>
</body>
</html>