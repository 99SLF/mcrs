<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.mes.access.http.security.config.HttpSecurityConfig"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.zimes.cap.AppUserManager"%>
<html>
<!-- 
  - Author(s): SSW
  - Date: 2021-03-30 10:42:05
  - Description:
-->
<head>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<title>修改密码</title>
<%
   String url = null;
   HttpSecurityConfig securityConfig = new HttpSecurityConfig();
   boolean isOpenSecurity = securityConfig.isOpenSecurity();
   if (isOpenSecurity) {
   		boolean isAllInHttps = securityConfig.isAllInHttps();
   		if (!isAllInHttps) {
   			String ip = securityConfig.getHost();
   			String https_port = securityConfig.getHttps_port();
   			url = "https://" + ip + ":" + https_port + request.getContextPath() + "/coframe/rights/user/com.zimax.components.coframe.rights.user.cipher.update_password.flow";
   		} else {
   			url = "com.zimax.components.coframe.rights.user.cipher.update_password.flow"; 
   		}
	} else { 
   		url = "com.zimax.components.coframe.rights.user.cipher.update_password.flow";
   	}
%>
</head>
<body>
	<!--<div style="padding: 0 10px;margin-top: 10px;" class="mcolor"></div>
	<div class="page-body">
		<div class="layui-tab ">
			<div class="layui-tab-content page-tab-content">
				<div class="layui-tab-item layui-show">
					<div class="layui-form page-form-width">
						<form class="layui-form" method="post" id="updateform" name="updateform">
							<div class="page-form">
								<input id="operatorId" type="hidden" class="layui-hidden" name="user/operatorId" />
								<input id="userId" type="hidden" class="layui-hidden" name="user/userId" value="<%=AppUserManager.getCurrentUserId() %>"/>
								<div class="layui-form-item">
									<label class="layui-form-label layui-form-project" style="width: 150px;">当前用户：</label>
									<div class="layui-input-inline">
										<input id="userId" type="text" class="layui-input field-title" name="CapUser/userId" lay-verify="required" autocomplete="off" placeholder="">
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label layui-form-project" style="width: 150px;">输入旧密码：</label>
									<div class="layui-input-inline">
										<input id="password" type="password" class="layui-input field-title" name="CapUser/password" lay-verify="required" autocomplete="off" placeholder="">
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label layui-form-project" style="width: 150px;">输入新密码：</label>
									<div class="layui-input-inline">
										<input id="pwd1" type="password" class="layui-input field-title" name="pwd1" lay-verify="required" autocomplete="off" placeholder="">
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label layui-form-project" style="width: 150px;">确认新密码：</label>
									<div class="layui-input-inline">
										<input id="pwd2" type="password" class="layui-input field-title" name="pwd2" lay-verify="required" autocomplete="off" placeholder="">
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label"> </label>
									<div class="layui-input-block">
										<button type="submit" lay-submit="" style="width: 35%;" class="layui-btn layui-btn-fluid" id="sava_data" lay-filter="sava_data">保存</button>
										<button type="button" onclick="formCancel()" class="layui-btn layui-btn-primary layui-btn-fluid ml10" style="width: 35%;" >取消</a>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>-->
	
	<div class="layui-fluid">
    	<div class="layui-row layui-col-space15">
      		<div class="layui-col-md12">
        		<div class="layui-card">
          			<div class="layui-card-header">修改密码</div>
          			<div class="layui-card-body" pad15>
	            		<div class="layui-form" lay-filter="">
	            			<input id="operatorId" type="hidden" class="layui-hidden" name="user/operatorId"/>
							<input id="userId" type="hidden" class="layui-hidden" name="user/userId" value="<%=AppUserManager.getCurrentUserId() %>"/>
	              			<div class="layui-form-item">
		                		<label class="layui-form-label">当前密码</label>
		                		<div class="layui-input-inline">
		                  			<input type="password" name="password" lay-verify="required" lay-verType="tips" class="layui-input">
		                		</div>
		              		</div>
		              		<div class="layui-form-item">
		                		<label class="layui-form-label">新密码</label>
		                		<div class="layui-input-inline">
		                  			<input type="password"  name="user/password"  id="pwd1" lay-verify="required|pass" lay-verType="tips" autocomplete="off"  class="layui-input">
		                		</div>
	                			<div class="layui-form-mid layui-word-aux">6到16个字符</div>
	              			</div>
	              			<div class="layui-form-item">
	                			<label class="layui-form-label">确认新密码</label>
	                			<div class="layui-input-inline">
	                  				<input type="password" name="pwd2"  id="pwd2" lay-verify="repass" lay-verType="tips" autocomplete="off" class="layui-input">
	                			</div>
	             	 		</div>
	              			<div class="layui-form-item">
	                			<div class="layui-input-block">
	                  				<button class="layui-btn" lay-submit id="save_data" lay-filter="save_data">确认修改</button>
	                			</div>
	              			</div>
	            		</div>
	          		</div>
	        	</div>
	      	</div>
	    </div>
	</div>

<script type="text/javascript">
	var req_data; //全局变量
	//采用全加载模块
	;!function() {
	  	  //无需再执行layui.use()方法加载模块，直接使用即可
	  	var layer = layui.layer; //弹层
		var table = layui.table; //表格
		var form = layui.form; //表单
		var $ = layui.jquery; //jquery
		var submit = false;
		   
		  //提交
		form.on('submit(save_data)', function(data) {	  //根据 lay-filter
			var submitData=JSON.stringify(data.field);  //获取name的value
			if (submit == false) {
				submit = true;
				$.ajax({
					url: "com.zimax.components.coframe.rights.UserManager.updatePassword.biz.ext",
					type: 'POST',
					data: submitData,
					cache: false,
					contentType: 'text/json',
					success: function(result) {
						if (result.retValue == "true") {
							layer.msg('修改成功', {
								icon: 1,
								time: 2000
							}, function() {
								var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
								parent.layer.close(index); //再执行关闭  
			        		});
		    			} else {
		        			layer.msg("修改失败，请检查密码是否正确");
		        			submit = false;
		    			}
					}
				});		
			} else {
				layer.msg("请稍等");
			}
			return false; 
		});
		  
		  //校验
		form.verify({
		  	pass: function(value) {
		  		if (value.length>16||value.length<6) {
		  			return "密码长度不符合规范";
		  		}
		  	},
		  	repass: function(value) {
		  		if (value!=$("#pwd1").val()) {
		  			return "两次输入的密码不一致!";
		  		}
		  	}
		});		
    }();  
</script>
</body>
</html>