<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>工厂产线</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/custom.css?v1">
<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/layout.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/iconfont/iconfont.css">
<style type="text/css">
.layui-card {
	margin-bottom: 0px;
}
</style>
</head>
<body>
<div class="layui-card">
	<div class="layui-form layui-card-header layuiadmin-card-header-auto">
		<div class="layui-form-item">
			<div class="layui-inline">
					<label class="layui-form-label">所属车间：</label>
					<div class="layui-input-block">
						<input type="text" name="production" id="production"  autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">产线编号：</label>
					<div class="layui-input-block">
						<input type="text" name="lineCode" id="lineCode" placeholder="请输入产线编号" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline layui-search" style="float:right">
					<button class="layui-btn layui-btn-primary layui-btn-xs" lay-submit lay-filter="searchSubmit" id="searchSubmit" title="搜索">
						<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
					</button>
					<button class="layui-btn layui-btn-primary layui-btn-xs" data-type="save" title="保存"><span class="icon iconfont icon-baocun"></span></button>		    		    
		    		<button class="layui-btn layui-btn-primary layui-btn-sm" data-type="cancel" title="取消"><span class="icon iconfont icon-quxiao"></span></button>
				</div>		
			</div>
	</div>
	<div class="layui-card-body">
		<table id="LAY-demo-list" lay-filter="LAY-demo-list">
		</table>
		<script type="text/html" id="table-user-list">
				<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="add" title="新增"><i class="layui-icon layui-icon-add-circle-fine layuiadmin-button-btn"></i></a>
				<a lay-event="del" class="layui-btn layui-btn-primary layui-btn-xs" title="删除"><i class="layui-icon layui-icon-delete"></i></a>
		</script>
	</div>
</div>
<script type="text/html" id="article-toolbar">
	<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="add" title="新增"><i class="layui-icon layui-icon-add-circle-fine layuiadmin-button-btn"></i></a>
	<a lay-event="del" class="layui-btn layui-btn-primary layui-btn-xs" title="删除"><i class="layui-icon layui-icon-delete"></i></a>
