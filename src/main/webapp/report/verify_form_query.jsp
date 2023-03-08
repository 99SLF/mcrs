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
    <title>防止串读记录表高级查询</title>
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
<div class="layui-form" lay-filter="layuiadmin-verify-form" id="layuiadmin-verify-form">
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
        <label class="layui-form-label">轴名称：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="axisName" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">读写器ID：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="rfidReader" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">天线编码：</label>
        <div class="layui-input-block" >
            <input type="text" class="layui-input" name="antenna" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">已读取标签值：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="processLot" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">替换的标签值：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="tag" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">读取到的次数：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="readNum" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">生产SFC：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="sfcPre" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">拆分后SFC：</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="sfc" autocomplete="off" />
        </div>
    </div>
    <div class="layui-form-item layui-hide">
        <div class="layui-inline layui-search" style="padding-left:15px">
            <button id="LAY-app-verify-search-advanced" class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-verify-search-advanced">
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
            var submit = $("#LAY-app-verify-search-advanced");
            submit.click();
            return false;
        }
    });

    function SetData(data) {
        win = data.win ? data.win : window;
        var formData = data.data;
        form.val("layuiadmin-verify-form", {
            resource: formData.resource,
            axisName: formData.axisName,
            rfidReader: formData.rfidReader,
            antenna: formData.antenna,
            processLot: formData.processLot,
            tag: formData.tag,
            readNum: formData.readNum,
            sfcPre: formData.sfcPre,
            sfc: formData.sfc,
            UPDATED_TIME: formData.UPDATED_TIME,


        });
    }

    function reset() {
        var formData = {
            esource: "",
            axisName: "",
            rfidReader: "",
            antenna: "",
            processLot: "",
            tag: "",
            readNum: "",
            sfcPre: "",
            sfc: "",
            UPDATED_TIME: ""
        }
        win.setFormData(formData);
    }

    //监听提交
    form.on("submit(LAY-app-verify-search-advanced)", function(data) {
        var rels = data.field;
        win.setFormData(rels);
        win.layer.closeAll("iframe");
    });
</script>
</body>
</html>