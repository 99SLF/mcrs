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
    <title>接入点信息维护详情</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <input id="accPointResId" name="accPointResId" type="hidden" />
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">接入点名称:</label>
            <div class="layui-input-block">
                <input id="accPointResName" type="text" name="accPointResName" lay-verify="required|accPointResName" placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label">接入点代码:</label>
            <div class="layui-input-block">
                <input id="accPointResCode" type="text" name="accPointResCode" lay-verify="required|accPointResCode" placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">是否启用:</label>
            <div class="layui-input-block">
                <input id="isEnable" type="text" name="isEnable" lay-verify="required|isEnable" lay-filter="isEnable" placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">基地代码:</label>
            <div class="layui-input-block">
                <input id="matrixCode" type="text" name="matrixCode" lay-verify="required|matrixCode" placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">基地名称:</label>
            <div class="layui-input-block">
                <input id="matrixName" type="text" name="matrixName" lay-verify="" placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

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
                <input id="factoryName" type="text" name="factoryName" lay-verify="required|factoryName" placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">工序代码：</label>
            <div class="layui-input-block">
                <input id="processCode" type="text" name="processCode" lay-verify="required|processCode" placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label">工序名称：</label>
            <div class="layui-input-block">
                <input id="processName" type="text" name="processName" lay-verify="required|processName" placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm12">
            <label class="layui-form-label">工序描述:</label>
            <div class="layui-input-block">
            <textarea cols="50" rows="10" style="width:100%;height:100px" name="processRemarks" id="processRemarks" autocomplete="off" class="layui-input" lay-verify="processRemarks" readonly></textarea>
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

    //数据字典项加载
    form.render();
    function SetData(data) {
        win = data.win ? data.win : window;
        var data = data.data;
        form.val("layuiadmin-app-form-list", {
            //要有主键
            "accPointResId": data.accPointResId,
            "accPointResName": data.accPointResName,
            "accPointResCode": data.accPointResCode,
            "isEnable":  layui.admin.getDictText("IS_USE", data.isEnable),
            "matrixCode": data.matrixCode,
            "matrixName": data.matrixName,
            "factoryCode": data.factoryCode,
            "factoryName": data.factoryName,
            "processCode": data.processCode,
            "processName": data.processName,
            "processRemarks": data.processRemarks,
        });
    }
    form.render();

</script>
</body>
</html>