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
  - Date: 2023-1-4 09:48:14
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>日志删除规则详情</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <input id="ruleDeleteId" name="ruleDeleteId" type="hidden"/>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">日志删除规则标题:</label>
            <div class="layui-input-block">
                <input id="deleteRuleTitle" type="text" name="deleteRuleTitle" lay-verify="required|deleteRuleTitle"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">日志删除规则类型:</label>
            <div class="layui-input-block">
                <select name="deleteRuleType" id="deleteRuleType" lay-filter="required" lay-verify="required" type="select" >
                    <option value="" ></option>
                </select>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">保留时间数:</label>
            <div class="layui-input-block">
                <input id="retentionTime" type="text" name="retentionTime" lay-verify="required"
                       placeholder=""
                       autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">时间单位:</label>
            <div class="layui-input-block">
                <select name="timeUnit" id="timeUnit" lay-filter="required" lay-verify="required" type="select" >
                    <option value=""></option>
                </select>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">启用：</label>
            <div class="layui-input-block">
                <select name="enable" id="enable" lay-filter="" lay-verify="required" type="select" >
                    <option value=""></option>
                </select>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">日志类型:</label>
            <div class="layui-input-block">
                <select name="logType" id="logType" lay-filter="" lay-verify="required" type="select" >
                    <option value="" ></option>
                </select >
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">修改人：</label>
            <div class="layui-input-block">
                <input id="creator" type="text" name="updateName" lay-verify="required"
                       placeholder=""
                       autocomplete="off" class="layui-input"readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">修改时间:</label>
            <div class="layui-input-block">
                <input id="createTime" type="text" name="updateTime" lay-verify="required"
                       placeholder=""
                       autocomplete="off" class="layui-input" readonly>
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

    //禁用规则级别下拉选择框
    layui.use('form', function(){
        var form = layui.form;
        $("#ruleLevel").attr("disabled","disabled");
        form.render('select');
    });

    //禁用日志删除规则类型下拉选择框
    layui.use('form', function(){
        var form = layui.form;
        $("#deleteRuleType").attr("disabled","disabled");
        form.render('select');
    });

    //禁用时间单位下拉选择框
    layui.use('form', function(){
        var form = layui.form;
        $("#timeUnit").attr("disabled","disabled");
        form.render('select');
    });

    //禁用是否启用下拉选择框
    layui.use('form', function(){
        var form = layui.form;
        $("#enable").attr("disabled","disabled");
        form.render('select');
    });

    //禁用日志类型下拉选择框
    layui.use('form', function(){
        var form = layui.form;
        $("#logType").attr("disabled","disabled");
        form.render('select');
    });

    //获取日志删除规则类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#deleteRuleType",
        dictTypeId: "LOG_DELETE_RULE_TYPE",
    });
    form.render();

    //获取时间单位的下拉值
    layui.admin.renderDictSelect({
        elem: "#timeUnit",
        dictTypeId: "TIME_UNIT",
    });
    form.render();

    //获取日志类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#logType",
        dictTypeId: "LOG_TYPE",
    });
    form.render();

    //获取规则级别类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#ruleLevel",
        dictTypeId: "WARNING_LEVEL",
    });
    form.render();

    //获取启用类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#enable",
        dictTypeId: "IS_USE",
    });
    form.render();



    form.render();
    function SetData(data) {
        win = data.win ? data.win : window;
        var data = data.data;
        form.val("layuiadmin-app-form-list", {
            //要有主键
            "deleteRuleTitle": data.deleteRuleTitle,
            "logType": data.logType,
            "enable": data.enable,
            "deleteRuleType": data.deleteRuleType,
            "retentionTime": data.retentionTime,
            "timeUnit": data.timeUnit,
            "updateName": data.updateName,
            "updateTime": data.updateTime,
        });
    }

    form.render();

</script>
</body>
</html>