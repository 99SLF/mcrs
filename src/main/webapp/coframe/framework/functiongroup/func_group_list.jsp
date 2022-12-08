<%@page pageEncoding="UTF-8"%>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>功能组列表</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.1">
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
				<label class="layui-form-label">选择应用：</label>
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
		<table id="LAY-app-funcgroup-list" lay-filter="LAY-app-funcgroup-list"></table>
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
	var flag = true;
	//过滤字段
	var hiddenFields = [];
	//功能名
	var funName = "funcgroup_list"; 
	
	var active = {
		add: function() {
			top.layer.open({
				type: 2,
				title: "添加功能组",
				content: "<%= request.getContextPath() %>/coframe/framework/functiongroup/func_group_add.jsp",
				area: ["450px", "230px"],
				resize: false,
				btn: ["确定", "取消"],
				success: function(layero, index) {
					var dataJson = {
						win:window,
						num: $("#appId").val()
					};
					layero.find("iframe")[0].contentWindow.SetData(dataJson);
				},
				yes: function(index, layero) {
					var submit = layero.find('iframe').contents().find("#layuiadmin-app-form-submit");
					submit.click();	
				}
			});
		},
		//批量删除
		batchdel: function() {   
			var checkStatus = table.checkStatus("LAY-app-funcgroup-list-reload");
      		var data = checkStatus.data;
      		if (data.length === 0){
      			layer.msg('请至少选中一条记录！');	 
      		}
			if (data.length > 0) {
				layer.confirm("确定删除所选功能组？", {
					icon: 3, title: "系统提示"
				}, function(index) {
					var funcGroupIds = new Array();
					for (var i=0; i<data.length;i++) {
						funcGroupIds[i] = data[i].funcGroupId;
					}
					$.ajax({
						url: "/mcrs/framework/funcGroup/batchDelete",
						type: "DELETE",
						data: JSON.stringify(funcGroupIds),
						cache: false,
						contentType: "text/json",
						success: function(result) {
							if (result) {
								layer.msg("删除成功", {
								icon: 1,
								time: 2000
								}, function() {
									table.reload("LAY-app-funcgroup-list-reload");
									updateFunSelect();
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
  });
	 */
	function getFullSize() {
		var header = $(".layui-card-header");
		var cardbody = $(".layui-card-body");
		return header.outerHeight(true)  + (cardbody.outerHeight(true) - cardbody.height())+2;
	}
	
	$(window).resize(function () {
		table.reload("LAY-app-funcgroup-list", {
			height: "full-" + getFullSize()
		});
	});
	
	//左侧表头按钮事件监听
	table.on('toolbar(LAY-app-funcgroup-list)', function(obj){
		var type = obj.event;
		active[type] ? active[type].call(this) : "";
	});
	
	//表格排序
	table.on("sort(LAY-app-funcgroup-list)", function(obj){ 
  		table.reload("LAY-app-funcgroup-list-reload", {
			initSort: obj ,
			where: { 
      			field: obj.field, 
				order: obj.type 
    		}
  		});
	});
	
	function updata_select(flag){
		$('#appId').empty();
		$.ajax({
			url: "/mcrs/framework/application/query",
			type: 'get',
			cache: false,
			contentType: 'text/json',
			success: function (json) {
				if (json != null && json.data != null && json.data.length > 0) {
					for (var i = 0; i < json.data.length; i++) {
						$('#appId').append(new Option(json.data[i].appName,json.data[i].appId));// 下拉菜单里添加元素
					}
					//更新下拉框
					form.render('select');
					$('#refreshtable').val(1);
					var num = $("#appId").val();
					select(num,flag);
				}
			}
		});
	}
	
	
	updata_select(flag);
	
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
	// 			hiddenFields = result.colsFilters
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
	
	function select(num,flag) {
		var data = {
			appId: num
		};
		if (flag == true) {
			table.render({
				elem: "#LAY-app-funcgroup-list",
				id: "LAY-app-funcgroup-list-reload",
				url: "/mcrs/framework/funcGroup/query",
				method: "get",
				where: data,
				toolbar: "#toolbar",
				defaultToolbar: ["filter"],
				height: "full-" + getFullSize(),
				page: true,
				limit: 10,
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
						msg: "",
						count: res.total,
						data: res.data
					};
				},
				//数据渲染完的回调。你可以借此做一些其它的操作;curr:当前页码;count:数据总量
				done: function(res, curr, count) {
				},
				where:{
					appId: $("#appId").val()
				},
				//设置表头。值是一个二维数组。方法渲染方式必填
				cols:[[{
					type: "checkbox"
				}, {
					field: "funcGroupName",
					title: "功能组名称",
					align: "left",
					hide: isHidden("funcGroupName"),
					minWidth: 150
				}, {
					//field:设定字段名。字段名的设定非常重要，且是表格数据列的唯一标识;title:设定标题名称
					field: "groupLevel",
					title: "节点层次",
					align: "center",
					hide: isHidden("groupLevel"),
					minWidth: 100
				}, {
					field: "funcGroupSeq",
					title: "功能组序号",
					align: "center",
					hide: isHidden("funcGroupSeq"),
					minWidth: 100
				}, {
					field: "isLeaf",
					title: "是否叶子节点",
					align: "center",
					hide: isHidden("isLeaf"),
					minWidth: 100
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
			table.reload("LAY-app-funcgroup-list");
		}
 	}
		
	form.on("select(refreshtable)", function(data) {
		debugger;
		var data = {
	  		"appId": data.value
	  	};
		table.reload("LAY-app-funcgroup-list-reload", {
  			page: {
  				//重新从第 1 页开始
				curr: 1 
  			},
  			where:data
    	});
	});
	
	//监听操作事件
	table.on("tool(LAY-app-funcgroup-list)", function(e) {
		var data = e.data;
		if (e.event == "edit") {
			top.layer.open({
				type: 2,
				title: "编辑功能组",
				content: "<%= request.getContextPath() %>/coframe/framework/functiongroup/func_group_edit.jsp",
				area: ["450px", "230px"],
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
					var edit = layero.find("iframe").contents().find("#layuiadmin-app-form-edit");
					edit.click();
				}
			});
		} else if (e.event == "del") {		   		 	        	 
			layer.confirm("确定删除此功能组？", {
				icon: 3, title: "系统提示"
			}, function(index) {
				var funcGroupIds = new Array();
				funcGroupIds[0] = data.funcGroupId;
				$.ajax({
					url: "/mcrs/framework/funcGroup/batchDelete",
					type: "DELETE",
					data: JSON.stringify(funcGroupIds),
					cache: false,
					contentType: "text/json",
					success: function(result) {
						if (result) {
							layer.msg("删除成功", {
								icon: 1,
								time: 2000
							}, function() {
								table.reload("LAY-app-funcgroup-list-reload");
								updateFunSelect();
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
	
	function updateFunSelect(){
		var url = [];   
		url.push("iframe[src='<%= request.getContextPath() %>/coframe/framework/subfunctiongroup/sub_func_group_list.jsp']");
		url.push("iframe[src='<%= request.getContextPath() %>/coframe/framework/function/function_list.jsp']");
		for (var i = 0;i < url.length;i++) {
			var iframeTemp = parent.layui.$(url[i]);
			if (iframeTemp.length) {
				var iframe = iframeTemp[0].contentWindow;
				iframe.window.updata_select(false);
			}
		}
	}
	
	$("body").on("click", ".layui-table-body table.layui-table tbody tr td", function() {		
		if ($(this).attr("data-field") === "0") return;
		$(this).siblings().eq(0).find('i').click();
	});
</script>
</body>
</html>