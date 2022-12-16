<%@page import="org.codehaus.jettison.json.JSONObject"%>
<%@page import="javax.script.ScriptEngine"%>
<%@page import="javax.script.ScriptEngineManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="shortcut icon" href="<%=request.getContextPath() %>/std/dist/images/favicon.ico?v=3" />
<title>RFID数据采集管控一体平台</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/common/layui/css/layui.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/std/dist/style/admin.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/std/dist/style/lmxnew.css?v120301021">
<link rel="stylesheet" href="<%=request.getContextPath() %>/std/dist/style/loginnew.css">
<style type="text/css">
html{
	background-color: #fff;
}
</style>
<%
	boolean remember = false;
	String userId = "";
	String password = "";
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("loginInfo")) {
				ScriptEngineManager sem = new ScriptEngineManager();
				ScriptEngine engine = sem.getEngineByExtension("js");
				String loginInfo = (String) engine.eval("unescape('" + cookie.getValue() + "')");
				JSONObject jsonObject = new JSONObject(loginInfo);
				userId = jsonObject.getString("userId");
				password = jsonObject.getString("password");
				remember = true;
				break;
			}
		}
	}
 %>
</head>
<body class="layui-layout-body">
<main class="firstBox">
<div id="content-container" class="container file-openlogin">
	<div class="toplogo">
		<a class="form-logo" href="<%=request.getContextPath() %>/index.jsp"></a>
	</div>
	<ul class="">
		<li class="file-openlogin-box">
			<div class="user-section login-section file-openlogin-box-bd">
				<div class="form-banner">
					<a class="form-logo" href="<%=request.getContextPath() %>/index.jsp"></a>
					<div class="form-banner-img"></div>
				</div>
				<div class="layui-tab layui-tab-brief" id="tabopenid" style="display: block;background-color: #fff;" lay-filter="docDemoTabBrief">
					<ul class="layui-tab-title" style="text-align:center;">
						<li class="layui-this">登 录</li>
<%--						<li class=""> <a href="/index/user/register.html"></a>注 册</li>--%>
					</ul>
					<div class="layui-tab-content" style="display:bloc">
						<div class="layui-tab-item   layui-show">
							<form class="layui-form">
								<div class="layadmin-user-login-box layadmin-user-login-body layui-form">
									<div class="layui-form-item">
										<label class="layadmin-user-login-icon layui-icon layui-icon-username" for="LAY-user-login-username"></label>
										<input type="text" name="userId" id="userId" lay-verify="required" placeholder="登录名称" value="<%=userId %>" autocomplete="off" class="layui-input">
									</div>
									<div class="layui-form-item">
										<label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-password"></label>
										<input type="password" name="password" id="password" lay-verify="required" placeholder="密码" value="<%=password %>" class="layui-input">
									</div>
<%--									<div class="layui-form-item" id="forget" style="margin-bottom: 20px;">--%>
<%--										<a href="javascript:;" class="layadmin-user-jump-change layadmin-link" style="margin-top: 7px;" id="forgotpassword">忘记密码？</a>--%>
<%--									</div>--%>
									<div class="layui-form-item">
										<button id="login" class="layui-btn layui-btn-normal layui-btn-fluid" lay-submit="login" lay-filter="login">登 入</button>
									</div>
