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
<meta name="viewport" content="width=equipment-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<title>添加角色</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<style type="text/css">

</style>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list" style="padding: 20px 30px 0 0;">
	<input type="hidden" name=""user/operatorId"" value="default">
	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label" >用户登录名:<span style="color:red">*</span></label>
			<div class="layui-input-block">
				<input id="userId" type="text" name="user/userId" lay-verify="required|checkUserId" placeholder="用户登录名(必填)" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label" >用户名称:<span style="color:red">*</span></label>
			<div class="layui-input-block">
				<input id="userName" type="text" name="user/userName" lay-verify="required" placeholder="用户名称(必填)" autocomplete="off" class="layui-input">
			</div>
		</div>
	</div>
	
	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label"  >登录密码:<span style="color:red">*</span></label>
			<div class="layui-input-block">
				<input  type="password" name="user/password" lay-verify="required" placeholder="登录密码(必填)" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label">密码失效日期</label>
			<div class="layui-input-block">
	  			<input type="text" name="user/invalDate" id="invaldate" autocomplete="off" class="layui-input">
			</div>
		</div>
	</div>
	
	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label" >有效开始时间:</label>
			<div class="layui-input-block">
	  			<input type="text" name="user/startDate" id="startdate" autocomplete="off" class="layui-input" >
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label" >有效截止时间：</label>
			<div class="layui-input-block">
	  			<input type="text" name="user/endDate" id="enddate" autocomplete="off" class="layui-input" >
			</div>
		</div>
	</div>
	
	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label" >邮箱地址：</label>
			<div class="layui-input-block">
	       		<input type="text" name="user/email" id="email" lay-verify="" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label">用户状态：</label>
			<div class="layui-input-block">
				<select name="user/status" id="status" lay-filter="status" type="select"  >
					 <option value=""></option>
				</select>		
			</div>
		</div>
	</div>
	
	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label" >认证模式：</label>
			<div class="layui-input-block">
				<select name="user/authMode" id="authMode" lay-filter="authMode" type="select">
					<option value=""></option>
				</select>		
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label" >菜单布局：</label>
			<div class="layui-input-block">
				<select name="user/menuType" id="menuType" lay-filter="menuType" type="select">
			  		<option value=""></option>
			    </select>
			</div>
		</div>
	</div>
	
	<div class="layui-row layui-col-space10">		
		<label class="layui-form-label">IP地址：</label>
		<div class="layui-input-block">
			<textarea  class="layui-textarea field-effect field-content" name="user/ipAddress" id="ipAddress" autocomplete="off" placeholder="" lay-verify=""></textarea>
		</div>
	</div>
	<div class="layui-form-item layui-hide">
		<input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="确认添加">
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
	var laydate=layui.laydate;
	var form = layui.form;
	var $ = layui.jquery;
	var submit = false;
	
	var isExist = false;

	layui.admin.renderDictSelect({    //获取用户状态的下拉值
  	elem: "#status",
  	dictTypeId: "COF_USERSTATUS",
  });
	layui.admin.renderDictSelect({	 //获取用户权限的下拉值
  	elem: "#authMode", 
  	dictTypeId: "COF_AUTHMODE"
  });
  layui.admin.renderDictSelect({	   //获取菜单布局的下拉值
  	elem: "#menuType",
  	dictTypeId: "COF_SKINLAYOUT"
  });
	
	$("#status").val("1");
	$("#authMode").val("local");
	$("#menuType").val("default");
	
	var win = null;
	function SetData(data) {
		win = data.win ? data.win : window;	     	      
	}

	form.render();  	 
	  	//日期
	laydate.render({
		elem: '#invaldate',
  		format: 'yyyy-MM-dd',
  		trigger: 'click',   //解决时间选择器一闪而过的情况
  	});
  	
	var startDate = laydate.render({
		elem: '#startdate',
		type: 'date',//设置日期的类型
		trigger:'click',
		done: function(value, date) {
			if (value != "") {
		    date.month = date.month - 1;
		    date.date = date.date + 1;
		    endDate.config.min = date;
			} else {
				endDate.config.min = startDate.config.min;
			}
		},
	});
	
	var endDate = laydate.render({
		elem: '#enddate',//绑定的控件名称
		type: 'date',//设置日期的类型
		//theme: '#2c78da',
		trigger: 'click',
		done: function(value, date) {
			if (value != "") {
				date.month = date.month - 1;
				date.date = date.date - 1;
				startDate.config.max = date;
			} else {
	     		startDate.config.max = endDate.config.max;
			}
		}
	});
  	
	//判断角色是否已存在
	$("#userId").blur(function() {
		var userId = $("#userId").val();
		console.log(userId);
		if (userId != null && userId != "") {
			var json = JSON.stringify({
				userId: userId});
			$.ajax({
				url: "com.zimax.components.coframe.rights.UserManager.checkUser.biz.ext",
				type: "POST",
				data: json,
				cache: false,
				contentType: "text/json",
				cache: false,
				success: function(text) {
					if (text.bool) {
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
		var submitData = JSON.stringify(data.field);
		if (submit == false) {
			submit = true;
			if (isExist == false) {
				$.ajax({
					url: "com.zimax.components.coframe.rights.UserManager.addUser.biz.ext",
					type: "POST",
					data: submitData,
					cache: false,
					contentType: 'text/json',
					success: function(result) {
						layer.msg("添加成功", {
							icon: 1,
							time: 2000
						}, function() {
							var index = parent.layer.getFrameIndex(window.name);
							win.layui.table.reload('LAY-app-user-list-reload');
							top.layer.close(index);  
						});
					}
				});	
			} else if (isExist == true) {
				submit = false;
				layer.msg("角色已存在，请重新输入", {
					icon: 2,
					time: 2000
				});
			}
		} else {
			layer.msg("请稍等");
		}
		return false;                
	});
</script>
</body>
</html>