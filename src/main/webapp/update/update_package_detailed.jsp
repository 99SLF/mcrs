<%@ page import="com.zimax.cap.party.IUserObject" %>
<%@ page import="com.zimax.cap.datacontext.DataContextManager" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 李伟杰
  - Date: 2022-12-0 09:13:14
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>设备类型信息维护详情</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <style>
        .layui-form-label {
            width: 120px;
        }

        .layui-input-block {
            margin-left: 150px;
            min-height: 36px;

        }
    </style>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <input id="uploadId" name="uploadId" type="hidden"/>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">更新包单号:</label>
            <div class="layui-input-block">
                <input id="uploadNumber" type="text" name="uploadNumber" lay-verify="required|uploadNumber"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label">版本号:</label>
            <div class="layui-input-block">
                <input id="version" type="text" name="version" lay-verify="required|version"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">终端软件类型:</label>
            <div class="layui-input-block">
                <input id="deviceSoType" type="text" name="deviceSoType" lay-verify="required|deviceSoType"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label">更新策略:</label>
            <div class="layui-input-block">
                <input id="uploadStrategy" type="text" name="uploadStrategy"
                       lay-verify="required|uploadStrategy"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">更新包名称:</label>
            <div class="layui-input-block">
                <input id="fileName" type="text" name="fileName" lay-verify="" placeholder="" autocomplete="off"
                       class="layui-input" readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-form-item layui-row layui-col-space10">
            <label class="layui-form-label">备注：</label>
            <div class="layui-input-block">
                <textarea class="layui-textarea field-effect field-content" name="remarks" id="remarks"
                          autocomplete="off" placeholder="" lay-verify="remarks"></textarea>
            </div>
        </div>
    </div>

</div>
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script>
    layui.config({
        base: "<%=request.getContextPath()%>/"
    });
</script>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
<script type="text/javascript">
    var layer = layui.layer;
    var form = layui.form;
    var laydate = layui.laydate;
    var $ = layui.jquery;
    var isExist = false;
    var submit = false;

    var win = null;
    layui.admin.renderDictSelect({
        elem: "#uploadStrategy",
        dictTypeId: "UPDATESTRATEGY"
    });

    layui.admin.renderDictSelect({    //获取终端软件类型
        elem: "#deviceSoType",
        dictTypeId: "DEVICE_SOFTWARE_TYPE",
    });

    form.render();
    function SetData(data) {
        win = data.win ? data.win : window;
        var data = data.data;
        form.val("layuiadmin-app-form-list", {
            //要有主键
            "uploadId": data.uploadId,
            "uploadNumber": data.uploadNumber,
            "version": data.version,
            "deviceSoType": layui.admin.getDictText("DEVICE_SOFTWARE_TYPE", data.deviceSoType),
            "uploadStrategy": layui.admin.getDictText("UPDATESTRATEGY", data.uploadStrategy),
            "fileName": data.fileName,
            "remarks": data.remarks,
        });
    }

    form.render();

</script>
</body>
</html>