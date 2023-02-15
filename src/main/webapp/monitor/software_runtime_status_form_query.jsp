<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 李伟杰
  - Date: 2023-02-09 13:49:25
  - Description:
-->
<head>
    <title>软件运行状态高级查询</title>
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
<div class="layui-form" lay-filter="layuiadmin-software_status-form" id="layuiadmin-software_status-form">
    <fieldset class="layui-elem-field layui-field-title">
        <legend>高级搜索</legend>
    </fieldset>
    <div class="layui-form-item">
        <label class="layui-form-label">设备资源号：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="equipmentId" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">设备名称：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="equipmentName" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">终端名称：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="deviceName" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">终端类型：</label>
        <div class="layui-input-inline">
            <select name="deviceSoftwareType" id="deviceSoftwareType" lay-filter="deviceSoftwareType"
                    type="select">
                <option value=""></option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">运行状态：</label>
        <div class="layui-input-inline">
            <select name="deviceSoftwareStatus" id="deviceSoftwareStatus" lay-filter="deviceSoftwareStatus"
                    type="select">
                <option value=""></option>
            </select>
        </div>
    </div>
    <div class="layui-form-item layui-hide">
        <div class="layui-inline layui-search" style="padding-left:15px">
            <button id="LAY-app-software_status-search-advanced" class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-software_status-search-advanced">
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


    //获取软件类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#deviceSoftwareType",
        dictTypeId: "DEVICE_SOFTWARE_TYPE",
    });
    form.render();
    //获取软件运行状态
    layui.admin.renderDictSelect({
        elem: "#deviceSoftwareStatus",
        dictTypeId: "DEVICE_SOFTWARE_STATUS",
    });
    form.render();

    // 文本框回车事件
    $(".layui-input").on("keydown", function(event) {
        if (event.keyCode == 13) {
            var submit = $("#LAY-app-software_status-search-advanced");
            submit.click();
            return false;
        }
    });

    function SetData(data) {
        win = data.win ? data.win : window;
        var formData = data.data;
        form.val("layuiadmin-software_status-form", {
            equipmentId: formData.equipmentId,
            equipmentName: formData.equipmentName,
            deviceName : formData.deviceName,
            deviceSoftwareType: formData.deviceSoftwareType,
            deviceSoftwareStatus: formData.deviceSoftwareStatus
        });
    }

    function reset() {
        var formData = {
            equipmentId: "",
            equipmentName: "",
            deviceName: "",
            deviceSoftwareType: "",
            deviceSoftwareStatus: ""

        }
        win.setFormData(formData);
    }

    //监听提交
    form.on("submit(LAY-app-software_status-search-advanced)", function(data) {
        win.setFormData(data.field);
        win.layer.closeAll("iframe");
    });
</script>
</body>
</html>
