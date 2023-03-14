<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>编码规则维护列表</title>
<!-- 
  - Author(s): shilinfeng
  - Date: 2022-12-15 16:42:57
  - Description:
-->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/custom.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/layout.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/iconfont/iconfont.css">
<style type="text/css">
.layui-select-title{
	width:182px; !important;
}
</style>
</head>
<body>
<div class="layui-fluid">
	<div class="layui-card">
		<div class="layui-form layui-card-header layuiadmin-card-header-auto">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">规则名称：</label>
					<div class="layui-input-block">
						<input type="text" name="functionName" id="functionName" placeholder="请输入规则名称" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline layui-search" style="float:right">
					<button class="layui-btn layui-btn-primary layui-btn-xs layuiadmin-btn-list" lay-submit lay-filter="searchSubmit" id="search" title="查询">				
						<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
					</button>			
					<button class="layui-btn layui-btn-primary layui-btn-xs layuiadmin-btn-list" lay-submit lay-filter="addCoding" lay-event="addCoding" title="新增"><span class="icon iconfont icon-xinzeng"></span></button>
<!-- 					<button class="layui-btn layui-btn-primary layui-btn-xs" lay-submit lay-filter="deleteCoding" lay-event="deleteCoding" title="批量删除"><span class="icon iconfont icon-icon"></span></button>
 -->				</div>
			</div>	
		</div>
		<div class="layui-card-body">
			<table id="coding-list" lay-filter="coding-list"></table>
			<script type="text/html" id="table-coding-list">
					<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i></a>
					<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="view" title="查看"><span class="icon iconfont icon-yulan"></span></a>			
			</script>	
		</div>	
	</div>
</div>

