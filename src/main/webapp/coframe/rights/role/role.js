/**
 * 角色管理模块
 */
layui.define(["admin"], function(exports) {
	var $ = layui.$;
	var setter = layui.setter;
	var form = layui.form;
	var table = layui.table;
	// 是否已初始化
	var isInit = false;
	var hiddenFields = [];
	// 调用窗口对象
	var win = null;
	
	//是否已提交
	var submit = false;
	
	// 操作类型
	var type = null;
	
	/**
	 * 操作类型
	 */
	var Type = {
		/**
		 * 添加
		 */
		add: "add",
		
		/**
		 * 修改
		 */
		update: "update"
	};
	
	// 功能名
	var funName = "subfuncgroup_list";
	
	//获取接口地址
	var getUrl = setter.base + "rights/role/find";
	
	//添加接口地址
	var addUrl = setter.base + "rights/role/add";
	var focusName = null;
	//修改接口地址
	var updateUrl = setter.base + "rights/role/update";
    //删除接口地址
	var deleteUrl = setter.base + "rights/role/delete";
	//批量删除接口地址
	var batchDelUrl = setter.base + "rights/role/batchDelete";
	form.render();
	form.verify({
		//数组的两个值分别代表：[正则匹配、匹配不符时的提示文字]
		chinese: function(value, item){ //value：表单的值、item：表单的DOM对象
			var reg = new RegExp("[\\u4E00-\\u9FFF]+", "g");
			if((reg.test(value))){
				return '此项不能包含中文';
			}
		},
		length20: function(value, item){ //value：表单的值、item：表单的DOM对象
			if(value.length>20){
				return '字数已达上限';
			}
		},
		length255: function(value, item){ //value：表单的值、item：表单的DOM对象
			if(value.length>255){
				return '字数已达上限';
			}
		}
	});
	function getFullSize() {
		var fluid = $(".layui-fluid");
		var header = $(".layui-card-header");
		var cardbody = $(".layui-card-body");
		return header.outerHeight(true)  + (cardbody.outerHeight(true) - cardbody.height()) + 
				(fluid.outerHeight(true) - fluid.height()) + 2;
	}
	
	/**
	 * 判断是否隐藏函数
	 */
	function isHidden(field) {
		for (var i = 0; i < hiddenFields.length; i++) {
			if (hiddenFields[i].field == field ) {
				return true;
			}
		}
		return false;
	}

	// 查询过滤字段
	$.ajax({
		url: "/mcrs/cols/filter/query/" + funName,
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

	/**
	 * 渲染表格
	 */
	function renderTable() {
		table.render({
			elem: "#LAY-app-role-list",
			url: "/mcrs/rights/role/query",
			method: "get",
			height: "full-" + getFullSize(),
			page: true,
			limit: 10,
			limits: [10, 15, 20, 30],
			toolbar: "#toolbar",
			colHideChange: function(col, checked) {
				var field = col.field;
				var hidden = col.hide;
				$.ajax({
					url: "/mcrs/cols/filter/set?funName=" + funName + "&field=" + field + "&hidden=" + hidden,
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
			defaultToolbar: [{
				title: "查询",
				layEvent: "search",
				icon: "layui-icon layui-icon-search layuiadmin-button-btn",
			},{
				title: "添加",
				layEvent: "add",
				icon: "layui-icon layui-icon-add-circle-fine",
			},{
				title: "删除",
				layEvent: "batchdel",
				icon: "layui-icon layui-icon-delete",
			},"filter"],
			parseData: function(res) {
				var t = res.data.length;
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
				field: "roleCode",
				title: "角色代码",
				align: "left",
				hide: isHidden("roleCode"),
				sort: true,
				minWidth: 100
			}, {
				field: "roleName",
				title: "角色名称",
				align: "left",
				hide: isHidden("roleName"),
				minWidth: 120
			}, {
				field: "roleDesc",
				title: "角色描述",
				align: "left",
				hide: isHidden("roleDesc"),
				minWidth: 150
			}, {
				title: "操作",
				align: "center",
				fixed: "right",
				width:  150,
				toolbar: "#table-role-list"
			}]]
		});
		formReder();
	}
	
	// 操作集合
	var active = {
		search: function() {
			var submit = $("#LAY-app-rolelist-search");
			submit.click();
			return false;
		},

		/**
		 * 添加角色
		 */
		add: function() {
			top.layer.open({
				type: 2,
				title: "添加角色",
				content: setter.base+"coframe/rights/role/role_add.jsp",
				area: ["450px", "350px"],
				resize: false,
				btn: ["确定", "取消"],
				success: function(layero, index) {
					var contentWindow = layero.find("iframe")[0].contentWindow;
					 var role = contentWindow.layui.role;
					if (role) {
						var initData = {
					    	win: window,
					    	type: role.Type.add
					    };
						role.init(initData);
					}
					isInit = true;
				},
				yes: function(index, layero) {
					var submit = layero.find("iframe").contents().find("#layuiadmin-app-form-submit");
					submit.click();
				}
			});
		},
		
		/**
		 * 批量删除
		 */
		batchdel: function() {
			var checkStatus = table.checkStatus("LAY-app-role-list");
			var data = checkStatus.data;
			var roleIds = new Array();
			for (var i = 0; i < data.length ;i++){
				if (data[i].roleId == 1) return layer.msg("系统管理员不能删除！");
				roleIds[i] = parseInt(data[i].roleId);
			}
  			if (data.length == 0) {
				layer.msg("请至少选中一条记录!");
			} else {
				layer.confirm("确定删除所选角色？", {
					icon: 3,
					title: "系统提示"
				}, function(index) {
					$.ajax({
						url: batchDelUrl,
						type: "delete",
						data: JSON.stringify(roleIds),
						cache: false,
						contentType: "text/json",
						success: function(result) {
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
									table.reload("LAY-app-role-list");
									formReder();
								});
							} else {
								layer.msg("删除失败");		
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
	
	/**
	 * 加载数据
	 */
	function loadData(data) {
		var json = {
			roleId: data.roleId
		};
		$.ajax({
			url: getUrl+"/"+data.roleId,
			type: "get",
			cache: false,
			contentType: "text/json",
			success: function(result) {
				if (result.exception) {
					layer.alert(result.exception.message, {
						icon: 2,
						title: "系统提示"
					});
				} else if (result.code == 0) {
					if (result.data) {
						var role = result.data;
						form.val("layuiadmin-app-form-list", {
							"capRole/roleId": role.roleId,
							"capRole/roleCode": role.roleCode,
							"capRole/roleName": role.roleName,				
							"capRole/roleDesc": role.roleDesc
						});
						isInit = true;
					}
				} else {
					layer.alert(result.msg, {
						icon: 2,
						title: "系统提示"
					}, function() {
						var index = parent.layer.getFrameIndex(window.name);
						win.layui.table.reload("LAY-app-role-list");
						formReder();
						parent.layer.close(index);
					});
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				layer.alert(jqXHR.responseText, {
					icon: 2,
					title: "系统提示"
				}, function() {
					var index = parent.layer.getFrameIndex(window.name);
					win.layui.table.reload("LAY-app-role-list");
					formReder();
					parent.layer.close(index);
				});
			}
		});
	}
	
	/**
	 * 提交事件
	 */
	function onSubmit() {
		//监听提交事件
		form.on("submit(layuiadmin-app-form-submit)", function(data) {
			isInit = true;
			if (!isInit) {
				layer.msg("正在加载数据，请稍后！", {
					icon: 1,
					time: 2000
				});
				return;
			}
			if (submit == false) {
				var url = addUrl;
				if (type == Type.update)
					url = updateUrl;
				var dataForm = data.field;
				var dataJson={
					"roleId": dataForm["capRole/roleId"],
					"roleCode": dataForm["capRole/roleCode"],
					"roleName": dataForm["capRole/roleName"],
					"roleDesc": dataForm["capRole/roleDesc"],
				}
				var submitData = JSON.stringify(dataJson);
				$.ajax({
					url: url,
					type: "POST",
					data: submitData,
					cache: false,
					contentType: "text/json",
					success: function(result) {
						if (result.exception) {
							layer.alert(result.exception.message, {
								icon: 2,
								title: "系统提示"
							});
						} else if (result.code == 0) {
							layer.msg(result.msg, {
								time: 2000,
								icon: 1
							}, function() {
								var index = parent.layer.getFrameIndex(window.name);
								win.layui.table.reload("LAY-app-role-list");
								formReder();
								parent.layer.close(index);
							});
						} else {
							submit = false;
							layer.msg(result.msg, {
								time: 2000,
								icon: 5
							});
						}
					},
					error: function(jqXHR, textStatus, errorThrown) {
						layer.msg(jqXHR.responseText, {
							time: 2000,
							icon: 5
						});
					}
				});
				submit = true;
			} else {
				layer.msg("正在提交，请稍后！", {
					time: 2000,
					icon: 0
				});
				return false;
			}
		});
	}
	function formReder() {
		form.render();
		// 文本框回车事件
		$(".layui-input").on("keydown", function (event) {
			if (event.keyCode == 13) {
				focusName = event.target.name;
			var submit = $("#LAY-app-rolelist-search");
				submit.click();
				return false;
			}
		});
		if (focusName) {
			$("input[name=" + focusName + "]").focus();
		}
	}
	
	/**
	 * 角色管理JSON对象
	 */
	var Role = {
		
		/**
		 * 操作类型
		 */
		Type: Type,
		
		/**
		 * 初始化
		 */
		init: function(data) {
			if (!data)
				return;
			if (isInit)
				return;
			
			if (data.win) {
				win = data.win;
			}
			
			if (data.type) {
				type = data.type;
				if(data.type=="add") {
					return;
				}
			}
			
			// 加载数据
			loadData(data);
		},

		
		/**
		 * 管理角色
		 */
		manager: function() {
			// 监听搜索
			form.on("submit(LAY-app-rolelist-search)", function(data) {
				var field = data.field;
				table.reload("LAY-app-role-list", {
					where: field
				});
				formReder();
				form.val("layuiadmin-feeding-form", field);
			});
			// 改变窗体大小事件
			$(window).resize(function () {
				table.reload("LAY-app-role-list", {
					height: "full-" + getFullSize()
				});
				formReder();
			});
			
			// 查询过滤字段
			//queryHiddenField();
			
			// 渲染表格
			renderTable();
			// 左侧表头按钮事件监听
			table.on("toolbar(LAY-app-role-list)", function(obj) {
				var type = obj.event;
				active[type] ? active[type].call(this) : "";
			});
			
			// 表格排序
			table.on("sort(LAY-app-role-list)", function(obj) {
				table.reload("LAY-app-role-list", {
					initSort: obj ,
					where: {
						field: obj.field,
						order: obj.type
					}
				});
				formReder();
			});
			
			// 监听操作事件
			table.on("tool(LAY-app-role-list)", function(e) {
				var data = e.data;
				if (e.event == "edit") {
					// 编辑角色
					top.layer.open({
						type: 2,
						title: "编辑角色",
						content: setter.base+"coframe/rights/role/role_update.jsp",
						area: ["450px", "350px"],
						resize: false,
						btn: ["确定", "取消"],
						success: function(layero, index) {
							var contentWindow = layero.find("iframe")[0].contentWindow;
							var role = contentWindow.layui.role;
							if (role) {
								var initData = {
							    	win: window,
							    	type: role.Type.update,
							    	roleId: data.roleId
							    };
								role.init(initData);
							}
						},
						yes: function(index, layero) {
							var submit = layero.find("iframe").contents().find("#layuiadmin-app-form-submit");
							submit.click();
						}
					});
				} else if (e.event == "del") {
					// 删除角色
					layer.confirm("确定删除此角色？", {
						icon: 3, 
						title: "系统提示"
					}, function(index) {
						$.ajax({
							url: deleteUrl+"/"+data.roleId,
							type: "delete",
							cache: false,
							contentType: "text/json",
							success: function(result) {
								if (result.exception) {
		       						layer.alert(result.exception.message, {
										icon: 2,
										title: "系统提示"
									});
								} else if (result.code==0) {
									layer.msg("删除成功", {
										icon: 1,
										time: 2000
									}, function() {
										table.reload("LAY-app-role-list");
										formReder();
									});
								} else {
									layer.msg("删除失败");		
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
			
			// 批量选中	
			$("body").on("click", ".layui-table-body table.layui-table tbody tr td", function() {
				if ($(this).attr("data-field") === "0") return;
				$(this).siblings().eq(0).find("i").click();
			});
		},
		
		/**
		 * 添加角色
		 */
		add: function() {
			onSubmit();
			formReder();
		},
		
		/**
		 * 修改角色
		 */
		update: function() {
			onSubmit();
			formReder();
		}
	};
	
	// 扩展角色管理模块
	exports("role", Role);
});