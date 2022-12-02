<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%--<%@page import="com.mes.system.utility.StringUtil"%>--%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
</head>
<body style="width:100%;background-color:white">
<div class="layui-tab-content page-tab-content">
		<div class="layui-tab-item layui-show">
			<form class="layui-form" method="post">
				菜单名称：
				<div class="layui-inline layui-show-ms-block"><!--获取数据字典数据-->
					<select name="menuId" lay-filter="refreshtable" class="field-menuId" id="menuId" type="select">
						<option value=""></option>
					</select>
					<input type="hidden" name="isLeaf" value="1" />
				</div>
			</form>
			<table class="layui-table mt10" lay-even="" lay-skin="row" id="menuInfo" lay-filter="menuInfo">
			</table>
		</div>
</div>
<script type="text/html" id="toolbar">
  	<a lay-event="add" class="layui-btn layui-btn-sm"><i class="layui-icon layui-icon-add-circle-fine"></i>添加</a>
	<a lay-event="edit" class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon layui-icon-edit"></i>编辑</a>
	<a lay-event="remove" class="layui-btn layui-btn-danger layui-btn-sm"><i class="layui-icon layui-icon-delete"></i>删除</a>
</script>
		
<script type="text/javascript">
	var req_data; //全局变量
	
	var layer = layui.layer;
	var table = layui.table;
	var form = layui.form;
	var $ = layui.jquery;
	  
	form.render();
	
	//数据表格
	table.render({
		elem: "#menuInfo",
		method: "post",
		where: {
			parentmenuid: "root"
		},     //传参,判断是否为父节点
		url: "com.zimax.components.coframe.framework.MenuManager.queryMenu.biz.ext",
		title: "功能列表"	,
		page: true , //开启分页,
		height : "full-30",
		limit: 10,
		limits: [10, 20, 30, 40],
	    toolbar: "#toolbar" ,//开启工具栏，此处显示默认图标，可以自定义模板，详见文档
	    defaultToolbar: [],
	    totalRow: false ,//开启合计行
		parseData: function(res) {
			return {
	        	code: res.code, //解析接口状态
	        	msg: res.msg, //解析提示文本
	        	count: res.total, //解析数据长度
	        	data: res.menus //解析数据列表
			};	
		},
		cols: [[{ //设置表头。值是一个二维数组。方法渲染方式必填
			type: "checkbox"
		}, {
			field: "menuCode",
			title: "菜单代码",
			align: "center"
		}, { //field:设定字段名。字段名的设定非常重要，且是表格数据列的唯一标识;title:设定标题名称
			field: "menuName",
			title:"菜单名称",
			align:"center"
		}, {
			field: "menuLabel",
			title: "菜单显示名称",
			align: "center"
		}, {
			field: "isLeaf",
			title: "是否叶子菜单",
			align: "center",
			templet: function(d){
				if (d.isLeaf == 1) {
					return "是";
				} else {
					return "否";
			    }
			}
		}, {
			field: "menuLevel",
			title: "菜单层次",
			align: "center"
		}]]
	});
	
	$.ajax({
		url: "com.zimax.components.coframe.framework.MenuManager.queryMenu.biz.ext",
		type: "post",
		cache: false,
		contentType: "text/json",
		success: function (json) {
			if (json != null) {
				for (var i = 0; i < json.menus.length; i++) {
					if (json.menus[i].isLeaf == 0) {
						$("#menuId").append(new Option(json.menus[i].menuName,json.menus[i].menuId));// 下拉菜单里添加元素
					}
				}
			}
			form.render("select");//刷新表单select选择框渲染
		}
	});
	  
	function select(num){
		var data = {
			isLeaf: num
		};
		table.reload("menuInfo", {
			page: {
				curr: 1 //重新从第 1 页开始
			},
  			where: data
	 	});
 	}
	   
	form.on("select(refreshtable)", function(data) {
	  	var data = {
	  		parentmenuid: data.value
	  	};
	  	table.reload("menuInfo", {
  			page: {
				curr: 1 //重新从第 1 页开始
  			},
  			where: data
    	});
	});
	    
	    //监听头工具栏事件
    table.on("toolbar(menuInfo)", function(obj) {
	  	var checkStatus = table.checkStatus(obj.config.id),
  	 	data = checkStatus.data; //获取选中的数据
    	if (obj.event === "add") {
    		var url = "<%= request.getContextPath() %>/coframe/framework/menu/menu_add.jsp";
	    	top.layer.open({ //开启弹窗
				type: 2, 
				title: "添加菜单",
				area: ["479px", "340px"],
				content: [url, "no"],
				end: function () {  //关闭弹窗后事件
		    		table.reload("menuInfo", { //表格重载
			      		url: "com.zimax.components.coframe.framework.MenuManager.queryMenu.biz.ext" ,
			        	page: {
				          	curr: 1 //重新从第 1 页开始
			        	}
			      	});
		    	}
	    	});
	    } else if (obj.event == "edit") {
	    	if (data.length === 0) {
     		 	layer.msg("请至少选中一条记录！");
	        } else {
		    	req_data = JSON.stringify(data);  //使用全局变量传参
		    	var url = "<%= request.getContextPath() %>/coframe/framework/menu/menu_edit.jsp";
		      	layer.open({ //开启弹窗
					type: 2, 
					title: "编辑菜单",
					area: ["479px", "340px"],
					content: [url, "no"],   //no 不出现滚动条
					end: function () {
			        	table.reload("menuInfo", {
					      	url: "com.zimax.components.coframe.framework.MenuManager.queryMenu.biz.ext",
					        page: {
					  	        curr: 1 //重新从第 1 页开始
					    	}
						});
		            }
				});
			}
		} else if (obj.event == "remove") {
			if (data.length == 0) {
			    layer.msg("请至少选中一条记录！");
			} else { 
				layer.confirm("确定删除选中记录？", {
					icon: 3,
				 	title: "系统提示"
				 }, function(index) {
					$.ajax({
						url: "com.zimax.components.coframe.framework.MenuManager.deleteMenus.biz.ext",
						type: "POST",
						data: JSON.stringify({"nodes": data}),
						cache: false,
						contentType: "text/json",
						success: function(result) {
							if (result) {
								layer.msg("删除成功", {
									icon: 1,
									time: 2000
								}, function() {
									table.reload("menuInfo", {
								      	url: "com.zimax.components.coframe.framework.MenuManager.queryMenu.biz.ext",
						    		    page: {
						          			curr: 1 //重新从第 1 页开始
						        		}
									});
	        					});
							} else {
							 	layer.msg("删除失败");		
							}
						}
					});	
		    	});
			}
		}
	});
</script>
</body>
</html>