<%--									<div class="layui-trans layui-form-item layadmin-user-login-other pad-top-no">--%>
<%--										<label>社交账号登入</label>--%>
<%--										<a class="thirdlogin" href="javascript:;"><i class="layui-icon layui-icon-login-qq"></i></a>--%>
<%--										<a class="thirdlogin" href="javascript:;"><i class="layui-icon layui-icon-login-wechat"></i></a>--%>
<%--										<a class="thirdlogin" href="javascript:;"><i class="layui-icon layui-icon-login-weibo"></i></a>--%>
<%--									</div>--%>
								</div>
							</form>
							<div style="display:none;">
								<form id="singleSign" action="https://sso.histron.cn/authcenter/remoteLogin" method="post">
									<input type="hidden" name="username" value="">
									<input type="hidden" name="password" value="">
									<input type="hidden" name="service" value="">
									<input type="hidden" name="loginUrl" value="">
									<input type="hidden" name="submit1" value="true">
								</form>
							</div>
						</div>
						<div class="layui-tab-item " style="display:none">
							<form class="layui-form">
								<div class="layadmin-user-login-box layadmin-user-login-body layui-form pad-bottom-no">
									<div class="layui-form-item">
										<label class="layadmin-user-login-icon layui-icon layui-icon-username" for="LAY-user-login-nickname"></label>
										<input type="text" name="userId" id="reg_userId" lay-verify="required|user" placeholder="登录名称" class="layui-input">
									</div>
									<div class="layui-form-item">
										<label class="layadmin-user-login-icon layui-icon layui-icon-form" for="LAY-user-login-email"></label>
										<input type="text" name="email" lay-verify="required|email" placeholder="邮箱" class="layui-input">
									</div>
									<div class="layui-form-item">
										<label class="layadmin-user-login-icon layui-icon layui-icon-cellphone" for="LAY-user-login-cellphone"></label>
										<input type="text" name="mobile" lay-verify="required|mobile" placeholder="手机" class="layui-input">
									</div>
									<div class="layui-form-item">
										<label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-password"></label>
										<input type="password" name="password" lay-verify="required|pass" placeholder="密码(6到16个字符)" class="layui-input">
									</div>
									<div class="layui-form-item">
										<label class="layadmin-user-login-icon layui-icon layui-icon-share"></label>
										<input type="text" name="invitation"  placeholder="邀请码" class="layui-input">
									</div>
									<div class="layui-form-item">
										<button class="layui-btn layui-btn-normal layui-btn-fluid" lay-submit="" lay-filter="register">注 册</button>
									</div>
									<div class="layui-trans layui-form-item layadmin-user-login-other pad-top-no">
										<label>社交账号注册</label>
										<a class="thirdlogin" href="javascript:;"><i class="layui-icon layui-icon-login-qq"></i></a>
										<a class="thirdlogin" href="javascript:;"><i class="layui-icon layui-icon-login-wechat"></i></a>
										<a class="thirdlogin" href="javascript:;"><i class="layui-icon layui-icon-login-weibo"></i></a>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="layadmin-user-login-box layadmin-user-login-body layui-form" id="openpassid" style="display: none">
					<div class="layadmin-user-login-box layadmin-user-login-header">
						<p>正在找回密码</p>
					</div>
					<div class="layui-form-item">
						<label class="layadmin-user-login-icon layui-icon layui-icon-cellphone" for="LAY-user-login-cellphone"></label>
						<input type="text" name="mobile" readonly="readonly" onfocus='javascript:$(this).removeAttr("readonly");' id="chekcmobile" lay-verify="required|mobile" placeholder="请输入注册时的手机号" class="layui-input">
					</div>
					<div class="layui-form-item">
						<label class="layadmin-user-login-icon layui-icon layui-icon-cellphone" for="LAY-user-login-cellphone"></label>
						<input type="password" name="password" readonly="readonly" onfocus='javascript:$(this).removeAttr("readonly");' id="newpass" lay-verify="required|pass" placeholder="请输入新密码" class="layui-input">
					</div>
					<input type="hidden" name="event" value="changepwd">
					<div class="layui-form-item">
						<div class="layui-row">
							<div class="layui-col-xs7">
								<label class="layadmin-user-login-icon layui-icon layui-icon-vercode" for="LAY-user-login-smscode"></label>
								<input type="text" name="captcha" id="captchmobile" lay-verify="required" placeholder="短信验证码" class="layui-input">
							</div>
							<div class="layui-col-xs5">
								<div style="margin-left: 10px;">
									<button type="button" id="getmsg" class="layui-btn layui-btn-primary layui-btn-fluid">获取验证码</button>
								</div>
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<button class="layui-btn layui-btn-normal layui-btn-fluid" lay-submit lay-filter="LAY-user-forget-submit">找回密码</button>
					</div>
					<div class="layui-form-item">
						<a href="javascript:;" id="gobackbtn" class="layadmin-user-jump-change layadmin-link" style="margin-top: 7px;"><i class="layui-icon layui-icon-return"></i> 返回</a>
					</div>
				</div>
			</div>
		</li>
	</ul>
