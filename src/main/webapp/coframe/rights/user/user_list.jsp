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
<title>用户管理</title>
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
					<label class="layui-form-label">用户名称：</label>
					<div class="layui-input-inline">
						<input type="text" name="userName" placeholder="" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">用户状态：</label>
					<div class="layui-input-inline">
						<select name="status" id="status" type="select" lay-filter="refreshtable">
				 			<option value=""></option>
						</select>		
					</div>
				</div>
				<div class="layui-inline layui-search">
					<button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-userlist-search" id="LAY-app-userlist-search">
						<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
					</button>
				</div>
			</div>
		</div>
		<div class="layui-card-body">
			<div class="layui-toolbar" id="toolbar" hidden="true">
				<button class="layui-btn layuiadmin-btn-list layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-circle-fine"></i>添加</button>
				<button class="layui-btn layuiadmin-btn-list layui-btn-warm layui-btn-sm" lay-event="auth"><i class="layui-icon layui-icon-survey"></i>权限配置</button>
				<button class="layui-btn layuiadmin-btn-list layui-btn-primary layui-btn-sm" lay-event="authCalculate"><i class="layui-icon layui-icon-survey"></i>权限计算</button>
				<button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="resetPassword"><i class="layui-icon layui-icon-read"></i>重置密码</button>
				<button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="batchdel"><i class="layui-icon layui-icon-delete"></i>删除</button>
			</div>
			<table id="LAY-app-user-list" lay-filter="LAY-app-user-list"></table>
			<script type="text/html" id="table-user-list">
			{{#  if(d.operatorId > 1 ){ }}
				<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>
				<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>
			{{#  } else { }}
				<a class="layui-btn  layui-btn-xs layui-btn-disabled" ><i class="layui-icon layui-icon-edit"></i>编辑</a>
				<a class="layui-btn  lay-btn-xs layui-btn-disabled" ><i class="layui-icon layui-icon-delete"></i>删除</a>
			 {{#  } }}
			</script>
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
	//全局参数
	var req_data;
	//过滤字段
	var hiddenFields = [];
	//功能名
	var funName = "user_list";
	
	/*layui.admin.renderDictSelect({    //获取用户状态的下拉值
		elem: "#status",
		dictTypeId: "COF_USERSTATUS"
	});*/
	//状态默认
	$("#status").val("请选择");
	form.render();
	
	//监听搜索
	form.on("submit(LAY-app-userlist-search)", function(data) {
		console.log(data);
		var field = data.field;
		table.reload("LAY-app-user-list-reload", {
			where: field
		});
	});
	
	//下拉框监听事件
	form.on('select(refreshtable)', function(data) {
		var submit = $("#LAY-app-userlist-search");
		submit.click();
	});
	
	//文本框回车事件
	$(".layui-input").on("keydown", function(event) {
		if (event.keyCode == 13) {
			var submit = $("#LAY-app-userlist-search");
			submit.click();
			return false;
		}
	});
	
	var active = {
		add: function() {       //添加用户
			top.layer.open({
				type: 2,
				title: "添加用户",
				content: "<%= request.getContextPath() %>/coframe/rights/user/user_add.jsp",
				area: ["800px", "560px"],
				resize: false,
				btn: ["确定", "取消"],
				success: function(layero, index) {
					var dataJson = {
						win: window,
					};
					layero.find("iframe")[0].contentWindow.SetData(dataJson);
				},
				yes: function(index, layero) {
					var submit = layero.find('iframe').contents().find("#layuiadmin-app-form-submit");
					submit.click();
				}
			});
		},
		auth: function() {
			var checkStatus = table.checkStatus("LAY-app-user-list-reload");
      		var data = checkStatus.data;
      		req_data = data;
			if (data.length == 0) {
				layer.msg("请至少选中一条记录！");
	        } else if (data.length > 1) {
				layer.msg("最多只能选中一条记录！");
	        } else {
	        	var partyId = data[0].userId;
				var url = "<%= request.getContextPath() %>/coframe/auth/partyauth/auth.jsp";//权限配置路径
				top.layer.open({ //开启弹窗
					type: 2, 
					title: "用户授权",
					btn: ["关闭"],
					area: ["650px", "510px"],
					resize: false,
					content: [url, "yes"], //弹窗不出现滚动条
					success: function(layero, index) {
						var dataJson = {
							win: window,
							partyId: partyId,
							partyType: "user"
						};
						layero.find("iframe")[0].contentWindow.SetData(dataJson);
					}
				});
			}
		},
		authCalculate: function() {       //权限计算
			var checkStatus = table.checkStatus("LAY-app-user-list-reload");
			var data = checkStatus.data;
			if (data.length == 0) {
				layer.msg("请至少选中一条记录！");
	        } else { 
				top.layer.open({ //开启弹窗
					type: 2, 
					title: "权限计算",
					area: ["800px", "500px"],
					content: "<%= request.getContextPath() %>/coframe/auth/authgraph/auth_graph.jsp",
					btn: ["关闭"],
					success: function(layero, index) {
						layero.find("iframe")[0].contentWindow.SetData({
							nodeId: data[0].userId,
							partyTypeId: "user"
						});
					},
			    });
			 }
		},
		//重置密码
		resetPassword: function() {
			var checkStatus = table.checkStatus("LAY-app-user-list-reload");
  			var data = checkStatus.data;
			if (data.length == 0) {
      			layer.msg("请至少选中一条记录！");
     	 	} else {
				layer.confirm("是否将密码重置为000000？",{
					icon: 3, 
					title: "系统提示"
				},function(index) {
		    		var index = layer.load("正在重置中,请稍等...", {
		    			icon: 0, 
		    			time: 10000
		    		}); //设定最长等待10秒
					layer.close(index);
	       			$.ajax({
						url: "com.zimax.components.coframe.rights.UserManager.updatePasswords.biz.ext",
						type: "POST",
						data: JSON.stringify({"users":data}),
						cache: false,
						contentType: "text/json",
						success: function(result) {
							if (result.exception) {
	       						layer.alert(result.exception.message, {
									icon: 2,
									title: "系统提示"
								});
							} else if(result) {
								layer.msg("重置成功", {
									icon: 1,
									time: 2000
								}, function() {});
							} else {
								layer.msg("重置失败");		
							}
						},
						error: function(jqXHR, textStatus, errorThrown) {
							layer.msg(jqXHR.responseText, {
								time: 2000,
								icon: 5
							});
						}
					});	
				});
			}
		},
		batchdel: function() {       //批量删除
			var checkStatus = table.checkStatus("LAY-app-user-list-reload");
  			var data = checkStatus.data;
  			for (var i = 0; i < data.length ;i++){
				if (data[i].operatorId == 1) return layer.msg("系统管理员不能删除！");
			}
  			if (data.length == 0) {
				layer.msg("请至少选中一条记录！");
			} else {
				layer.confirm("确定删除所选用户？", {
					icon: 3, 
					title: "系统提示"
				}, function(index) {
					$.ajax({
						url: "com.zimax.components.coframe.rights.UserManager.deleteUsers.biz.ext",
						type: "POST",
						data: JSON.stringify({
							users: data
						}),
						cache: false,
						contentType: "text/json",
						success: function(result) {
							if (data.length == 1 && data[0].userId == "sysadmin") {
								layer.msg("系统管理员不能删除！", {
									icon: 2,
									time: 2000
								});
							} else {
								if (result.exception) {
		       						layer.alert(result.exception.message, {
										icon: 2,
										title: "系统提示"
									});
								} else if (result) {
									layer.msg("删除成功", {
										icon: 1,
										time: 2000
									}, function() {
										table.reload("LAY-app-user-list-reload");
									});
								} else {
									layer.msg("删除失败");		
								}
							}
						},
						error: function(jqXHR, textStatus, errorThrown) {
							layer.msg(jqXHR.responseText, {
								time: 2000,
								icon: 5
							});
						}
					});	
				});	
			} 
		}
	};
	
	//左侧表头按钮事件监听
	table.on('toolbar(LAY-app-user-list)', function(obj) {
		var type = obj.event;
		active[type] ? active[type].call(this) : "";
	});
	
	//表格排序
	table.on('sort(LAY-app-user-list)', function(obj) { 
  		table.reload('LAY-app-user-list-reload', {
			initSort: obj ,
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
		return header.outerHeight(true)  + (cardbody.outerHeight(true) - cardbody.height()) + (fluid.outerHeight(true) - fluid.height()) + 2;
	}
	
	$(window).resize(function() {
		table.reload("LAY-app-user-list-reload", {
			height: "full-" + getFullSize()
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
				hiddenFields = result.colsFilters
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
		elem: "#LAY-app-user-list",
		id: "LAY-app-user-list-reload",
		url: "/mcrs/user/queryUsers",
		method: "post",
		height: "full-" + getFullSize(),
		page: true,
		limit: 10,
		limits: [10, 15, 20, 30],
		toolbar: "#toolbar",
		defaultToolbar: ["filter"],
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
				msg: res.msg,
				count: res.total,
				data: res.users
			};
		},
		cols: [[{
			type: "checkbox",
		}, {
			title: "序号",
			type: "numbers",
		}, {
			field: "userId",
			title: "登录用户名",
			align: "left",
			sort: true,
			hide: isHidden("userId"),
			minWidth: 100
		}, {
			field: "userName",
			title: "用户名称",
			align: "left",
			sort: true,
			hide: isHidden("userName"),
			minWidth: 120,
		}, {
			field: "authMode",
			title: "认证模式",
			align: "center",
			minWidth: 150,
			hide: isHidden("authMode"),
			templet:function(d) {
				return layui.admin.getDictText("COF_AUTHMODE", d.authMode);
			}
		}, {
			field: "status",
			title: "用户状态",
			align: "center",
			minWidth: 120,
			hide: isHidden("status"),
			templet:function(d) {
				return layui.admin.getDictText("COF_USERSTATUS", d.status);
			}
		}, {
			field: "email",
			title: "邮箱",
			align: "left",
			hide: isHidden("email"),
			minWidth: 150
		}, {
			field: "createuser",
			title: "创建人",
			align: "left",
			hide: isHidden("createuser"),
			minWidth: 150
		}, 
		{
			title: "操作",
			align: "center",
			fixed: "right",
			width: 150,
			toolbar: "#table-user-list"
		}]]
	});
	
	//监听操作事件
	table.on("tool(LAY-app-user-list)", function(e) {
		var data = e.data;
		console.log(data);
		if (e.event == "edit") {
			top.layer.open({
				type: 2,
				title: "编辑用户",
				content: "<%= request.getContextPath() %>/coframe/rights/user/user_update.jsp",
				area: ["800px", "560px"],
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
					var edit = layero.find("iframe").contents().find("#layuiadmin-app-form-edit");
					edit.click();
				}
			});
		} else if (e.event == "del") {
			layer.confirm("确定删除该用户？", {
				icon: 3, title: "系统提示"
			}, function(index) {
				$.ajax({
					url: "com.zimax.components.coframe.rights.UserManager.deleteUsers.biz.ext",
					type: "POST",
					data: JSON.stringify({
						"users": data
					}),
					cache: false,
					contentType: "text/json",
					success: function(result) {
						if (data.userId == "sysadmin") {
							layer.msg("系统管理员不能删除！", {
								icon: 2,
								time: 2000
							}, function() {
								table.reload("LAY-app-user-list-reload");
							});
						} else {
							if (result.exception) {
	       						layer.alert(result.exception.message, {
									icon: 2,
									title: "系统提示"
								});
							} else if (result) {
								layer.msg("删除成功", {
									icon: 1,
									time: 2000
								}, function() {
									table.reload("LAY-app-user-list-reload");
								});
							} else {
								layer.msg("删除失败！",{
									icon: 2,
									time: 2000
								});		
							}
						}
					},
					error: function(jqXHR, textStatus, errorThrown) {
						layer.msg(jqXHR.responseText, {
							time: 2000,
							icon: 5
						});
					}
				});	
			});
		}
	});
	
	//批量选中	
	$('body').on("click", ".layui-table-body table.layui-table tbody tr td", function() {
		if ($(this).attr("data-field") === "0") return;
		$(this).siblings().eq(0).find('i').click();
	});	
</script>
</body>
</html>