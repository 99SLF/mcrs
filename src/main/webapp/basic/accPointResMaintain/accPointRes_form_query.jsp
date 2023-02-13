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
    <title>接入点高级查询</title>
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
<div class="layui-form" lay-filter="layuiadmin-accPoint-form" id="layuiadmin-accPoint-form">
    <fieldset class="layui-elem-field layui-field-title">
        <legend>高级搜索</legend>
    </fieldset>
    <div class="layui-form-item">
        <label class="layui-form-label">接入点代码：</label>
        <div class="layui-input-inline">
            <input type="text" name="accPointResCode" placeholder="" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">接入点名称：</label>
        <div class="layui-input-inline">
            <input type="text" name="accPointResName" placeholder="" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">启用：</label>
        <div class="layui-input-inline">
            <select name="isEnable" id="isEnable" lay-filter="isEnable"
                    type="select">
                <option value=""></option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">基地代码：</label>
        <div class="layui-input-inline">
            <input type="text" name="matrixCode" placeholder="" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">工厂代码：</label>
        <div class="layui-input-inline">
            <input type="text" name="factoryCode" placeholder="" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">创建人：</label>
        <div class="layui-input-block" >
            <input type="text" class="layui-input" name="accCreatorName" autocomplete="off" />
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
            <input type="text" class="layui-input" name="accUpdaterName" autocomplete="off" />
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
            <button id="LAY-app-accPoint-search-advanced" class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-accPoint-search-advanced">
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
        elem: "#isEnable",
        dictTypeId: "IS_USE",
    });
    form.render();




    // 文本框回车事件
    $(".layui-input").on("keydown", function(event) {
        if (event.keyCode == 13) {
            var submit = $("#LAY-app-accPoint-search-advanced");
            submit.click();
            return false;
        }
    });

    function SetData(data) {
        win = data.win ? data.win : window;
        var formData = data.data;
        form.val("layuiadmin-accPoint-form", {
            accPointResCode:formData.accPointResCode,
            accPointResName: formData.accPointResName,
            isEnable: formData.isEnable,
            matrixCode: formData.matrixCode,
            factoryCode: formData.factoryCode,
            accCreatorName: formData.accCreatorName,
            createTime: formData.createTime ? util.toDateString(formData.createTime, "yyyy-MM-dd") : "",
            accUpdaterName: formData.accUpdaterName,
            updateTime: formData.updateTime ? util.toDateString(formData.updateTime, "yyyy-MM-dd") : ""
        });
    }

    function reset() {
        var formData = {
            accPointResCode:"",
            accPointResName: "",
            isEnable: "",
            matrixCode: "",
            factoryCode: "",
            accCreatorName: "",
            createTime: "",
            accUpdaterName: "",
            updateTime: "",
        }
        win.setFormData(formData);
    }

    //监听提交
    form.on("submit(LAY-app-accPoint-search-advanced)", function(data) {
        win.setFormData(data.field);
        win.layer.closeAll("iframe");
    });
</script>
</body>
</html>

