<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 李伟杰
  - Date: 2023-1-30 14:37:20
  - Description:
-->
<head>
    <title>更新包上传管理高级查询</title>
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
<div class="layui-form" lay-filter="layuiadmin-update_package-form" id="layuiadmin-update_package-form">
    <fieldset class="layui-elem-field layui-field-title">
        <legend>高级搜索</legend>
    </fieldset>
    <div class="layui-form-item">
        <label class="layui-form-label">更新包单号：</label>
        <div class="layui-input-inline">
            <input type="text" name="uploadNumber" placeholder="" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">版本号：</label>
        <div class="layui-input-inline">
            <input type="text" name="version" placeholder="" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">终端类型：</label>
        <div class="layui-input-inline">
            <select name="deviceSoType" id="deviceSoType" lay-filter="deviceSoType"
                    type="select">
                <option value=""></option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">更新策略：</label>
        <div class="layui-input-inline">
            <select name="uploadStrategy" id="uploadStrategy" lay-filter="uploadStrategy" type="select">
                <option value=""></option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">上传人：</label>
        <div class="layui-input-block" >
            <input type="text" class="layui-input" name="uploader" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">上传时间：</label>
        <div class="layui-input-block">
            <input id="versionUploadTime" type="text" class="layui-input" name="versionUploadTime" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item layui-hide">
        <div class="layui-inline layui-search" style="padding-left:15px">
            <button id="LAY-app-update_package-search-advanced" class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-update_package-search-advanced">
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

    // 上传时间选择器
    laydate.render({
        elem: "#versionUploadTime",
        type: "date",
        trigger: "click"
    });


    //获取软件类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#deviceSoType",
        dictTypeId: "DEVICE_SOFTWARE_TYPE",
    });
    form.render();


    //获取更新策略的下拉值
    layui.admin.renderDictSelect({
        elem: "#uploadStrategy",
        dictTypeId: "UPDATESTRATEGY",
    });
    form.render();




    // 文本框回车事件
    $(".layui-input").on("keydown", function(event) {
        if (event.keyCode == 13) {
            var submit = $("#LAY-app-update_package-search-advanced");
            submit.click();
            return false;
        }
    });

    function SetData(data) {
        win = data.win ? data.win : window;
        var formData = data.data;
        form.val("layuiadmin-update_package-form", {
            uploadNumber: formData.uploadNumber,
            version: formData.version,
            deviceSoType: formData.deviceSoType,
            uploadStrategy: formData.uploadStrategy,
            uploader: formData.uploader,
            versionUploadTime: formData.versionUploadTime ? util.toDateString(formData.versionUploadTime, "yyyy-MM-dd") : ""
        });
    }

    function reset() {
        var formData = {
            uploadNumber: "",
            version: "",
            deviceSoType: "",
            uploadStrategy: "",
            uploader: "",
            versionUploadTime: ""
        }
        win.setFormData(formData);
    }

    //监听提交
    form.on("submit(LAY-app-update_package-search-advanced)", function(data) {
        win.setFormData(data.field);
        win.layer.closeAll("iframe");
    });
</script>
</body>
</html>
