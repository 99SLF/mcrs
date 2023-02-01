<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 林俊杰
  - Date: 2023-02-01 15:02:21
  - Description:
-->
<head>
    <title>RFID交互日志高级查询</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
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
<div class="layui-form" lay-filter="layuiadmin-rfidLog-form" id="layuiadmin-rfidLog-form">
    <fieldset class="layui-elem-field layui-field-title">
        <legend>高级搜索</legend>
    </fieldset>
    <div class="layui-form-item">
        <label class="layui-form-label">设备资源号：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="equipmentId" autocomplete="off"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">设备名称：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="equipmentName" autocomplete="off"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">终端名称：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="deviceName" autocomplete="off"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">RFID-ID：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="rfidId" autocomplete="off"/>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">参数名称：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="parameterName" autocomplete="off"/>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">创建人：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="createName" autocomplete="off"/>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">创建时间：</label>
        <div class="layui-input-block">
            <input id="createTime" type="text" class="layui-input" name="createTime" autocomplete="off"/>
        </div>
    </div>
    <div class="layui-form-item layui-hide">
        <div class="layui-inline layui-search" style="padding-left:15px">
            <button id="LAY-app-rfidLog-search-advanced" class="layui-btn layuiadmin-btn-list" lay-submit
                    lay-filter="LAY-app-rfidLog-search-advanced">
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

    // 创建时间选择器
    laydate.render({
        elem: "#createTime",
        type: "date",
        trigger: "click"
    });


    // 文本框回车事件
    $(".layui-input").on("keydown", function (event) {
        if (event.keyCode == 13) {
            var submit = $("#LAY-app-rfidLog-search-advanced");
            submit.click();
            return false;
        }
    });

    function SetData(data) {
        win = data.win ? data.win : window;
        var formData = data.data;
        form.val("layuiadmin-rfidLog-form", {
            equipmentId: formData.equipmentId,
            equipmentName: formData.equipmentName,
            deviceName: formData.deviceName,
            rfidId: formData.rfidId,
            parameterName: formData.parameterName,
            createName: formData.createName,
            createTime: formData.createTime ? util.toDateString(formData.createTime, "yyyy-MM-dd") : ""
        });
    }

    function reset() {
        var formData = {
            equipmentId: "",
            equipmentName: "",
            deviceName: "",
            rfidId: "",
            parameterName: "",
            createName: "",
            endProdTime: ""
        }
        win.setFormData(formData);
    }

    //监听提交
    form.on("submit(LAY-app-rfidLog-search-advanced)", function (data) {
        win.setFormData(data.field);
        win.layer.closeAll("iframe");
    });
</script>
</body>
</html>