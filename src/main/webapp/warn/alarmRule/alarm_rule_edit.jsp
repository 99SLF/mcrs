<%@ page import="com.zimax.cap.datacontext.DataContextManager" %>
<%@ page import="com.zimax.cap.party.IUserObject" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 林俊杰
  - Date: 2022-12-01 15:59:22
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>预警规则编辑</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/common/layui/css/layui.css">
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <div class="layui-form-item layui-row layui-col-space10">
        <%--	需要隐藏主键	--%>
        <input type="hidden" name="alarmRuleInt" value="default">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>预警规则编码:</label>
            <div class="layui-input-block">
                <input id="alarmRuleId" type="text" name="alarmRuleId" lay-verify="required"
                       placeholder="预警规则编码(必填)" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">预警规则标题:</label>
            <div class="layui-input-block">
                <input id="alarmRuleTitle" type="text" name="alarmRuleTitle" lay-verify="required"
                       placeholder="预警规则标题" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>


    <div class="layui-form-item layui-row layui-col-space10">

        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>监控层级:</label>
            <div class="layui-input-block">
                <select name="monitorLevel" id="monitorLevel" lay-filter="required" type="select">
                    <option value="1级">1级</option>
                    <option value="2级">2级</option>
                    <option value="3级">3级</option>
                    <option value="4级">4级</option>
                    <option value="5级">5级</option>
                </select>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>是否启用：</label>
            <div class="layui-input-block">
                <select name="enable" id="enable" lay-filter="required" type="select">
                    <option value="on">是</option>
                    <option value="off">否</option>
                </select>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>预警事件编码:</label>
            <div class="layui-input-block">
                <input id="alarmEventInt" name="alarmEventInt" type="hidden"/>
                <input type="text" class="layui-input" name="alarmEventId" id="alarmEventId"
                       lay-verify="required"
                       autocomplete="off" placeholder="" readonly>
                <button type="button" class="layui-btn layui-btn-sm layui-btn-primary" id="onButtonAlarmEvent"
                        style="position:absolute;top:0px;right:0px;height:37px"><i
                        class="layui-icon layui-icon-more"></i></button>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>监控对象:</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="monitorObject" id="monitorObject"
                       lay-verify=""
                       autocomplete="off" placeholder="" readonly>
                <button type="button" class="layui-btn layui-btn-sm layui-btn-primary" id="onButtonMonitorObject"
                        style="position:absolute;top:0px;right:0px;height:37px"><i
                        class="layui-icon layui-icon-more"></i></button>
            </div>
        </div>

    </div>

    <div class="layui-form-item layui-row layui-col-space12">

        <div class="layui-col-sm12">
            <label class="layui-form-label">规则描述:</label>
            <div class="layui-input-block">
            <textarea cols="50" rows="10" style="width:100%;height:100px" name="alarmRuleDescribe"
                      id="alarmRuleDescribe" autocomplete="off"
                      class="layui-input" lay-verify="alarmEventContent"></textarea>
            </div>
        </div>
    </div>


            <div class="layui-input-block">
                <%
                    IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();
                %>
                <input id="ruleUpdatePeople" type="text" name="ruleUpdatePeople"  class="layui-hide" value="<%=usetObject.getUserName()%>">
            </div>

            <div class="layui-input-block">
                <input type="text" name="ruleUpdateTime" id="ruleUpdateTime"  class="layui-hide"value="<%=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date())%>">
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
        debugger;
        form.val("layuiadmin-app-form-list", {
            "alarmRuleInt": data.alarmRuleInt,
            "alarmRuleId": data.alarmRuleId,
            "alarmRuleTitle": data.alarmRuleTitle,
            "enable": data.enable,
            "monitorLevel": data.monitorLevel,
            "alarmEventId": data.alarmEventId,
            "alarmEventInt": data.alarmEventInt,
            "monitorObject": data.monitorObject,
            "alarmRuleDescribe": data.alarmRuleDescribe,

        });
    }
    //选择预警事件编码入口
    $("#onButtonAlarmEvent").click(function () {
        top.layer.open({
            type: 2,
            title: "选择预警事件编码",
            area: ["850px", "470px"],
            btn: ["确定", "取消"],
            content: "<%= request.getContextPath() %>/warn/alarmRule/alarm_event.jsp",
            yes: function (index, layero) {
                var data = layero.find('iframe')[0].contentWindow.getData();
                $("#alarmEventInt").val(data.alarmEventInt);
                $("#alarmEventId").val(data.alarmEventId);
                top.layer.close(index);
            }
        });
    });

    //选择监控对象入口
    <%--$("#onButtonMonitorObject").click(function () {--%>
    <%--    top.layer.open({--%>
    <%--        type: 2,--%>
    <%--        title: "选择监控对象",--%>
    <%--        area: ["850px", "470px"],--%>
    <%--        btn: ["确定", "取消"],--%>
    <%--        content: "<%= request.getContextPath() %>/equipment/device/device_equipment.jsp",--%>
    <%--        yes: function (index, layero) {--%>
    <%--            var data = layero.find('iframe')[0].contentWindow.getData();--%>
    <%--            $("#alarmEventInt").val(data.alarmEventInt);--%>
    <%--            $("#alarmEventId").val(data.alarmEventId);--%>
    <%--            top.layer.close(index);--%>
    <%--        }--%>
    <%--    });--%>
    <%--});--%>


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
        debugger;
        if (submit == false) {
            submit = true;
            if (isExist == false) {
                $.ajax({
                    url: "<%= request.getContextPath() %>/warn/alarmRule/update",
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
                            win.layui.table.reload("LAY-app-alarmRule-list-reload");
                            top.layer.close(index);
                        });
                    }
                });
            }
        } else {
            layer.msg("修改失败",
                function () {
                    var index = parent.layer.getFrameIndex(window.name);
                    win.layui.table.reload("LAY-app-alarmRule-list-reload");
                    top.layer.close(index);
                });
        }
        return false;
    });
</script>
</body>
</html>