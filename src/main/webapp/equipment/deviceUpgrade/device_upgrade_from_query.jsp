<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 李伟杰
  - Date: 2023-2-2 20:16:25
  - Description:
-->
<head>
    <title>升级记录高级查询</title>
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
<div class="layui-form" lay-filter="layuiadmin-deviceUpgrade-form" id="layuiadmin-deviceUpgrade-form">
    <fieldset class="layui-elem-field layui-field-title">
        <legend>高级搜索</legend>
    </fieldset>
    <div class="layui-form-item">
        <label class="layui-form-label">终端名称：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="deviceName" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">终端类型：</label>
        <div class="layui-input-block">
            <select name="deviceSoftwareType" id="deviceSoftwareType" lay-filter="deviceSoftwareType"
                    type="select">
                <option value=""></option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">设备资源号：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="equipmentId" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">设备名称：</label>
        <div class="layui-input-block" >
            <input type="text" class="layui-input" name="equipmentName" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">设备类型：</label>
        <div class="layui-input-block" >
            <input type="text" class="layui-input" name="equipTypeName" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">更新包单号：</label>
        <div class="layui-input-block" >
            <input type="text" class="layui-input" name="uploadNumber" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">升级版本号：</label>
        <div class="layui-input-block" >
            <input type="text" class="layui-input" name="version" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">接入点名称：</label>
        <div class="layui-input-block" >
            <input type="text" class="layui-input" name="accPointResName" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">版本更改人：</label>
        <div class="layui-input-block" >
            <input type="text" class="layui-input" name="createName" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">更改时间：</label>
        <div class="layui-input-block">
            <input id="versionUpdateTime" type="text" class="layui-input" name="versionUpdateTime" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item layui-hide">
        <div class="layui-inline layui-search" style="padding-left:15px">
            <button id="LAY-app-deviceUpgrade-list-search-advanced" class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-deviceUpgrade-list-search-advanced">
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

    //更改时间
    laydate.render({
        elem: "#versionUpdateTime",
        type: "date",
        trigger: "click"
    });

    //获取软件类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#deviceSoftwareType",
        dictTypeId: "DEVICE_SOFTWARE_TYPE",
    });
    form.render();


    // 文本框回车事件
    $(".layui-input").on("keydown", function(event) {
        if (event.keyCode == 13) {
            var submit = $("#LAY-app-deviceUpgrade-list-search-advanced");
            submit.click();
            return false;
        }
    });

    function SetData(data) {
        win = data.win ? data.win : window;
        var formData = data.data;
        form.val("layuiadmin-deviceUpgrade-form", {
            deviceName: formData.deviceName,
            deviceSoftwareType: formData.deviceSoftwareType,
            equipmentId: formData.equipmentId,
            equipmentName: formData.equipmentName,
            equipTypeName: formData.equipTypeName,
            uploadNumber: formData.uploadNumber,
            version: formData.version,
            accPointResName: formData.accPointResName,
            createName: formData.createName,
            versionUpdateTime: formData.versionUpdateTime ? util.toDateString(formData.versionUpdateTime, "yyyy-MM-dd") : ""
         });
    }

    function reset() {
        var formData = {
            deviceName: "",
            deviceSoftwareType: "",
            equipmentId: "",
            equipmentName: "",
            equipTypeName: "",
            uploadNumber: "",
            version: "",
            accPointResName: "",
            createName: "",
            versionUpdateTime: ""

        }
        win.setFormData(formData);
    }

    //监听提交
    form.on("submit(LAY-app-deviceUpgrade-list-search-advanced)", function(data) {
        win.setFormData(data.field);
        win.layer.closeAll("iframe");
    });
</script>
</body>
</html>