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
  - Date: 2022-12-21 16:13:14
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>设备类型信息维护编辑</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <input id="equipTypeId" name="equipTypeId" type="hidden" />
    <div class="layui-form-item layui-row layui-col-space10">

        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>设备类型代码:</label>
            <div class="layui-input-block">
                <input id="equipTypeCode" type="text" name="equipTypeCode" lay-verify="required|equipTypeCode"
                       placeholder=" " autocomplete="off" class="layui-input" readonly >
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>厂家:</label>
            <div class="layui-input-block">
                <input id="manufacturer" type="text" name="manufacturer" lay-verify="required|manufacturer"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">

        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>是否启用:</label>
            <div class="layui-input-block">
                <select name="equipTypeEnable" id="equipTypeEnable" lay-filter="required" type="select" disabled>
                    <option value="on">是</option>
                    <option value="off">否</option>
                </select>
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>设备类型名称:</label>
            <div class="layui-input-block">
                <input id="equipTypeName" type="text" name="equipTypeName" lay-verify="required|equipTypeName"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">

        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>使用控制器型号:</label>
            <div class="layui-input-block">
                <input id="equipControllerModel" type="text" name="equipControllerModel"
                       lay-verify="required|equipControllerModel"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>支持通信协议:</label>
            <div class="layui-input-block">
                <input id="protocolCommunication" type="text" name="protocolCommunication"
                       lay-verify="required|protocolCommunication"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>MES连接IP地址：</label>
            <div class="layui-input-block">
                <input id="mesIpAddress" type="text" name="mesIpAddress" lay-verify="required|mesIpAddress"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm12">
            <label class="layui-form-label">备注:</label>
            <div class="layui-input-block">
            <textarea cols="50" rows="10" style="width:100%;height:100px" name="remarks" id="remarks" autocomplete="off"
                      class="layui-input" lay-verify="remarks" readonly></textarea>
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
    function SetData(data) {
        win = data.win ? data.win : window;
        var data = data.data;
        form.val("layuiadmin-app-form-list", {
            //要有主键不然修改不了
            "equipTypeId": data.equipTypeId,
            "equipTypeCode": data.equipTypeCode,
            "manufacturer": data.manufacturer,
            "equipTypeEnable": data.equipTypeEnable,
            "equipTypeName": data.equipTypeName,
            "equipControllerModel": data.equipControllerModel,
            "protocolCommunication": data.protocolCommunication,
            "mesIpAddress": data.mesIpAddress,
            "remarks": data.remarks,
        });
    }
    form.render();

</script>
</body>
</html>