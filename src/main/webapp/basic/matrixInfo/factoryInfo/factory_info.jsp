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
  - Date: 2023-1-28 21:13:14
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>当前基地信息详情</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <style>
        .layui-form-label {
            width: 120px;
        }

        .layui-input-block {
            margin-left: 150px;
            min-height: 30px
        }
        .layui-textarea{
            height: 5px!important;
            /*min-height: 60px!important;*/
        }
    </style>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">工厂代码:</label>
            <div class="layui-input-block">
                <input id="factoryCode" type="text" name="factoryCode" lay-verify="required|factoryCode" placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">工厂名称:</label>
            <div class="layui-input-block">
                <input id="factoryName" type="text" name="factoryName" lay-verify="" placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm12">
            <label class="layui-form-label">工厂地址:</label>
            <div class="layui-input-block">
                <textarea  name="factoryAddress" id="factoryAddress" autocomplete="off" class="layui-textarea" lay-verify="factoryAddress" readonly></textarea>
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
    var nodeId = "<%=request.getParameter("realId")%>";//url数值类型不需要双引号，字符串类型需要双引号
    //通过当前的id查询出当前树节点的详细工厂信息
    $.ajax({
        url: "<%= request.getContextPath() %>/FactoryController/exactQuery?nodeId=" + nodeId,
        dataType: "json",
        type: "get",
        success: function (data) { //注意后端代码返回数据key值必须同名 为data
            var dataD = data.data;
            var factoryCode = dataD[0].factoryCode;
            var factoryName = dataD[0].factoryName;
            var factoryAddress = dataD[0].factoryAddress;
            $("#factoryCode").val(factoryCode);
            $("#factoryName").val(factoryName);
            $("#factoryAddress").val(factoryAddress);
            form.render();
        }
    })

</script>
</body>
</html>
