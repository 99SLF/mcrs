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
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list" style="padding: 20px 30px 0 0;">
	<input id="menu/menuId" name="menu/menuId" type="hidden"/>								
	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label" >菜单名称：<span style="color:red">*</span></label>
			<div class="layui-input-block">
				<input id="menuId" name="menu/menuId" type="hidden"/>
                <input id="menuAction" name="menu/menuAction" type="hidden"/>
                <input id="menuLevel" name="menu/menuLevel" type="hidden"/>
                <input id="menuSeq" name="menu/menuSeq" type="hidden"/>
                <input id="subCount" name="menu/subCount" type="hidden"/>  
                <input id="type" name="type" type="hidden" />
				<input type="text" class="layui-input" name="menu/menuName" id="menuName"  lay-verify="required" autocomplete="off" placeholder="">
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label" >菜单代码：<span style="color:red">*</span></label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="menu/menuCode" id="menuCode" lay-verify="required" autocomplete="off" placeholder="">
			</div>
		</div>
	</div>
	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label" >菜单显示名称：<span style="color:red">*</span></label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="menu/menuLabel" id="menuLabel"  lay-verify="required" autocomplete="off" placeholder="">
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label" >菜单显示顺序：<span style="color:red">*</span></label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="menu/displayOrder" id="displayOrder"  lay-verify="required" autocomplete="off" placeholder="">
			</div>
		</div>
	</div>
	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label">是否为叶子菜单：</label>
			<div class="layui-input-block">
				<select name="menu/isLeaf" id="islLeaf" lay-filter="isLeaf" type="select">
					<option value="1">是</option>
					<option value="0">否</option>
				</select>
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label">功能资源：</label>
			<div class="layui-input-block">
				<input id="funcCode" name="menu/funcCode" type="hidden"/>
				<input type="text" class="layui-input" style="width:85%" name="menu/funcName" id="funcName" lay-verify="" autocomplete="off" placeholder="">
				<button type="button" class="layui-btn layui-btn-sm layui-btn-primary" id="onButtonEdit" style="position:absolute;top:0px;right:0px;height:37px"><i class="layui-icon layui-icon-more"></i></button>
			</div>
		</div>
	</div>
	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label">打开方式：</label>
			<div class="layui-input-block">
				<select name="menu/openMode" id="openMode" lay-filter="openMode" type="select">
					<option value="1">区域中</option>
					<option value="0">新窗口</option>
				</select>
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label">菜单图片路径：</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="menu/imagePath" id="displayOrder" autocomplete="off" placeholder="">
			</div>
		</div>
	</div>
	<div class="layui-form-item layui-hide">
		<input type="button" lay-submit lay-filter="layuiadmin-app-form-edit" id="layuiadmin-app-form-edit" value="确认编辑">
	</div>
</div>
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
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
	    var data = data.data;
		FindFuncName(data.funcCode);    
		form.val('layuiadmin-app-form-list', {
			"menu/menuId": data.menuId,
	  		"menu/menuAction": data.menuAction,
	  		"menu/menuLevel": data.menuLevel,
	  		"menu/menuSeq": data.menuSeq,
	  		"menu/subCount": data.subCount,
		 	"menu/menuName": data.menuName,
			"menu/menuCode": data.menuCode,
			"menu/menuLabel": data.menuLabel,
			"menu/displayOrder": data.displayOrder,
			"menu/isLeaf": data.isLeaf,
			"menu/funcName": funcName1,
	 		"menu/funcCode": data.funcCode,
			"menu/openMode": data.openMode,
			"menu/imagePath": data.imagePath
		});
	}
	
	//判断菜单代码是否已存在
	$("#menuCode").blur(function() {
		var menuCode = $("#menuCode").val();
		if (menuCode != null && menuCode != "") {
			var sendData = {
				template: {
					menuCode: menuCode
				}
			};
			var json = JSON.stringify(sendData);
			$.ajax({
				url: "com.zimax.components.coframe.framework.MenuManager.validateMenu.biz.ext",
				type: "POST",
				data: json,
				cache: false,
				contentType: "text/json",
				cache: false,
				success: function (text) {
					if (text.data == "1") {
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
			var submitData = JSON.stringify(data.field);
			if (isExist == false) {
				$.ajax({
					url: "com.zimax.components.coframe.framework.MenuManager.updateMenu.biz.ext",
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
			url: "com.zimax.components.coframe.framework.MenuManager.queryMenuFuncresource.biz.ext",
			type: "POST",
			data: JSON.stringify({
				"funcCode": data
			}),
	    	async: false,
			contentType: "text/json",
			cache: false,
			success: function (text) {
				if (text) {
					funcName1 = text.funcName;
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