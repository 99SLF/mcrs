<%@page pageEncoding="UTF-8"%>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=equipment-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<title>修改菜单</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.0">
<style>
	.layui-form-label{
		width: 120px;
	}
	.layui-input-block {
		margin-left: 130px;
		min-height: 36px
	}
</style>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list" style="padding: 20px 30px 0 0;">
	<input id="parentMenuId" name="parentMenuId" type="hidden"/>
	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label" ><span style="color:red">*</span>菜单名称：</label>
			<div class="layui-input-block">
				<input id="menuId" name="menuId" type="hidden"/>
                <input id="menuAction" name="menuAction" type="hidden"/>
                <input id="menuLevel" name="menuLevel" type="hidden"/>
                <input id="menuSeq" name="menuSeq" type="hidden"/>
                <input id="subCount" name="subCount" type="hidden"/>
                <input id="type" name="type" type="hidden" />
				<input type="text" class="layui-input" name="menuName" id="menuName"  lay-verify="required" autocomplete="off" placeholder="">
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label" ><span style="color:red">*</span>菜单代码：</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="menuCode" id="menuCode" lay-verify="required" autocomplete="off" placeholder="">
			</div>
		</div>
	</div>
	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label" ><span style="color:red">*</span>菜单显示名称：</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="menuLabel" id="menuLabel"  lay-verify="required" autocomplete="off" placeholder="">
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label" ><span style="color:red">*</span>菜单显示顺序：</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="displayOrder" id="displayOrder"  lay-verify="number" autocomplete="off" placeholder="">
			</div>
		</div>
	</div>
	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label">是否为叶子菜单：</label>
			<div class="layui-input-block">
				<select name="isLeaf" id="islLeaf" lay-filter="isLeaf" type="select">
					<option value="1">是</option>
					<option value="0">否</option>
				</select>
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label">功能资源：</label>
			<div class="layui-input-block">
				<input id="funcCode" name="funcCode" type="hidden"/>
				<input type="text" class="layui-input" style="width:85%" name="funcName" id="funcName" lay-verify="" autocomplete="off" placeholder="" readonly>
				<button type="button" class="layui-btn layui-btn-sm layui-btn-primary" id="onButtonEdit" style="position:absolute;top:0px;right:0px;height:37px"><i class="layui-icon layui-icon-more"></i></button>
			</div>
		</div>
	</div>
	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label">打开方式：</label>
			<div class="layui-input-block">
				<select name="openMode" id="openMode" lay-filter="openMode" type="select">
					<option value="1">区域中</option>
					<option value="0">新窗口</option>
				</select>
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label">菜单图片路径：</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="imagePath" id="imagePath" autocomplete="off" placeholder="">
			</div>
		</div>
	</div>
	<div class="layui-form-item layui-hide">
		<input type="button" lay-submit lay-filter="layuiadmin-app-form-edit" id="layuiadmin-app-form-edit" value="确认编辑">
	</div>
</div>
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
<script>
	layui.config({
		base: "<%=request.getContextPath()%>/"
	});
</script>
<script type="text/javascript">
	var layer = layui.layer;
	var form = layui.form;
	var $ = layui.jquery;
	var isExist = false;
	var funcName1;
	var submit = false;
	var win = null;
	function SetData(data) {
		win = data.win ? data.win : window;
		var  parentMenuId=data.parentMenuId
	    var data = data.data;
		if(data.funcCode!=null&&data.funcCode!=""){
			FindFuncName(data.funcCode);
		}
		form.val('layuiadmin-app-form-list', {
			"menuId": data.menuId,
	  		"menuAction": data.menuAction,
	  		"menuLevel": data.menuLevel,
			"parentMenuId": parentMenuId,
	  		"menuSeq": data.menuSeq,
	  		"subCount": data.subCount,
		 	"menuName": data.menuName,
			"menuCode": data.menuCode,
			"menuLabel": data.menuLabel,
			"displayOrder": data.displayOrder,
			"isLeaf": data.isLeaf,
			"funcName": funcName1,
	 		"funcCode": data.funcCode,
			"openMode": data.openMode,
			"imagePath": data.imagePath
		});
	}

	//判断菜单代码是否已存在
	$("#menuCode").blur(function() {
		var menuCode = $("#menuCode").val();
		if (menuCode != null && menuCode != "") {
			$.ajax({
				url: "<%= request.getContextPath() %>/framework/menu/find?menuCode="+menuCode,
				type: "GET",
				cache: false,
				contentType: "text/json",
				cache: false,
				success: function (text) {
					if (text.code == "1") {
						isExist = true;
					} else {
						isExist = false;
					}
				}
			});
		} else {
			return;
		}
	});
	
	//监听提交
	form.on("submit(layuiadmin-app-form-edit)", function(data) {
		if (submit ==false) {
			submit = true;
			debugger;
			var submitData = JSON.stringify(data.field);
			if (isExist == false) {
				$.ajax({
					url: "<%= request.getContextPath() %>/framework/menu/update",
					type: "POST",
					data: submitData,
					cache: false,
					contentType: "text/json",
					success: function(result) {
						layer.msg("修改成功", {icon: 1,time: 2000}, function() {
							var index = parent.layer.getFrameIndex(window.name);
							win.layui.table.reload("LAY-app-menu-list");
							top.layer.close(index); 
							win.window.updata_select();
						});
					}
				});	
			} else if (isExist == true) {
				layer.msg("角色已存在，请重新输入", {
					icon: 2,
					time: 2000
				});
				submit = false;
			}
		} else {
			layer.msg("正在修改...请稍等！");
		}
		return false;                
	});
	
	function FindFuncName(data){
		$.ajax({
			url: "<%= request.getContextPath() %>/framework/function/getFunction?funcCode="+data,
			type: "GET",
	    	async: false,
			contentType: "text/json",
			cache: false,
			success: function (text) {
				debugger;
				if (text) {
					funcName1 = text.data.funcName;
				}	
			}
		});
	}
	
	//调用功能选择入口
	$("#onButtonEdit").click(function(){
		top.layer.open({
			type:2,
		    title: "选择功能调用入口",
		    area: ['850px', '470px'],
		    btn: ["确定", "取消"],
	  	  	content: "<%= request.getContextPath() %>/coframe/framework/menu/menu_function_select.jsp", 
	  	  	yes: function(index, layero) {
				var data = layero.find('iframe')[0].contentWindow.getData();
				$("#funcCode").val(data.funcCode);
				$("#funcName").val(data.funcName);
				top.layer.close(index);
			}
    	});
	});
</script>
</body>
</html>