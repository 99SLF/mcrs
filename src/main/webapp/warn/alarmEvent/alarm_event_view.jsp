<%@ page import="com.zimax.cap.party.IUserObject" %>
<%@ page import="com.zimax.cap.datacontext.DataContextManager" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 林俊杰
  - Date: 2023-1-6 15:14:37
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>预警事件详情</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <div class="layui-form-item layui-row layui-col-space10">
        <%--隐藏主键--%>
        <input type="hidden" name="alarmEventInt" value="default">
        <div class="layui-col-sm6">
            <label class="layui-form-label">预警事件编码:</label>
            <div class="layui-input-block">
                <input id="alarmEventId" type="text" name="alarmEventId" lay-verify="required"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">预警事件标题:</label>
            <div class="layui-input-block">
                <input id="alarmEventTitle" type="text" name="alarmEventTitle" lay-verify=""
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">预警级别:</label>
            <div class="layui-input-block">
                <select name="alarmLevel" id="alarmLevel" lay-filter="required" type="select">
                    <option value=""></option>
                </select>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">预警类型:</label>
            <div class="layui-input-block">
                <select name="alarmType" id="alarmType" lay-filter="" type="select">
                    <option value=""></option>
                </select>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">上限:</label>
            <div class="layui-input-block">
                <input id="upperLimit" type="text" name="upperLimit" lay-verify="required"
                       placeholder="请输入上限" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label">下限:</label>
            <div class="layui-input-block">
                <input id="lowerLimit" type="text" name="lowerLimit" lay-verify="required" placeholder="请输入下限"
                       autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">启用：</label>
            <div class="layui-input-block">
                <select name="enableStatus" id="enableStatus" lay-filter="" type="select">
                    <option value=""></option>
                </select>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm12">
            <label class="layui-form-label">内容:</label>
            <div class="layui-input-block">
            <textarea cols="50" rows="10" style="width:100%;height:100px" name="alarmEventContent"
                      id="alarmEventContent" autocomplete="off"
                      class="layui-input" lay-verify="" readonly></textarea>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">制单人:</label>
            <div class="layui-input-block">
                <input id="createName" type="text" name="createName" lay-verify="required"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label">制单时间:</label>
            <div class="layui-input-block">
                <input id="makeFormTime" type="text" name="makeFormTime" lay-verify="required"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">修改人:</label>
            <div class="layui-input-block">
                <input id="updateName" type="text" name="updateName" lay-verify="required"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label">修改时间:</label>
            <div class="layui-input-block">
                <input id="updateTime" type="text" name="updateTime" lay-verify="required"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
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

    //禁用启用下拉选择框
    layui.use('form', function(){
        var form = layui.form;
        $("#enableStatus").attr("disabled","disabled");
        form.render('select');
    });
    //禁用预警级别下拉选择框
    layui.use('form', function(){
        var form = layui.form;
        $("#alarmLevel").attr("disabled","disabled");
        form.render('select');
    });
    //禁用预警类型下拉选择框
    layui.use('form', function(){
        var form = layui.form;
        $("#alarmType").attr("disabled","disabled");
        form.render('select');
    });
    //获取预警类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#alarmType",
        dictTypeId: "WRANING_TYPE",
    });
    form.render();

    //获取预警级别的下拉值
    layui.admin.renderDictSelect({
        elem: "#alarmLevel",
        dictTypeId: "WARNING_LEVEL",
    });
    form.render();

    //获取接入方式的下拉值
    layui.admin.renderDictSelect({
        elem: "#accessMethod",
        dictTypeId: "ACCESS_METHOD",
    });
    form.render();

    //获取软件类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#deviceSoftwareType",
        dictTypeId: "DEVICE_SOFTWARE_TYPE",
    });
    form.render();

    //获取启用的下拉值
    layui.admin.renderDictSelect({
        elem: "#enableStatus",
        dictTypeId: "IS_USE",
    });


    function SetData(data) {
        win = data.win ? data.win : window;
        var data = data.data;
        if (data.updateTime==null || data.updateTime ==''){
            form.val("layuiadmin-app-form-list", {
                "updateTime": data.updateTime,
            });
        }else {
            form.val("layuiadmin-app-form-list", {
                "updateTime": layui.util.toDateString(data.updateTime),
            });
        }
        form.val("layuiadmin-app-form-list", {
            //需要传入主键
            "alarmEventInt": data.alarmEventInt,
            "alarmEventId": data.alarmEventId,
            "alarmEventTitle": data.alarmEventTitle,
            "enableStatus": data.enableStatus,
            "alarmLevel": data.alarmLevel,
            "alarmEventContent": data.alarmEventContent,
            "upperLimit": data.upperLimit,
            "lowerLimit": data.lowerLimit,
            "alarmType": data.alarmType,
            "createName": data.createName,
            "makeFormTime": layui.util.toDateString(data.makeFormTime),
            "updateName": data.updateName,
        });
    }

    form.render();

</script>
</body>
</html>