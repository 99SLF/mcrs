<%@page pageEncoding="UTF-8"%>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<title>添加菜单</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.0">
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list" style="padding: 20px 30px 0 0;">
	<input id="menuId" name="menu/menuId" type="hidden"/>
	<input id="parentMenuId" name="menu/parentMenu/menuId" type="hidden"/>
	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label" >菜单名称：<span style="color:red">*</span></label>
			<div class="layui-input-block">
				<input id="menuAction" name="menu/menuAction" type="hidden"/>
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
			<label class="layui-form-label" title="是否为叶子菜单">是否为叶子菜单：</label>
			<div class="layui-input-block">
				<select name="menu/isLeaf" id="isLeaf" lay-filter="isLeaf" type="select">
				</select>
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label">功能资源：</label>
			<div class="layui-input-block"  id="input-block">
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
		<input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="确认添加">
	</div>
</div>
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
<script type="text/javascript">
	var layer = layui.layer;
	var form = layui.form;
	var $ = layui.jquery;
	var isExist = false;
	var i = 0;
	var submit = false;
	form.render();
	
	layui.admin.renderDictSelect({    
		elem: "#isLeaf",
		dictTypeId: "COF_YESORNO"
	});
	
	$("#isLeaf").val("1");  
	form.render();
	
	var win = null;
	function SetData(data) {
	 	win = data.win ? data.win : window;	
	 	$("#parentMenuId").val(data.parentMenuId); 
	}
	
	layui.use(['form'], function() {
		form.on('select(isLeaf)', function(data) {
			var value = data.value;
			if (value == 0) {
				$("#funcName").attr("disabled", true); 
				$("#funcName").attr("style", "background:#CCCCCC");
				$('#onButtonEdit').addClass("layui-btn-disabled").attr("disabled",true);
				$("#openMode").attr("disabled","disabled");
				form.render('select');
			} else {
				$("#funcName").removeAttr("disabled","disabled");
				$("#funcName").attr("style", "background:#FFFFFF");
				$('#onButtonEdit').removeClass("layui-btn-disabled").attr("disabled",false);
				$("#openMode").removeAttr("disabled","disabled");
				form.render('select');
			}
		});
		
});

	
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
	form.on("submit(layuiadmin-app-form-submit)", function(data) {
		if (submit == false) {
			submit = true;
			var submitData = JSON.stringify(data.field);
			if (isExist == false) {
				$.ajax({
					url: "com.zimax.components.coframe.framework.MenuManager.saveMenu.biz.ext",
					type: "POST",
					data: submitData,
					cache: false,
					contentType: 'text/json',
					success: function(result) {
						layer.msg("添加成功", {
							icon: 1,
							time: 2000
						}, function() {
							var index = top.layer.getFrameIndex(window.name);
							win.layui.table.reload('LAY-app-menu-list');
							top.layer.close(index); 
							win.window.updata_select();
	        			});
					}
				});	
			} else if ( isExist == true) {
				layer.msg("菜单代码已存在，请重新输入", {
					icon: 2,
					time: 2000
				});
				submit = false;
			}
		} else {
			layer.msg("正在添加...请稍等！");
		}
		return false;                
	});
	
	//调用功能选择入口
	$("#onButtonEdit").click(function(){
    	top.layer.open({
    		type:2,
	        title: "选择功能调用入口",
	        area: ["850px", "470px"],
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