</script>	
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
	var funName = "LAY-demo-list";
	
	function getFullSize() {
		var header = $(".layui-card-header");
		var toolbar = $(".layui-toolbar");
		var cardbody = $(".layui-card-body");
		return header.outerHeight(true) + toolbar.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height()) + 2;
	}
	
	//获取分类树页面传参
	var parentCategoryId =decodeURIComponent("<%= request.getParameter("nodeId")%>");
	var parentCategoryName =decodeURIComponent("<%= request.getParameter("context")%>");
	var parentId =decodeURIComponent("<%= request.getParameter("parentId")%>");
	if ("root" == parentCategoryId || "null" == parentCategoryId) {
		parentCategoryId = null;
	}
	if ("null" != parentCategoryName && "基础数据" != parentCategoryName ) {
		$("#production").val("<%= request.getParameter("context")%>");
	}
	
	//查询过滤字段
	$.ajax({
		url: "com.zimax.components.coframe.tools.ColsFilter.queryHiddenField.biz.ext",
		type: "POST",
		async: false,
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
			if (hiddenFields[i].field == field) {
				return true;
			}
		}
		return false;
	}
	
	//产线数据表格赋值
	var tables = table.render({
		elem: "#LAY-demo-list",
		id: "tableReload",
		method: "post",
		where: {
			categoryId: parentCategoryId
		},
		url: "",
		data:[],
		title: "产线",
		height: "full-" + getFullSize(),
		page: false,
		limit: 9999,
		defaultToolbar: [""],
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
					} else {
						layer.msg("列筛选失败");
					}
				}
			});
		},
		parseData: function(res){
			if(res.exception){
				if(res.exception.code = "12101001"){
					location.reload();
					return;
				}
			};
			if (res.line.length == 0) {
				if($("#lineCode").val() == ""){
					var data = {
						lineCode: "",
						lineName: "",
						remarks: ""
					};
					res.line.push(data);
				}
			} 
			return {
				code: res.code, //解析接口状态
				msg: res.msg, //解析提示文本
		    	data: res.line //解析数据列表
			};
		},
		cols:[[{
			type: "checkbox"
		}, {
			title:'序号',
			type:'numbers',
			hide:false
		}, {
			field: "lineCode",
			title: "<span style='color:red'>*</span>产线编号",
			align: "center",
			sort: true,
			hide: isHidden("lineCode"),
			width: 200
		}, {
			field: "lineName",
			title: "<span style='color:red'>*</span>产线名称",
			edit : 'text',
			align: "center",
			sort: true,
			hide: isHidden("lineName"),
			minWidth: 120
		}, {
			field: "remarks",
			title: "备注",
			edit : 'text',
			align: "center",
			sort: true,
			hide: isHidden("remarks"),
			minWidth: 120,
			templet: function(data) {
				data.remarks = data.remarks == null ? "" : data.remarks;
				 var html = '<div><a rel="nofollow" href="javascript:void(0);" style="color:#1E9FFF" lay-event="showRemark">' + data.remarks+ '</a></div>';
				return html;
			}
		}, {
			field: "createrName",
			title: "制单人",
			align: "left",
			minWidth: 150,
			sort: true,
			templet: function(data) {
				return data.creater == null ? "" : data.creater.createrName;
			}
		}, {
			field: "createTime",
			title: "制单时间",
			align: "center",
			sort:true,
			width: 150,
			templet:function(data){
				return data.createTime != null ? layui.util.toDateString(data.createTime,"yyyy-MM-dd HH:mm:ss") : "";
			}
		}, {
			title: "操作",
			align: "center",
			fixed: "right",
			width: 200,
			toolbar: "#table-user-list"
		}]]
	});
	
	$(window).resize(function () {
		table.reload("tableReload", {
			height: "full-" + getFullSize()
		});
	});
	
	//方向键的切换
	$(document).on('keydown', '.layui-table-edit', function (e) {
		var td = $(this).parent('td'),
		tr = td.parent('tr'),
		trs = tr.parent().parent().find("tr")
		tr_index = tr.index(),
		td_index = td.index(),
		td_last_index = tr.find('[data-edit="text"]:last').index(),
		td_first_index = tr.find('[data-edit="text"]:first').index();
		switch (e.keyCode) {
			case 13:
			case 39:
			td.nextAll('[data-edit="text"]:first').click();
			if (td_index == td_last_index) {
				tr.next().find('td').eq(td_first_index).click();
				if (tr_index == trs.length - 1) {
					trs.eq(0).find('td').eq(td_first_index).click()
				}
			}
			setTimeout(function () {
				$('.last-table-edit').select()
			}, 0)
			break;
			case 37:
				td.prevAll('[data-edit="text"]:first').click();
				setTimeout(function () {
					$('.last-table-edit').select()
				}, 0)
			break;
			case 38:
				tr.prev().find('td').eq(td_index).click();
				setTimeout(function () {
					$('.last-table-edit').select()
				}, 0)
				break;
			case 40:
				tr.next().find('td').eq(td_index).click();
				setTimeout(function () {
					$('.last-table-edit').select()
				}, 0)
				break;
		}
	});
	
	//监听搜索按钮事件
	form.on("submit(searchSubmit)",function(rel) {  
		var rels = rel.field;
		var dataJson = {
			lineCode: rels.lineCode
		};
		table.reload("tableReload", {
			where: dataJson,
			url: "com.zimax.mes.basic.LineManager.queryLine.biz.ext",
			method:"post"
    	});
	});
	
	//文本框回车事件
	$(".layui-input").on("keydown", function(event) {
		if (event.keyCode == 13) {
			var submit = $("#searchSubmit");
			submit.click();
			return false;
		}
	});
	
	//以数组值为键，持续向一个对象里面加值，
	//如果在加值之前就发现这个属性在对象中已经存在，那么他就是重复的
	function isRepeat(arr){
	   var hash = {};
	   for (var i in arr) {
	      if (hash[arr[i]])
	      	return true;
	      hash[arr[i]] = true;
	  }
	  return false;
	}
	
	
	//监听按钮点击事件
	var active = {
		save: function() {
			var lineData = table.cache["tableReload"];
			var lineCodes = [];
			//判断产线编号是否重复
			for (var i in lineData) {
				lineCodes.push(lineData[i].lineCode);
				if (lineData[i].lineName == ""  || lineData[i].lineName == null) {
					layer.msg("必要数据缺失，请核对后保存",{
						icon: 2,
						time: 2000
					});
					return;
				}
			}
			//true有相同的产线
// 			var rep = isRepeat(lineCodes);
// 			if (rep == true) {
// 				layer.msg("产线编号有重复，请核对后保存",{
// 					icon: 2,
// 					time: 2000
// 				});
// 				return;
// 			}
			
			$.ajax({
				url: "com.zimax.mes.basic.LineManager.saveLine.biz.ext",
				type: "POST",
				async: false ,
				data: JSON.stringify({
					lineData: lineData,
					categoryId: parentCategoryId
				}),
				cache: false,
				contentType: "text/json",
				success: function(result) {
					layer.msg(result.msg, {
						icon: 1,
						time: 2000
					});
					table.reload("tableReload", {
						url: "com.zimax.mes.basic.LineManager.queryLine.biz.ext",
		    		});
				}
			});
			
		},
		cancel: function() {
			layer.confirm("确定取消之前的全部操作？",{
				icon: 3, 
				title: "系统提示"
			}, function(index){
				table.reload("tableReload", {
					url: "com.zimax.mes.basic.LineManager.queryLine.biz.ext",
	    		});
	    		layer.close(layer.index)
			});
		}
	};
	
	$(".layui-btn").on("click", function() {
		var type = $(this).data("type");
		active[type] ? active[type].call(this) : "";
	});
	
	//单击选中
	$('body').on("click", ".layui-table-body table.layui-table tbody tr td", function () {		
		if ($(this).attr("data-field") === "0") 
			return;
		$(this).siblings().eq(0).find('i').click();
	});
	
	
	table.on('row(LAY-demo-list)', function(obj){
	    var data = obj.data;
	    index = data.id;
	    index = index - 1;
	});
	
	
	//表格工具栏事件
		table.on('tool(LAY-demo-list)', function(obj){
			if (obj.event == 'add') {
				var Data = table.cache["tableReload"];
				var datas = {
					"lineCode": "",
					"lineName": "",
					"remarks": ""
				}
				Data.push(datas);
				table.reload("tableReload", {
			        url: '', 
			        data: Data,
			        defaultToolbar: [""],
				});
			}
			if (obj.event == 'del') {
				var Data = table.cache["tableReload"];
				if (obj.tr.data('index') >= -1) {
					Data.splice(obj.tr.data('index'), 1)//根据索引删除当前行
					tables.reload({
					 	url: '', 
						data : Data
					});
				}
			}
			if (obj.event == "showRemark") {
				var data=null;
				var title=null;
				if (obj.event == "showRemark") {
					title	 = "备注";
					data = obj.data.remarks;
				}
				top.layer.open({
					type: 2,
					title: title,
					content: "<%= request.getContextPath() %>/basic/textWindows/textWindows.jsp",
					area: ["800px", "560px"],
					resize: false,
					shade: 0,
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
		}
		});
	
</script>
</body>
</html>