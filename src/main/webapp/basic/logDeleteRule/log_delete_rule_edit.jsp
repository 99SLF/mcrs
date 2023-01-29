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
  - Date: 2022-12-01 16:06:00
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>日志删除规则修改</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/common/layui/css/layui.css">
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <div class="layui-form-item layui-row layui-col-space10">
        <%--隐藏主键--%>
        <input type="hidden" name="ruleDeleteId" value="default">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>日志删除规则标题:</label>
            <div class="layui-input-block">
                <input id="deleteRuleTitle" type="text" name="deleteRuleTitle" lay-verify="required|deleteRuleTitle"
                       placeholder="请输入日志删除规则标题" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>日志删除规则类型:</label>
            <div class="layui-input-block">
                <select name="deleteRuleType" id="deleteRuleType" lay-filter="required" lay-verify="required"
                        type="select">
                    <option value=""></option>
                </select>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>保留时间数:</label>
            <div class="layui-input-block">
                <input id="retentionTime" type="text" name="retentionTime" lay-verify="required|number"
                       placeholder="请输入保留时间"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>时间单位:</label>
            <div class="layui-input-block">
                <select name="timeUnit" id="timeUnit" lay-filter="required" lay-verify="required" type="select">
                    <option value=""></option>
                </select>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>是否启用：</label>
            <div class="layui-input-block">
                <select name="enable" id="enable" lay-filter="enable" lay-verify="required" type="select">
                    <option value=""></option>
                </select>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>日志类型:</label>
            <div class="layui-input-block">
                <select name="logType" id="logType" lay-filter="" lay-verify="required" type="select">
                    <option value=""></option>
                </select>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-hide">
        <input type="button" lay-submit lay-filter="layuiadmin-app-form-edit" id="layuiadmin-app-form-edit"
               value="确认修改">
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
            "ruleDeleteId": data.ruleDeleteId,
            "deleteRuleNum": data.deleteRuleNum,
            "deleteRuleTitle": data.deleteRuleTitle,
            "logType": data.logType,
            "enable": data.enable,
            "ruleLevel": data.ruleLevel,
            "deleteRuleType": data.deleteRuleType,
            "timeInterval": data.timeInterval,
            "timeUnit": data.timeUnit,
        });
    }

    //禁用日志类型下拉选择框
    layui.use('form', function () {
        var form = layui.form;
        $("#logType").attr("disabled", "disabled");
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


    //获取启用类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#enable",
        dictTypeId: "IS_USE",
    });
    form.render();

    //获取级别的下拉值
    layui.admin.renderDictSelect({
        elem: "#ruleLevel",
        dictTypeId: "WARNING_LEVEL",
    });
    //设置级别的默认值
    $("#ruleLevel").val("101");
    form.render();


    // //判断字符
    // form.verify({
    // 	username: function(value, item) {
    // 		if (value.length > 10) {
    // 			return "学生名不能超过10字";
    // 		}
    // 	},
    // 	age: function(value, item) {
    // 		if (value <= 0||value >=150) {
    // 			return "请输入正确的年龄";
    // 		}
    // 	},
    // 	teachr: function(value, item) {
    // 		if (value.length > 10) {
    // 			return "教师名不能超过10字";
    // 		}
    // 	}
    // });

    form.render();
    // //日期
    // laydate.render({
    // 	elem: '#invaldate',
    // 	format: 'yyyy-MM-dd',
    // 	//解决时间选择器一闪而过的情况
    // 	trigger: 'click',
    // });
    //
    // var startDate = laydate.render({
    // 	elem: '#star_time',
    // 	//设置日期的类型
    // 	type: 'date',
    // 	trigger:'click',
    // 	done: function(value, date) {
    // 		if (value != "") {
    // 			date.month = date.month - 1;
    // 			date.date = date.date + 1;
    // 			endDate.config.min = date;
    // 		} else {
    // 			endDate.config.min = startDate.config.min;
    // 		}
    // 	},
    // });
    //
    // var endDate = laydate.render({
    // 	//绑定的控件名称
    // 	elem: '#end_time',
    // 	//设置日期的类型
    // 	type: 'date',
    // 	//theme: '#2c78da',
    // 	trigger: 'click',
    // 	done: function(value, date) {
    // 		if (value != "") {
    // 			date.month = date.month - 1;
    // 			date.date = date.date - 1;
    // 			startDate.config.max = date;
    // 		} else {
    // 			startDate.config.max = endDate.config.max;
    // 		}
    // 	}
    // });

    //监听提交
    form.on("submit(layuiadmin-app-form-edit)", function (data) {
        var submitData = JSON.stringify(data.field);
        if (submit == false) {
            submit = true;
            if (isExist == false) {
                $.ajax({
                    url: "<%= request.getContextPath() %>/logDeleteRule/logDeleteRule/update",
                    type: "POST",
                    data: submitData,
                    cache: false,
                    contentType: "text/json",
                    success: function (result) {
                        layer.msg("修改成功", {
                            icon: 1,
                            time: 500
                        }, function () {
                            var index = parent.layer.getFrameIndex(window.name);
                            win.layui.table.reload("LAY-app-logDeleteRule-list-reload");
                            top.layer.close(index);
                        });
                    }
                });
            }
        } else if (isExist == true) {
            layer.msg("当前日志删除规则编码已存在，请重新输入", {
                icon: 2,
                time: 2000
            });
            submit = false;
        } else {
            layer.msg("修改失败",
                function () {
                    var index = parent.layer.getFrameIndex(window.name);
                    win.layui.table.reload("LAY-app-logDeleteRule-list-reload");
                    top.layer.close(index);
                });
        }
        return false;
    });
    //判断日志删除规则是否已存在
    $("#deleteRuleNum").blur(function () {
        var deleteRuleNum = $("#deleteRuleNum").val();
        if (deleteRuleNum != null && deleteRuleNum != "") {
            $.ajax({
                url: "<%= request.getContextPath() %>/logDeleteRule/logDeleteRule/check/isExist?deleteRuleNum=" + deleteRuleNum,
                type: "GET",
                cache: false,
                contentType: "text/json",
                cache: false,
                success: function (text) {
                    if (text.code == "1") {
                        isExist = true;
                    } else {
                        isExist = false;
                    }
                }
            });
        } else {
            return;
        }
    });
</script>
</body>
</html>