</div>
<script type="text/javascript">
	function myfun(){
		var op = '<input type="checkbox" name="remember" id="remembercheck" <%=remember ? "checked" : "" %> lay-skin="primary" title="记住密码">'+
             '<div class="layui-unselect layui-form-checkbox <%=remember ? "layui-form-checked" : "" %>" id="remember"lay-skin="primary">'+
             '<span>记住密码</span><i class="layui-icon layui-icon-ok"></i>'+
             '</div>';
		$('#forget').append(op); //在原来的后面加这个
    }
    /*用window.onload调用myfun()*/

    // 不要括号
	window.onload = myfun;
    
</script>
<script type="text/html" id="resetpwdtpl">
    <form id="resetpwd-form" class="form-horizontal form-layer" method="POST" action="/api/user/resetpwd.html">
        <div class="form-body">
            <input type="hidden" name="action" value="resetpwd" />
            <div class="form-group">
                <label for="" class="control-label col-xs-12 col-sm-3">类型:</label>
                <div class="col-xs-12 col-sm-8">
                    <div class="radio">
                        <label for="type-email"><input id="type-email" checked="checked" name="type" data-send-url="/api/ems/send.html" data-check-url="/api/validate/check_ems_correct.html" type="radio" value="email"> 通过邮箱</label>
                        <label for="type-mobile"><input id="type-mobile" name="type" type="radio" data-send-url="/api/sms/send.html" data-check-url="/api/validate/check_sms_correct.html" value="mobile"> 通过手机重置</label>
                    </div>        
                </div>
            </div>
            <div class="form-group" data-type="email">
                <label for="email" class="control-label col-xs-12 col-sm-3">邮箱:</label>
                <div class="col-xs-12 col-sm-8">
                    <input type="text" class="form-control" id="email" name="email" value="" data-rule="required(#type-email:checked);email;remote(/api/validate/check_email_exist.html, event=resetpwd, id=)" placeholder="">
                    <span class="msg-box"></span>
                </div>
            </div>
            <div class="form-group hide" data-type="mobile">
                <label for="mobile" class="control-label col-xs-12 col-sm-3">手机号:</label>
                <div class="col-xs-12 col-sm-8">
                    <input type="text" class="form-control" id="mobile" name="mobile" value="" data-rule="required(#type-mobile:checked);mobile;remote(/api/validate/check_mobile_exist.html, event=resetpwd, id=)" placeholder="">
                    <span class="msg-box"></span>
                </div>
            </div>
            <div class="form-group">
                <label for="captcha" class="control-label col-xs-12 col-sm-3">验证码:</label>
                <div class="col-xs-12 col-sm-8">
                    <div class="input-group">
                        <input type="text" name="captcha" class="form-control" data-rule="required;length(4);integer[+];remote(/api/validate/check_ems_correct.html, event=resetpwd, email:#email)" />
                        <span class="input-group-btn" style="padding:0;border:none;">
                            <a href="javascript:;" class="btn btn-info btn-captcha" data-url="/api/ems/send.html" data-type="email" data-event="resetpwd">发送验证码</a>
                        </span>
                    </div>
                    <span class="msg-box"></span>
                </div>
            </div>
            <div class="form-group">
                <label for="newpassword" class="control-label col-xs-12 col-sm-3">新密码:</label>
                <div class="col-xs-12 col-sm-8">
                    <input type="password" class="form-control" id="newpassword" name="newpassword" value="" data-rule="required;password" placeholder="">
                    <span class="msg-box"></span>
                </div>
            </div>
        </div>
        <div class="form-group form-footer">
            <label class="control-label col-xs-12 col-sm-3"></label>
            <div class="col-xs-12 col-sm-8">
                <button type="submit" class="btn btn-md btn-info">确定</button>
            </div>
        </div>
    </form>
</script>
</main>
<div class="popBg" id="popBg"></div>
<script>
	var level = "";
	var contextPath = "<%=request.getContextPath() %>";
</script>
<script src="<%=request.getContextPath() %>/std/dist/lib/jquery-1.11.0.js"></script>
<script src="<%=request.getContextPath()%>/common/layui/layui.all.js"></script>
<script src="<%=request.getContextPath() %>/std/dist/lib/control.js?v113123048"></script>
<script src="<%=request.getContextPath() %>/std/dist/lib/responsiveslides.min.js"></script>
<script src="<%=request.getContextPath() %>/std/dist/lib/slide.js"></script>
</body>
</html>