<script src="<%=request.getContextPath()%>/common/layui/layui.all.js"></script>
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
	var funName = "serial_list"; 
	
	layui.admin.renderDictSelect({    	//功能id
		elem: "#functionName",
	  	dictTypeId: "FUNCTION_ID"
	});
	
	layui.admin.renderDictSelect({    	//编码后缀
		 elem: "#codeSuffix",
	  	 dictTypeId: "CODE_SUFFIX"
	});
			
	form.render();
	//新增
	form.on("submit(addCoding)", function(rel) {
		var url = '<%=request.getContextPath() %>/basic/serialnumber/coding_add.jsp';
		top.layer.open({
			type: 2,
			title: "新增编码规则",				
			content: [url, 'yes'],
			area: ['800px', '520px'],
			resize: false,
			maxmin: true,
			btn: ["确定", "取消"],
			success: function(layero, index) {
			    var dataJson = {
			    	win: window
			    };
				layero.find("iframe")[0].contentWindow.SetData(dataJson);
			},
			yes: function(index, layero) {
				var submit = layero.find('iframe').contents().find("#save_data");
				submit.click();
			}
		}); 
	});
		
	//监听普通搜索按钮点击事件
	form.on('submit(searchSubmit)', function(rel) { 
		var rels=rel.field;		
     	var dataJson = {
     		"functionName":rels.functionName,		
     	};
 		table.reload('tableReload',{	
 			url: "<%=request.getContextPath() %>/serialnumber/query",
			where: dataJson,
			method:"GET",
			page: {
				curr: 1
			}
		});			
	});
	
	//文本框回车事件
	$(".layui-input").on("keydown", function(event) {	
		if (event.keyCode == 13) {
			var submit = $("#search");
			submit.click();
			return false;
		}
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
	
	//表格排序
	table.on('sort(coding-list)', function(obj){ 
  		table.reload('tableReload', {
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
		
	//单号规则维护表格渲染
	table.render({
		elem:'#coding-list',
		id:'tableReload',
		url:"",
		data: [],
		method:"post",
		title: '编码规则维护列表',
		page: true, 
		height: "full-" + getFullSize(),
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
		defaultToolbar: [""],
		parseData: function(res) {
			return {
				code: res.code,
				msg: res.msg,
				count: res.total,
				data: res.data
			};
		},
		cols:[[{
			title:'序号',
			type:'numbers',
			hide:false
		}, {
			field:'functionNum',
			title:'规则编码',
			align:'center',
			minWidth: 220,
			hide: isHidden("functionNum"),
			sort: true		
		}, {
			field:'functionName',
			title:'规则名称',
			align:'center',
			minWidth: 220,
			hide: isHidden("functionName"),
			sort: true		
		}, {
			field:'titleRule',
			title:'生成规则',
			align:'center',
			hide: isHidden("titleRule"),
			minWidth: 200,
			sort: true
		}, {
			field:'numberRule',
			title:'流水号规则',
			align:'center',
			hide: isHidden("numberRule"),
			minWidth: 160,
			sort: true
		},  {
			field:'digit',
			title:'流水位数',
			align:'center',
			hide: isHidden("digit"),
			minWidth: 160,
			sort: true
		}, {
			field:'startvalue',
			title:'初始值',
			align:'center',
			hide: isHidden("startvalue"),
			minWidth: 160,
			sort: true
		}, {
			field:'numBasis',
			title:'计数方式',
			align:'center',
			hide: isHidden("numBasis"),
			minWidth: 160,
			sort: true,
			templet:function(data){
				return layui.admin.getDictText("numbasis" , data.numBasis);
			}
		}, {
			field:'note',
			title:'说明',
			align:'note',
			hide: isHidden("note"),
			minWidth: 160,
			sort: true,
			templet: function(data) {
				data.note = data.note == null ? "" : data.note;
				 var html = '<div><a rel="nofollow" href="javascript:void(0);" style="color:#1E9FFF" lay-event="showRemark">' + data.note+ '</a></div>';
				return html;
			}
		},  {
			title: "操作",
			align: "center",
			fixed: "right",
			minWidth: 150,
			toolbar: "#table-coding-list"
		}]]
	});
	
	$(window).resize(function () {
		table.reload("tableReload", {
			height: "full-" + getFullSize()
		});
	});
       
	table.on('toolbar(coding-list)', function(obj){
		var type = obj.event;
		active[type] ? active[type].call(this) : "";
	});

	//监听工具栏按钮事件
    table.on('tool(coding-list)', function(obj) {
		var data = obj.data;
		if (obj.event == "edit") {
			var url = '<%=request.getContextPath() %>/basic/serialnumber/coding_edit.jsp';
			top.layer.open({
				type: 2,
				title: "编辑编码规则",
				content: [url, 'yes'],
				area: ['800px', '520px'],
				resize: false,
				maxmin: true,
				btn: ["确定", "取消"],
				success: function(layero, index) {
				    var dataJson = {
				    	data : data,
				    	win: window
				    };
					layero.find("iframe")[0].contentWindow.SetData(dataJson);
				},
				yes: function(index, layero) {
					var submit = layero.find('iframe').contents().find("#save_data");
					submit.click();
				}
			});
		}else if (obj.event == "showRemark") {
			var data;
			var title;
			if (obj.event == "showRemark") {
				title	 = "备注";
				data = obj.data.note;
			}
			top.layer.open({
				type: 2,
				title: title,
				content: "<%= request.getContextPath() %>/basic/textWindows/textWindows.jsp",
				area: ["800px", "560px"],
				resize: false,
				maxmin: true,
				btn: ["关闭"],
				success: function(layero, index) {
					var dataJson = {
				    	data: data,
				    	win: window
				    };
					layero.find("iframe")[0].contentWindow.SetData(dataJson);
				},
			});
		}else if (obj.event == "view") {
			var url = '<%=request.getContextPath() %>/basic/serialnumber/coding_view.jsp';
			top.layer.open({
				type: 2,
				title: "查看编码规则",
				content: [url, 'yes'],
				maxmin: true,
				area: ['800px', '520px'],
				btn: ["确定", "取消"],
				success: function(layero, index) {
				    var dataJson = {
				    	data : data,
				    	win: window
				    };
					layero.find("iframe")[0].contentWindow.SetData(dataJson);
				},
				yes: function(index, layero) {
					var submit = layero.find('iframe').contents().find("#confirm");
					submit.click();
				}
			});
		}
	});
	
	/* //删除部件
	form.on("submit(deleteCoding)", function(rel) {
		var checkStatus = table.checkStatus('tableReload');
		var data = checkStatus.data;
		if(data.length == 0) {
			top.layer.alert('请至少选中一条记录！',{icon: 2, title:'系统提示'});
		}else {
			top.layer.confirm('确定删除？', {icon: 3, title:'系统提示'}, function(index) {
				$.ajax({
					url: "com.zimax.mes.basic.SerialNumber.deleteSerial.biz.ext",
					type: 'POST',
					data: JSON.stringify({serials : data}),
					cache: false,
					contentType: 'text/json',
					success: function(result) {
						if(result.code == 0){
							top.layer.close(index);
							layer.msg(result.msg,{icon:1,time:2000},function() {
								table.reload('tableReload', {
									page: {
							        	curr: 1 
							        }
								});
							});
						} else {
							top.layer.close(index);
							layer.msg(result.msg,{icon:2,time:2000},function() {
								table.reload('tableReload', {
									page: {
							        	curr: 1 
							        }
								});
							});
						}
					},
					error: function (result) { 
						top.layer.alert("未找到数据", {icon: 2, title:'系统提示'});
					}
				});
			});
		}
	}); */
	
	//表格复选框选中事件
	table.on('checkbox(coding-list)', function(obj){
		if(obj.type === "one"){
			if(obj.checked){
				obj.tr.addClass('layui-bg-blue');
			} else {
				obj.tr.removeClass('layui-bg-blue');
			}
		} else if(obj.type === "all"){
			$(".layui-table-body table.layui-table tbody tr").each(function(i){
				if(obj.checked){
					$(this).addClass('layui-bg-blue');
				} else {
					$(this).removeClass('layui-bg-blue');
				}
			});
		}
		
	});
	
	//单击行事件	
	$('body').on("click", ".layui-table-body table.layui-table tbody tr td", function () {		
		if ($(this).attr("data-field") === "0") 
			return;
		$(this).siblings().eq(0).find('i').click();
	});
	
</script>
</body>
</html>