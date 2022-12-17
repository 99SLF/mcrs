<%@page pageEncoding="UTF-8"%>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>功能列表</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.0">
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
				<label class="layui-form-label" style="white-space:nowrap">选择子功能组：</label>
				<div class="layui-input-inline">
					<select name="appId" id="appId" lay-verify="required"  lay-filter="refreshtable" type="select" >           		
               			<option value=""></option>
               		</select>
				</div>						
			</div>
		</div>
	</div>
	<div class="layui-card-body">
		<div class="layui-toolbar" id="toolbar" hidden="true">
			<button class="layui-btn layuiadmin-btn-list layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-circle-fine"></i>添加</button>
			<button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="batchdel"><i class="layui-icon layui-icon-delete"></i>删除</button>
		</div>
		<table id="LAY-app-function-list" lay-filter="LAY-app-function-list"></table>
		<script type="text/html" id="table-role-list">
				<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>
				<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>
			</script>
	</div>
</div>
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script type="text/javascript">
	var layer = layui.layer;
	var table = layui.table;
	var form = layui.form;
	var $ = layui.jquery;
	var funcGroupName ="";
	var  num1 = $("#appId").val(); 
	var num;
	var flag = true;
	
	//状态默认
	$("#appId").val("请选择");
	form.render();
	
		
	var active = {
		add: function() {
			top.layer.open({
				type: 2,
				title: "添加功能",
				content: "<%= request.getContextPath() %>/coframe/framework/function/function_add.jsp",
				area: ["800px", "530px"],
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
			var checkStatus = table.checkStatus("LAY-app-function-list-reload");
			var data = checkStatus.data;
			if (data.length === 0 ){
      			layer.msg("请至少选中一条记录！")
			}
			if (data.length > 0) {
				layer.confirm("确定删除所选功能？", {
					icon: 3, 
					title: "系统提示"
				}, function(index) {
					var funcCodes = new Array();
					for (var i=0; i<data.length;i++) {
				 		funcCodes[i] = data[i].funcCode;
					}		
					$.ajax({
						url: "<%= request.getContextPath() %>/framework/function/batchDelete",
						type: "DELETE",
						data: JSON.stringify(funcCodes),
						cache: false,
						contentType: "text/json",
						success: function(result) {
							if (result) {
								layer.msg("删除成功", {
									icon: 1,
									time: 2000
								}, function() {
									table.reload("LAY-app-function-list-reload");
									updateFuncresourceSelect();
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
	
	$(".layui-btn.layuiadmin-btn-list").on("click", function() {
		var type = $(this).data("type");
		active[type] ? active[type].call(this) : "";
	});
	
	function getFullSize() {
		var header = $(".layui-card-header");
		var cardbody = $(".layui-card-body");
		return header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height())+ 2;
	}
		
	$(window).resize(function () {
		table.reload("LAY-app-function-list", {
			height: "full-" + getFullSize()
		});
	});
	
	//左侧表头按钮事件监听
	table.on('toolbar(LAY-app-function-list)', function(obj){
		var type = obj.event;
		active[type] ? active[type].call(this) : "";
	});
	
	//表格排序事件
	table.on("sort(LAY-app-function-list)", function(obj) {
		table.reload("LAY-app-function-list-reload", {
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
	//更改下拉框事件
	function updata_select(flag) {
		$("#appId").empty();
	 	$.ajax({
			url: "<%= request.getContextPath() %>/framework/funcGroup/query",
			type: "get",
			cache: false,
			contentType: "text/json",
			success: function (json) {
				if (json != null && json.data != null && json.data.length > 0) {
					for (var i = 0;i <json.data.length; i++) {
						$("#appId").append(new Option(json.data[i].funcGroupName,json.data[i].funcGroupId));// 下拉菜单里添加元素										
					}
					form.render("select");//更新下拉框
					$("#refreshtable").val(1);
					funcGroupName = json.data[0].funcGroupName
					var num = $("#appId").val();
					select(num,flag);
				}		
			}
	  });
	}
   
  updata_select(flag);
	
	function select(num,flag){
		if	(flag == true){
			var data = {
				funcGroupId: num
			};
			table.render({
				elem: "#LAY-app-function-list",
				id: "LAY-app-function-list-reload",
				url: "<%= request.getContextPath() %>/framework/function/query",
				method: "get",
				where: data,
				height: "full-" + getFullSize(),
				page: true,
				limit: 10,
				toolbar: "#toolbar",
				defaultToolbar: ["filter"],
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
				parseData: function(res) {
					return {
						code: res.code,
						msg: "",
						count: res.total,
						data: res.data
					};
				},
				done: function(res, curr, count) { 
				},
				cols:[[{ 
				//设置表头。值是一个二维数组。方法渲染方式必填
					type: "checkbox"
				}, {
					field: "funcName",
					title: "功能名称",
					align: "left",
					hide: isHidden("funcName"),
					minWidth: 150
				}, { 
				//field:设定字段名。字段名的设定非常重要，且是表格数据列的唯一标识;title:设定标题名称
					field: "funcType",
					title: "功能类型",
					align: "center",
					minWidth: 100,
					hide: isHidden("funcType"),
					templet: function(d){
						if (d.funcType == "flow") {
							return "页面流";
						} else if(d.funcType == "page") {
							return "页面";
						} else if(d.funcType == "form") {
							return "表单";
						} else if(d.funcType == "view") {
							return "视图";
						} else if(d.funcType == "startprocess") {
							return "启动流程";
						} else {
							return "其他";
						}
					}
				}, {
					field: "isMenu",
					title: "是否定义为菜单",
					align: "center",
					minWidth: 150,
					hide: isHidden("isMenu"),
					templet: function(d){
						if (d.isMenu == 1) {
							return "是";
						} else {
							return "否";
					  }
					}
				}, {			
					field: "funcGroupName",
					title: "所属功能组",
					align: "center",
					minWidth: 150,
					hide: isHidden("funcGroupName"),
					templet: function(d){
						return funcGroupName;
					}
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
					toolbar: "#table-role-list"
				}]]
			});
		} else {
			table.reload("LAY-app-function-list-reload",{
				where: {
					funcGroupId: num
				},
			});
		}
 	}
		
	form.on("select(refreshtable)", function(data){
		funcGroupName = data.elem[data.elem.selectedIndex].text;
		var data = {
			funcGroupId: data.value
		};
		table.reload("LAY-app-function-list-reload", {
     		 page: {
      			curr: 1 //重新从第 1 页开始
			},
		where:data
    	});
	});
		
	//监听操作事件
	table.on("tool(LAY-app-function-list)", function(e) {
		var data = e.data;
		if (e.event == "edit") {
		  req_data = JSON.stringify(data);
			top.layer.open({
				type: 2,
				title: "编辑功能",
				content: "<%= request.getContextPath() %>/coframe/framework/function/function_edit.jsp",
				area: ["800px", "530px"],
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
			layer.confirm("确定删除此功能？", {
				icon: 3, 
				title: "系统提示"
			}, function(index) {
			  var funcCodes = new Array();
			funcCodes[0] = data.funcCode
				$.ajax({
					url: "<%= request.getContextPath() %>/framework/function/batchDelete",
					type: "delete",
					data: JSON.stringify(funcCodes),
					cache: false,
					contentType: "text/json",
					success: function(result) {
						if (result.code==0) {
							layer.msg("删除成功", {
								icon: 1,
								time: 2000
							}, function() {
								table.reload("LAY-app-function-list-reload");
								updateFuncresourceSelect();
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
	
	function updateFuncresourceSelect(){
		var url = [];   
		url.push("iframe[src='<%= request.getContextPath() %>/coframe/framework/functionresource/func_resource_list.jsp']");
		for (var i = 0; i < url.length; i++) {
			var iframeTemp = parent.layui.$(url[i]);
			if (iframeTemp.length) {
				var iframe = iframeTemp[0].contentWindow;
				iframe.window.updata_select(false);
			}
		}
	}
	
	$("body").on("click", ".layui-table-body table.layui-table tbody tr td", function() {
		if ($(this).attr("data-field") === "0") return;
		$(this).siblings().eq(0).find("i").click();
	});
</script>
</body>
</html>