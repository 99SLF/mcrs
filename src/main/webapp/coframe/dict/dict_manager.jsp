<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%--<%@page import="com.mes.system.utility.StringUtil"%>--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
<title>业务字典配置</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/common/layui/css/layui.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/std/dist/style/admin.css">
</head>
<body>
<div class="layui-fluid">
	<div class="layui-row layui-col-space10">
		<div class="layui-col-md7">
			<div class="layui-card">
  				<div class="layui-card-header" id="header1">业务字典类型</div>
  				<div class="layui-card-body" id="body1">
  					<form id="query_dict_type_form" method="post">
    					<div class="layui-form-item">
							<div class="layui-inline">
								<label class="layui-form-label">类型代码：</label>
								<input id="dictTypeId" name="dictTypeId" autocomplete="off" class="layui-input" style="width:100px;" onenter="onKeyEnter"/>
							</div>
							<div class="layui-inline">
								<label class="layui-form-label">类型名称：</label>
								<input id="dictTypeName" name="dictTypeName" autocomplete="off"  class="layui-input" style="width:100px;" onenter="onKeyEnter"/>
							</div>
							<div class="layui-inline">
								<a class="layui-btn" onclick="tools.searchDictType();" id="searchDictType">
									<i class="layui-icon layui-icon-search"></i>
								</a>
							</div>
						</div>
					</form>
					<div class="layui-toolbar"  id="toolbarDemo1">
   						<button class="layui-btn layuiadmin-btn-list layui-btn-sm" data-type="add"><i class="layui-icon layui-icon-add-circle-fine"></i>添加</button>
				   		<button class="layui-btn layuiadmin-btn-list layui-btn-sm layui-btn-normal" data-type="addcldtype" id="btn_addSubDictType"><i class="layui-icon layui-icon-add-circle-fine"></i>添加子类型</button>
				    	<button class="layui-btn layuiadmin-btn-list layui-btn-sm layui-btn-warm" data-type="update" id="btn_editDictType" ><i class="layui-icon layui-icon-edit"></i>修改</button>
						<button class="layui-btn layuiadmin-btn-list layui-btn-sm layui-btn-danger" data-type="remove" id="btn_removeDictType"><i class="layui-icon layui-icon-delete"></i>删除</button>
						<button class="layui-btn layuiadmin-btn-list layui-btn-sm" data-type="inport">导入</button>
						<button class="layui-btn layuiadmin-btn-list layui-btn-sm" data-type="outport">导出</button>
						<button class="layui-btn layuiadmin-btn-list layui-btn-sm" data-type="refresh"><i class="layui-icon layui-icon-refresh"></i>刷新缓存</button>
					</div>
					<table id="LAY-app-dictType-list" ></table>
  				</div>
			</div>
		</div>
		<div class="layui-col-md5">
			<div class="layui-card">
  				<div class="layui-card-header" id="header2">业务字典项</div>
  				<div class="layui-card-body" id="body2">
  					<table id="LAY-app-dict-list" ></table>
  				</div>
  			</div>
		</div>
	</div>
</div>
<script type="text/html" >
	<div class="layui-btn-container">
		<button class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-circle-fine"></i>添加</button>
		<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="addcldtype" id="btn_addSubDictType"><i class="layui-icon layui-icon-add-circle-fine"></i>添加子类型</button>
		<button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="update" id="btn_editDictType" >修改</button>
		<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delete" id="btn_removeDictType">删除</button>
		<button class="layui-btn layui-btn-sm" lay-event="import">导入</button>
		<button class="layui-btn layui-btn-sm" lay-event="outport">导出</button>
		<button class="layui-btn layui-btn-sm" lay-event="refresh"><i class="layui-icon layui-icon-refresh"></i>刷新缓存</button>
	</div>
</script>
<script type="text/html" id="toolbarDemo2">
	<div class="layui-btn-container">
		<button class="layui-btn layui-btn-sm" lay-event="add_mession"><i class="layui-icon layui-icon-add-circle-fine"></i>添加</button>
		<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="addcldtype_mession" id="btn_addSubDict"><i class="layui-icon layui-icon-add-circle-fine"></i>添加子类型</button>
		<button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="update_mession" id="btn_editDict"><i class="layui-icon layui-icon-edit"></i>修改</button>
		<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delete_mession" id="btn_removeDict"><i class="layui-icon layui-icon-delete"></i>删除</button>
	</div>
