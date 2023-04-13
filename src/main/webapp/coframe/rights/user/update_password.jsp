<%@ page import="com.zimax.cap.party.IUserObject" %>
<%@ page import="com.zimax.cap.datacontext.DataContextManager" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>

<html>
<!-- 
  - Author(s): 李伟杰
  - Date: 2023-04-12 15:42:05
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=equipment-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="shortcut icon" href="<%=request.getContextPath() %>/std/dist/images/favicon.ico?v=3"/>
    <title>修改密码</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/admin.css" media="all">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v2">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/iconfont/iconfont.css?v3">
</head>
<body>
<<% IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();%>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">修改密码</div>
                <div class="layui-card-body" pad15>
                    <div class="layui-form" lay-filter="">
                        <input id="operatorId" type="hidden" class="layui-hidden" name="user/operatorId"/>
                        <input id="userId" type="hidden" class="layui-hidden" name="userId"
                               value="<%=userObject.getUserId() %>"/>
                        <div class="layui-form">
                            <div class="layui-form-item">
                                <label class="layui-form-label">当前密码</label>
                                <div class="layui-input-inline">
                                    <input type="password" name="password" lay-verify="required" lay-verType="tips"
                                           class="layui-input" lay-verType="tips">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">新密码</label>
                                <div class="layui-input-inline">
                                    <input type="password" name="user/password" id="pwd1" lay-verify="required|pass"
                                           lay-verType="tips" autocomplete="off" class="layui-input">
                                </div>
                                <div class="layui-form-mid layui-word-aux">6到16个字符</div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">确认新密码</label>
                                <div class="layui-input-inline">
                                    <input type="password" name="pwd2" id="pwd2" lay-verify="repass" lay-verType="tips"
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-input-block">
                                    <button class="layui-btn" lay-submit id="save_data" lay-filter="save_data">确认修改
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%--<div>--%>
<%--    <div>--%>
<%--        <button class="layui-btn" lay-submit layadmin-event="logout" style="text-align: center;"><a>退出</a>--%>
<%--        </button>--%>
<%--    </div>--%>
<%--</div>--%>
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script>
    layui.config({
        base: "<%=request.getContextPath()%>/"
    });
</script>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
<script type="text/javascript">
    var req_data; //全局变量
    var layer = layui.layer; //弹层
    var table = layui.table; //表格
    var form = layui.form; //表单
    var $ = layui.jquery; //jquery
    var admin = layui.admin;
    //提交
    form.on('submit(save_data)', function (data) {	  //根据 lay-filter
        var password = data.field.password;
        var userId = data.field.userId;
        var pwd2 = data.field.pwd2;
        $.ajax({
            url: "<%=request.getContextPath()%>/user/updateCapUserPassword?password=" + password + "&userId=" + userId + "&pwd2=" + pwd2,
            type: 'POST',
            async: false,
            contentType: "text/json",
            cache: false,
            success: function (result) {
                debugger;
                if (result.code = "0") {
                    //调用退出方法
                    admin.events.logout();
                    <%--layer.msg(result.msg, {}, function (index) {--%>
                    <%--    //调用后端清除数据--%>
                    <%--    $.ajax({--%>
                    <%--        url: "<%=request.getContextPath()%>/auth/logout",--%>
                    <%--        type: "get",--%>
                    <%--        data: {},--%>
                    <%--        done: function(e) {--%>
                    <%--            admin.exit(function() {--%>
                    <%--                location.href = "<%=request.getContextPath()%>/coframe/auth/login.jsp";--%>
                    <%--            });--%>
                    <%--        }--%>
                    <%--    });--%>
                    <%--    // 1. 清空本地存储中的 token--%>
                    <%--    localStorage.removeItem('token');--%>
                    <%--    sessionStorage.clear();--%>
                    <%--    // 2. 重新跳转到登录页面--%>
                    <%--    top.location.href = "<%=request.getContextPath()%>/coframe/auth/login.jsp";--%>
                    <%--});--%>
                } else {
                    layer.msg(result.msg);
                }
            },
            // done: function(res){ //这里要说明一下：done 是只有 response 的 code 正常才会执行。而 succese 则是只要 http 为 200 就会执行
            // //清空本地记录的 token，并跳转到登入页
            // admin.exit();
            // }

        });
    });
    //校验
    form.verify({
        pass: function (value) {
            if (value.length > 16 || value.length < 6) {
                return "密码长度不符合规范";
            }
        },
        repass: function (value) {
            if (value != $("#pwd1").val()) {
                return "两次输入的密码不一致!";
            }
        }
    });
</script>
</body>
</html>