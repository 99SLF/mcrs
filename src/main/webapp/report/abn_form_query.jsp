<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 李伟杰
  - Date: 2023-1-30 8:57:33
  - Description:
-->
<head>
    <title>生产过程异常高级查询</title>
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
<div class="layui-form" lay-filter="layuiadmin-abn-form" id="layuiadmin-abn-form">
    <fieldset class="layui-elem-field layui-field-title">
        <legend>高级搜索</legend>
    </fieldset>
    <div class="layui-form-item">
        <label class="layui-form-label">站点号：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="siteId" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">膜卷号：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="rollId" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">设备资源号：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="equipmentId" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">轴名称：</label>
        <div class="layui-input-block" >
            <input type="text" class="layui-input" name="axisName" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">载具码：</label>
        <div class="layui-input-block" >
            <input type="text" class="layui-input" name="vehicleCode" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">生产SFC编码：</label>
        <div class="layui-input-block" >
            <input type="text" class="layui-input" name="prodSFCId" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">完工：</label>
        <div class="layui-input-block" >
            <select name="isEnd" id="isEnd" lay-filter="isEnd" type="select">
                <option value=""></option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">更新时间：</label>
        <div class="layui-input-block">
            <input id="updateTime" type="text" class="layui-input" name="updateTime" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item layui-hide">
        <div class="layui-inline layui-search" style="padding-left:15px">
            <button id="LAY-app-abn-search-advanced" class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-abn-search-advanced">
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

    // 更新时间选择器
    laydate.render({
        elem: "#updateTime",
        type: "date",
        trigger: "click"
    });

    layui.admin.renderDictSelect({
        elem: "#isEnd",
        dictTypeId: "IS_END",
    });
    form.render();

    // 文本框回车事件
    $(".layui-input").on("keydown", function(event) {
        if (event.keyCode == 13) {
            var submit = $("#LAY-app-abn-search-advanced");
            submit.click();
            return false;
        }
    });

    function SetData(data) {
        win = data.win ? data.win : window;
        var formData = data.data;
        form.val("layuiadmin-abn-form", {
            siteId: formData.siteId,
            rollId: formData.rollId,
            equipmentId: formData.equipmentId,
            axisName: formData.axisName,
            vehicleCode: formData.vehicleCode,
            prodSFCId: formData.prodSFCId,
            isEnd:formData.isEnd,
            updateTime: formData.updateTime ? util.toDateString(formData.updateTime, "yyyy-MM-dd") : ""
        });
    }

    function reset() {
        var formData = {
            siteId: "",
            rollId: "",
            equipmentId: "",
            axisName: "",
            vehicleCode: "",
            prodSFCId: "",
            isEnd: "",
            updateTime: ""
        }
        win.setFormData(formData);
    }

    //监听提交
    form.on("submit(LAY-app-abn-search-advanced)", function(data) {
        win.setFormData(data.field);
        win.layer.closeAll("iframe");
    });
</script>
</body>
</html>