</script>
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js"></script>
<script src="<%= request.getContextPath() %>/coframe/dict/js/treeTable.js"></script>
<script type="text/javascript">
	var layer = layui.layer;
	var form = layui.form;
	var $ = layui.jquery;
	var treeTable = layui.treeTable;
	var selectedTermData = {
		length: 0
	};
	var selectedData = {};
	var selected = 0;
	var tbSelected = 0;
	var dictParentId;
	var dictParentName;
	
	function getFullSize() {
		var cardTable = $(".layui-col-md7");
		var header = $("#header1");
		var form = $("#query_dict_type_form");
		var tool = $(".layui-toolbar");
		var fluid = $(".layui-fluid");
		var size = -3;
		size += header.outerHeight(true) + form.outerHeight(true) +  tool.outerHeight(true);
		size += (cardTable.outerHeight(true) - cardTable.height());
		size += (fluid.outerHeight(true) - fluid.height());
		return size;
	}
	$(window).resize(function () {
		treeTable.reload("LAY-app-dictType-list", {
			height: "full-" + getFullSize()
		});
		treeTable.reload("LAY-app-dict-list", {
			height: "full-" + getFullSize2()
		});
	});
		
	//左边树表格
	var dictTb = treeTable.render({
  		elem: "#LAY-app-dictType-list",
		id: "LAY-app-dictType-list-reload",
		url: "mcrs/dict/queryDictType",
		method: "post",
		height: "full-" + getFullSize(),
		parseData: function(res) {
			return {
				code: "0", //解析接口状态
				msg: "", //解析提示文本
				count: res.total, //解析数据长度
				data: res.data //解析数据列表
			};
		}, 
		defaultToolbar: [],
		tree: {
			iconIndex: 1,           // 折叠图标显示在第几列
			isPidData: true,        // 是否是id、pid形式数据
			idName:  "dictTypeId",  // id字段名称
			pidName: "parentId"     // pid字段名称
		},
		cols: [[{ //设置表头。值是一个二维数组。方法渲染方式必填
			type: "radio", 
			fixed: "left"
		}, {
			field: "dictTypeId", 
			title: "类型代码", 
			minWidth: 150
		}, {
			field: "dictTypeName", 
			title: "类型名称", 
			minWidth: 150 //field:设定字段名。字段名的设定非常重要，且是表格数据列的唯一标识;title:设定标题名称
		}]]
	});
	
	//单击行事件
	$("body").on("click", ".ew-tree-table tbody tr td", function() {		
		if ($(this).attr("data-field") === "0") 
			return;
		$(this).siblings().eq(0).find('i').click();
	});
	
	function getFullSize2() {
		var header = $("#header2");
		var tree = $("#LAY-app-dict-list");
		var table = $("#body2");
		var cardTable = $(".layui-col-md5");
		var fluid = $(".layui-fluid");
		var size = 11;
		size += header.outerHeight(true) + tree.outerHeight(true) ;
		size += (cardTable.outerHeight(true) - cardTable.height());
		size += (tree.outerHeight(true) - tree.height());
		size += (fluid.outerHeight(true) - fluid.height());
		size += (table.outerHeight(true) - table.height());
		return size;
	}
	
	//右边表
	var dictTermTb = treeTable.render({
		elem: "#LAY-app-dict-list",
		id: "LAY-app-dict-list-reload",
		url: "com/zimax/components/coframe/dict/DictController/queryDict",
		method: 'post',
		height: "full-" + getFullSize2(),
		parseData: function(res){
			return {
				code: "0", //解析接口状态
				msg: "", //解析提示文本
				count: res.total, //解析数据长度
				data: res.data //解析数据列表
			};
		},
		tree: {
			iconIndex: 1,           // 折叠图标显示在第几列
			isPidData: true,        // 是否是id、pid形式数据
			idName: "dictId",   	// id字段名称
 			pidName: "parentId"     // pid字段名称
   		},
    	where:{
    		dictTypeId: "sadasdasdasd"
    	},
		toolbar: '#toolbarDemo2',
		defaultToolbar: [],
		cols: [[{
			type: "checkbox",
			fixed: "left",
			name: "checkbox2"
		}, {
			field: "dictId",
			title: "字典项代码",
			minWidth: 150
		}, {
			field: "dictName",
			title: "字典项名称",
			minWidth: 150
		}, {
			field: "sortNo",
			title: "排序",
			width: 70
		}]]
	});
	
	var active = {
		add: function() {
			if (tbSelected == 0) {
				selectedData["length"] = 0;
			}
			if (tbSelected > 1 || tbSelected <= 0) {//判断行单选
				selectedData = {};
				selectedData["action"] = "add";
				window.childData = selectedData;
				addDictType();
			} else {
				selectedData["action"] = "add";
				selectedData[0].parentId = selectedData[0].dictTypeId;
				window.childData = selectedData;
	  			addDictType();
  			}
		},
		addcldtype: function() {
			selectedData["action"] = "add";
			if (tbSelected > 1 || tbSelected <= 0) {//判断行单选
				layer.msg("此功能只有在复选框单选时才能使用");
			} else {
				selectedData[0].parentId = selectedData[0].dictTypeId;
				window.childData = selectedData;
	  			addSubDictType();
  			}
		},
		update: function(){
			selectedData["action"] = "edit";
		  	if (tbSelected > 1 || tbSelected <= 0) {//判断行单选
				layer.msg("该功能只有在复选框单选时才能使用");
			} else {
				window.childData = selectedData;
				editDictType(window.childData);
			}
		},
		remove: function(){
			if (selectedData.length <= 0) {
				layer.msg("请选择一条业务字典类型");
    		} else {
    			removeDictType();
			}
		},
		inport: function(){
			importDict();
		},
		outport: function(){
			exportDict();
		},
		refresh:function(){
			refreshDictCache();
		}
	};
	
	//树表格工具栏
	$(".layui-btn.layuiadmin-btn-list").on('click', function(){
		var event = $(this).data("type");
	 	active[event] ? active[event].call(this) : "";
	});
	
	//添加字典类型
	function addDictType() {
		var url = "<%= request.getContextPath() %>/coframe/dict/edit_dict_type.jsp";
		window.cldFlag = false;
		top.layer.open({
			type: 2,
			title: '添加字典类型',
			content: url,
			area: ["370px", "300px"],
			resize: false,
			btn: ["确定", "取消"],
			success: function(layero, index) {
				var dataJson = {
					win: window
				};
				layero.find("iframe")[0].contentWindow.SetData(dataJson);
			},
			yes: function(index, layero) {
				var submit = layero.find("iframe").contents().find("#layuiadmin-dicttype-form-submit");
				submit.click();
			},
			end: function () {
				if (cldFlag) {
					dictTb.reload();
				}
				window.cldFlag = false;
			}
		});
	}
	
	//添加子类型
	function addSubDictType() {
		window.cldFlag = false;
		top.layer.open({
			content: "<%= request.getContextPath() %>/coframe/dict/edit_dict_type.jsp",
			type:2,
			title: "添加子类型",
			area:["370px","300px"],
			resize: false,
			btn: ["确定", "取消"],
			success: function(layero, index) {
				var dataJson = {
					win: window
				};
				layero.find("iframe")[0].contentWindow.SetData(dataJson);
			},
			yes: function(index, layero) {
				var submit = layero.find('iframe').contents().find("#layuiadmin-dicttype-form-submit");
				submit.click();
			},
			end: function () {
				if (window,cldFlag) {
					dictTb.reload();
					tbSelected = 0;
  					selectedData = {};
				}
				window.cldFlag=false;
			}
		});
	}
    
    //修改字典类型
	function editDictType(e) {
		var data = e.data;
		top.layer.open({
			content: "<%= request.getContextPath() %>/coframe/dict/edit_dict_type.jsp",
			type:2,
			title: "修改字典类型",
			area: ['370px','300px'],
			resize: false,
			btn: ["确定", "取消"],
			yes: function(index, layero) {
				var submit = layero.find('iframe').contents().find("#layuiadmin-dicttype-form-submit");
				submit.click();
			},
			success: function(layero, index) {
				var dataJson = {
		    	dictType: data,
		    	win: window
		    };
				layero.find("iframe")[0].contentWindow.SetData(dataJson);
			},
			end: function () {
				if (window.cldFlag) {
					dictTb.reload();//重载表格 改为layui模式
					tbSelected = 0;
					selectedData = {};
				}
				window.cldFlag = false;
			}
		});
	}
	
	function importDict() {
		var url = "<%= request.getContextPath() %>/coframe/dict/dict_import.jsp";
		window.retCode = 0;
		top.layer.open({
			title: '业务字典导入',
			content: url,
			type: 2,
			area: ['530px','220px'],
			end: function () {
				if (retCode == 1) {
					dictTb.reload();
					layer.msg("导入成功");
				} else if (retCode == -1)
					layer.msg("导入失败");
				window.retCode = 0;
			}
		});
	}
    
	function exportDict() {
		layer.msg("导出");
		var form = document.getElementById("query_dict_type_form");
		form.action = "com.zimax.components.coframe.dict.impl.exportDict.flow";
    	form.submit();
	}
    
	function resetQuery() {
		var form = new layui.form("query_dict_type_form");
		form.reset();
	}
    
	function refreshDictCache(){
		$.ajax({
			url: "com/zimax/components/coframe/dict/DictController/refreshDictCache",
			type: "post",
			cache: false,
			contentType: 'text/json',
			success: function (json) {
				if(json.status == 'success'){
				layer.msg("刷新缓存成功！",{
					icon: 1,
					time: 2000
				});
			}
			else layer.msg("刷新缓存失败！");
			},
			error: function () {
				layer.msg("刷新缓存失败！");
			}
		});
	}
	
	function removeDictType() {
		var jsonData = JSON.stringify({data:selectedData});
		layer.confirm("所有关联的业务字典类型和业务字典项都将被删除，确认删除业务字典类型？",{
			btn:['确定','取消'],btn1:function(index){
			$.ajax({
				url: "com/zimax/components/coframe/dict/DictController/removeDictType",
				type: "post",
				data: jsonData,
				cache: false,
				contentType: 'text/json',
				success: function (json) {
					if (json.status == 'success'){
						layer.msg("删除成功", {
								icon: 1,
								time: 2000
							}, function() {
								dictTb.reload();
								dictTermTb.reload();
								layer.close(index);
								tbSelected = 0;
								selectedData = {};
							});
					} else 
						layer.msg("删除失败！");
					},
					error: function () {
						layer.msg("删除失败！");
					}
				});
			},
			btn2: function(index){
				layer.close(index);
			}
		});  
	}
	
	//右边工具栏
	treeTable.on('toolbar(LAY-app-dict-list)', function(obj) {
		switch (obj.event) {
		case 'add_mession':
			if (selectedTermData == null){
				selectedTermData["length"] = 0;
			}
			if (selectedData.length != 1){
				layer.msg("请选择一项业务字典类型");
			} else {
				selectedTermData["action"] = "add";
				selectedTermData["dictParentId"] = dictParentId;
				selectedTermData["dictParentName"] = dictParentName;
				selectedTermData["type"] = "add";
				window.dictChildData = selectedTermData;
  				addDict();
			}
			selectedTermData = {};
			break;
		case 'addcldtype_mession':
			if (selectedData.length != 1) {
				layer.msg("请选择一项业务字典类型");
			} else if(selected <= 0) {
				layer.msg("请选择一项业务字典项");
  			} else {
  				selectedTermData["action"] = "add";
				selectedTermData["dictParentId"] = dictParentId;
				selectedTermData["dictParentName"] = dictParentName;
				selectedTermData["type"] = "adddict";
				window.dictChildData=selectedTermData;
  				addSubDict();
  			}
			break;
		case 'update_mession':
			if (selected <= 0) {
				layer.msg("请选择一项业务字典项");
  			} else {
  				selectedTermData["action"] = "edit";
  				selectedTermData["dictParentId"] = dictParentId;
    			selectedTermData["dictParentName"] = dictParentName;
    			window.dictChildData = selectedTermData;
    			editDict(window.dictChildData);
  			}
			break;
		case 'delete_mession':
			if (selected <= 0) {
				layer.msg("请选择一项业务字典项");
			} else {
    			layer.msg('删除');
  				removeDict();
			}
			break;
		};
	});
	
	function addDict() {
		window.cldFlag = false;
		top.layer.open({
			content: "<%= request.getContextPath() %>/coframe/dict/edit_dict.jsp",
			title: "添加字典项",
			type: 2,
			area: ['370px','400px'],
			resize: false,
			btn: ["确定", "取消"],
			yes: function(index, layero) {
				var submit = layero.find('iframe').contents().find("#layuiadmin-dict-form-submit");
				submit.click();
			},
			success: function(layero, index) {
				var dataJson = {
					win: window
				};
				layero.find("iframe")[0].contentWindow.SetData(dataJson);
			},
			end:function(){
				if (window.cldFlag) {
					dictTermTb.reload();
				}
				window.cldFlag = false;
			}
		});
	}
	
	function addSubDict() {
		window.cldFlag = false;
		top.layer.open({
			content: "<%= request.getContextPath() %>/coframe/dict/edit_dict.jsp",
			title: "添加子项",
			area: ['370px','400px'],
			resize: false,
			type: 2,
			btn: ["确定", "取消"],
			success: function(layero, index) {
				var dataJson = {
					win: window
				};
				layero.find("iframe")[0].contentWindow.SetData(dataJson);
			},
			yes: function(index, layero) {
				var submit = layero.find('iframe').contents().find("#layuiadmin-dict-form-submit");
				submit.click();
			},
			end: function (action) {
				if (window.cldFlag) {
					dictTermTb.reload();
					selected = 0;
				}
				window.cldFlag = false;
			}
		});
	}
    
	function editDict(e) {
		window.cldFlag = false;
		top.layer.open({
			content: "<%=request.getContextPath()%>/coframe/dict/edit_dict.jsp",
			title: "修改字典项",
			area: ['370px','400px'],
			resize: false,
			type: 2,
			btn: ["确定", "取消"],
			yes: function(index, layero) {
				var submit = layero.find('iframe').contents().find("#layuiadmin-dict-form-submit");
				submit.click();
			},
			success: function(layero, index) {
				 var dataJson = {
			    	dictType : e.data,
			    	win: window
			    };
				layero.find("iframe")[0].contentWindow.SetData(dataJson);
			},
			end: function () {
				if (window.cldFlag) {
					dictTermTb.reload();
					selected = 0;
				}
				window.cldFlag = false;
			}
		});
	}
	
	function removeDict() {
		var jsonData = JSON.stringify({data:selectedTermData});
		layer.confirm("所有关联的业务字典项都将被删除，确认删除业务字典项？", {
    		btn: ['确定', '取消'],
    		btn1: function(index) {
				$.ajax({
					url: "com/zimax/components/coframe/dict/DictController/removeDictF",
					type: "post",
					data: jsonData,
					cache: false,
					contentType: "text/json",
					success: function (json) {
						if (json.status == "success") {
							layer.msg("删除成功", {
								icon: 1,
								time: 2000
							}, function() {
								dictTermTb.reload();
								selected = 0;
								layer.close(index);	
							});
						} else{ 
							layer.msg("删除失败！");
						}
					},
					error: function () {
						layer.msg("删除失败！");
					}
				});
			},
			btn2: function(index){
				layer.close(index);
			}
		});
	}
	
	treeTable.on("checkbox(LAY-app-dictType-list)", function(obj) {//demo表格复选框监听
		var checkStatus = dictTb.checkStatus("#LAY-app-dictType-list");
		selectedData = checkStatus;
		selected = 0;
	 	tbSelected = 1;
    	if (checkStatus.length == 1) {
  			var dataJson = {
  				dictTypeId: checkStatus[0].dictTypeId
  			};
  			dictParentId = checkStatus[0].dictTypeId;
  			dictParentName = checkStatus[0].dictTypeName;
  			dictTermTb.reload( {//依照参数重载表格
  				where: dataJson//where 	接口的其它参数。如：where: {token: 'sasasas', id: 123}
	  		});
  		} else {
  			dictTermTb.reload({//依照参数重载表格
  				where: {
  					dictTypeId: "sadasdasdasd"
  				}
  			});
  		}
	});
	
	treeTable.on('checkbox(LAY-app-dict-list)', function(obj){//demo2表格复选框监听
		if (obj.checked) {
			selected++;
		} else {
			selected--;
		}
  		var checkStatus = dictTermTb.checkStatus('#LAY-app-dict-list');
  		selectedTermData = checkStatus;
	});
	
	var _tools = {
		searchDictType: function(){
 			var dictTypeId = $("#dictTypeId").val();
    		var dictTypeName = $("#dictTypeName").val();
    		var dataJson={
    			id: dictTypeId,
    			name: dictTypeName
    		};
    		dictTb.reload({//依照参数重载表格
  				where:dataJson//where 	接口的其它参数。如：where: {token: 'sasasas', id: 123}
    		});
 		}
	};
	
	window.tools = _tools;
 	
 	function onKeyEnter(e) {	
		searchDictType();
	}
	
	//文本框回车事件
	$(".layui-input").on("keydown", function(event) {
		if (event.keyCode == 13) {
			var submit = $("#searchDictType");
			submit.click();
			return false;
		}
	});
</script>
</body>
</html>