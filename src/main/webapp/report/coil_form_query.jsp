<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 李伟杰
  - Date: 2023-03-08 10:01:25
  - Description:
-->
<head>
    <title>上下料卷径报表高级查询</title>
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
<div class="layui-form" lay-filter="layuiadmin-coil-form" id="layuiadmin-coil-form">
    <fieldset class="layui-elem-field layui-field-title">
        <legend>高级搜索</legend>
    </fieldset>
    <div class="layui-form-item">
        <label class="layui-form-label">设备资源号：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="resource" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">放卷SFC：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="sfcPreData" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">放卷卷径：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="uDiamRealityValue" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">收卷轴名称：</label>
        <div class="layui-input-block" >
            <input type="text" class="layui-input" name="rAxisName" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">收卷载具号：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="rProcessLotPre" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">收卷SFC：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="sfcData" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">收卷卷径：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="rDiamRealityValue" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">是否最后一卷：</label>
        <div class="layui-input-block" >
            <select name="isLastVolume" id="isLastVolume" lay-filter="isLastVolume" type="select">
                <option value="0">否</option>
                <option value="1">是</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">放卷物料是否消耗完成：</label>
        <div class="layui-input-block" >
            <select name="unwindIsOver" id="unwindIsOver" lay-filter="unwindIsOver" type="select">
                <option value="0">否</option>
                <option value="1">是</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item layui-hide">
        <div class="layui-inline layui-search" style="padding-left:15px">
            <button id="LAY-app-coil-search-advanced" class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-coil-search-advanced">
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

    // 文本框回车事件
    $(".layui-input").on("keydown", function(event) {
        if (event.keyCode == 13) {
            var submit = $("#LAY-app-coil-search-advanced");
            submit.click();
            return false;
        }
    });

    function SetData(data) {
        win = data.win ? data.win : window;
        var formData = data.data;
        form.val("layuiadmin-coil-form", {
            resource: formData.resource,
            sfcPreData: formData.sfcPreData,
            uDiamRealityValue: formData.uDiamRealityValue,
            rAxisName: formData.rAxisName,
            rProcessLotPre: formData.rProcessLotPre,
            sfcData: formData.sfcData,
            rDiamRealityValue: formData.rDiamRealityValue,
            isLastVolume: formData.isLastVolume,
            unwindIsOver: formData.unwindIsOver,
            UPDATED_TIME: formData.UPDATED_TIME,


        });
    }

    function reset() {
        var formData = {
            resource: "",
            sfcPreData: "",
            uDiamRealityValue: "",
            rAxisName: "",
            rProcessLotPre: "",
            sfcData: "",
            rDiamRealityValue: "",
            isLastVolume: "",
            unwindIsOver: "",
            UPDATED_TIME: ""
        }
        win.setFormData(formData);
    }

    //监听提交
    form.on("submit(LAY-app-coil-search-advanced)", function(data) {
        var rels = data.field;
        win.setFormData(rels);
        win.layer.closeAll("iframe");
    });
</script>
</body>
</html>