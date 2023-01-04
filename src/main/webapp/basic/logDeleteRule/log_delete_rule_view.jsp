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
            <label class="layui-form-label"><span style="color:red">*</span>日志删除规则编码:</label>
            <div class="layui-input-block">
                <input id="deleteRuleNum" type="text" name="deleteRuleNum" lay-verify="required|deleteRuleNum"
                       placeholder="日志删除规则编码(必填)" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>日志删除规则标题:</label>
            <div class="layui-input-block">
                <input id="deleteRuleTitle" type="text" name="deleteRuleTitle" lay-verify="required|deleteRuleTitle"
                       placeholder="请输入日志删除规则标题" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>规则级别:</label>
            <div class="layui-input-block">
                <select name="ruleLevel" id="ruleLevel" lay-filter=""lay-verify="required" type="select" >
                    <option value="1级">1级</option>
                    <option value="2级">2级</option>
                    <option value="3级">3级</option>
                    <option value="4级">4级</option>
                    <option value="5级">5级</option>
                </select>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>日志删除规则类型:</label>
            <div class="layui-input-block">
                <select name="deleteRuleType" id="deleteRuleType" lay-filter="required" lay-verify="required" type="select" >
                    <option value="" ></option>
                </select>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>时间间隔:</label>
            <div class="layui-input-block">
                <input id="timeInterval" type="text" name="timeInterval" lay-verify="required"
                       placeholder="请输入时间间隔"
                       autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>时间单位:</label>
            <div class="layui-input-block">
                <select name="timeUnit" id="timeUnit" lay-filter="required" lay-verify="required" type="select" >
                    <option value=""></option>
                </select>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>是否启用：</label>
            <div class="layui-input-block">
                <select name="enable" id="enable" lay-filter="" lay-verify="required" type="select" >
                    <option value="on">是</option>
                    <option value="off">否</option>
                </select>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>日志类型:</label>
            <div class="layui-input-block">
                <select name="logType" id="logType" lay-filter="" lay-verify="required" type="select" >
                    <option value="" ></option>
                </select >
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>创建人：</label>
            <div class="layui-input-block">
                <input id="creator" type="text" name="creator" lay-verify="required"
                       placeholder=""
                       autocomplete="off" class="layui-input"readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>创建时间:</label>
            <div class="layui-input-block">
                <input id="createTime" type="text" name="createTime" lay-verify="required"
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

    form.render();
    function SetData(data) {
        win = data.win ? data.win : window;
        var data = data.data;
        form.val("layuiadmin-app-form-list", {
            //要有主键
            "ruleDeleteId": data.ruleDeleteId,
            "deleteRuleNum": data.deleteRuleNum,
            "deleteRuleTitle": data.deleteRuleTitle,
            "logType": data.logType,
            "enable": data.enable,
            "ruleLevel": data.ruleLevel,
            "deleteRuleType": data.deleteRuleType,
            "timeInterval": data.timeInterval,
            "timeUnit": data.timeUnit,
            "creator": data.creator,
            "createTime": data.createTime,
        });
    }

    form.render();

</script>
</body>
</html>