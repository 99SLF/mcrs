<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 李伟杰
  - Date: 2023-2-7 10:37:20
  - Description:
-->
<head>
    <title>设备类型高级查询</title>
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
            width: 105px !important;
            padding: 5px 0px !important;
            white-space: pre-wrap  !important;
        }
        .layui-input {
            height: 30px !important;
        }

    </style>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-equipmentType-form" id="layuiadmin-equipmentType-form">
    <fieldset class="layui-elem-field layui-field-title">
        <legend>高级搜索</legend>
    </fieldset>
    <div class="layui-form-item">
        <label class="layui-form-label">设备类型代码：</label>
        <div class="layui-input-inline">
            <input type="text" name="equipTypeCode" placeholder="" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">设备类型名称：</label>
        <div class="layui-input-inline">
            <input type="text" name="equipTypeName" placeholder="" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">启用：</label>
        <div class="layui-input-inline">
            <select name="equipTypeEnable" id="equipTypeEnable" lay-filter="equipTypeEnable"
                    type="select">
                <option value=""></option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">厂家：</label>
        <div class="layui-input-inline">
            <input type="text" name="manufacturer" placeholder="" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">控制器型号：</label>
        <div class="layui-input-inline">
            <input type="text" name="equipControllerModel" placeholder="" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">支持通信协议：</label>
        <div class="layui-input-inline">
            <input type="text" name="protocolCommunication" placeholder="" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">MES连接IP：</label>
        <div class="layui-input-inline">
            <input type="text" name="mesIpAddress" placeholder="" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">创建人：</label>
        <div class="layui-input-block" >
            <input type="text" class="layui-input" name="equipCreatorName" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">创建时间：</label>
        <div class="layui-input-block">
            <input id="createTime" type="text" class="layui-input" name="createTime" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">修改人：</label>
        <div class="layui-input-block" >
            <input type="text" class="layui-input" name="equipUpdaterName" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">修改时间：</label>
        <div class="layui-input-block">
            <input id="updateTime" type="text" class="layui-input" name="updateTime" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item layui-hide">
        <div class="layui-inline layui-search" style="padding-left:15px">
            <button id="LAY-app-equipmentType-search-advanced" class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-equipmentType-search-advanced">
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

    // 时间选择器
    laydate.render({
        elem: "#createTime",
        type: "date",
        trigger: "click"
    });
    laydate.render({
        elem: "#updateTime",
        type: "date",
        trigger: "click"
    });

    layui.admin.renderDictSelect({
        elem: "#equipTypeEnable",
        dictTypeId: "IS_USE",
    });
    form.render();




    // 文本框回车事件
    $(".layui-input").on("keydown", function(event) {
        if (event.keyCode == 13) {
            var submit = $("#LAY-app-equipmentType-search-advanced");
            submit.click();
            return false;
        }
    });

    function SetData(data) {
        win = data.win ? data.win : window;
        var formData = data.data;
        form.val("layuiadmin-equipmentType-form", {
            equipTypeCode:formData.equipTypeCode,
            equipTypeName:formData.equipTypeName,
            equipTypeEnable: formData.equipTypeEnable,
            manufacturer: formData.manufacturer,
            equipControllerModel: formData.equipControllerModel,
            protocolCommunication: formData.protocolCommunication,
            mesIpAddress:formData.mesIpAddress,
            equipCreatorName: formData.equipCreatorName,
            createTime: formData.createTime ? util.toDateString(formData.createTime, "yyyy-MM-dd") : "",
            equipUpdaterName: formData.equipUpdaterName,
            updateTime: formData.updateTime ? util.toDateString(formData.updateTime, "yyyy-MM-dd") : ""
        });
    }

    function reset() {
        var formData = {
            equipTypeCode:"",
            equipTypeName:"",
            equipTypeEnable: "",
            manufacturer: "",
            equipControllerModel: "",
            protocolCommunication: "",
            mesIpAddress: "",
            equipCreatorName: "",
            createTime: "",
            equipUpdaterName: "",
            updateTime: "",
        }
        win.setFormData(formData);
    }

    //监听提交
    form.on("submit(LAY-app-equipmentType-search-advanced)", function(data) {
        win.setFormData(data.field);
        win.layer.closeAll("iframe");
    });
</script>
</body>
</html>

