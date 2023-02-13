<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 李伟杰
  - Date: 2023-2-10 16:01:27
  - Description:
-->
<head>
    <title>用户高级查询</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.0">
    <style>
        .layui-form {
            padding-top: 5px !important;
            padding-left: 5px !important;
            padding-right: 5px !important;
        }
        .layui-form-item {
            margin-bottom: 10px !important;
        }
        .layui-form-label {
            width: 100px !important;
            padding: 5px 0px !important;
        }
        .layui-input {
            height: 30px !important;
        }
    </style>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-user-form" id="layuiadmin-user-form">
    <fieldset class="layui-elem-field layui-field-title">
        <legend>高级搜索</legend>
    </fieldset>
    <div class="layui-form-item">
        <label class="layui-form-label">登录账号名：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="userId" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">用户名称：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="userName" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">角色名称：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="roleNameList" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">用户类型：</label>
        <div class="layui-input-inline">
            <select name="userType" id="userType" lay-filter="userType"
                    type="select">
                <option value=""></option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">用户状态：</label>
        <div class="layui-input-inline">
            <select name="status" id="status" lay-filter="status"
                    type="select">
                <option value=""></option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">创建人：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="userCreator" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">修改人：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="userUpdater" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item layui-hide">
        <div class="layui-inline layui-search" style="padding-left:15px">
            <button id="LAY-app-user-search-advanced" class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-user-search-advanced">
                <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
            </button>
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
    var form = layui.form;
    var $ = layui.jquery;
    var laydate = layui.laydate;
    var util = layui.util;

    var win = null;

    layui.admin.renderDictSelect({
        elem: "#userType",
        dictTypeId: "USER_TYPE",
    });
    form.render();
    layui.admin.renderDictSelect({
        elem: "#status",
        dictTypeId: "COF_USERSTATUS",
    });
    form.render();


    // 文本框回车事件
    $(".layui-input").on("keydown", function(event) {
        if (event.keyCode == 13) {
            var submit = $("#LAY-app-user-search-advanced");
            submit.click();
            return false;
        }
    });

    function SetData(data) {
        win = data.win ? data.win : window;
        var formData = data.data;
        form.val("layuiadmin-user-form", {
            userId: formData.userId,
            userName: formData.userName,
            roleNameList: formData.roleNameList,
            userType: formData.userType,
            status: formData.status,
            userCreator: formData.userCreator,
            userUpdater: formData.userUpdater
      });
    }

    function reset() {
        var formData = {
            userId: "",
            userName: "",
            roleNameList: "",
            userType: "",
            status: "",
            userCreator: "",
            userUpdater: ""
        }
        win.setFormData(formData);
    }

    //监听提交
    form.on("submit(LAY-app-user-search-advanced)", function(data) {
        win.setFormData(data.field);
        win.layer.closeAll("iframe");
    });
</script>
</body>
</html>