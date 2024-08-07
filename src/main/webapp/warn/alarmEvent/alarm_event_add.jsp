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
    <title>预警信息添加</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/common/layui/css/layui.css">
    <style>
        .layui-textarea {
            height: 5px !important;
            /*min-height: 60px!important;*/
        }
    </style>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>预警事件编码:</label>
            <div class="layui-input-block">
                <input id="alarmEventId" type="text" name="alarmEventId" lay-verify="required|alarmEventId"
                       placeholder="预警事件编码(必填)" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>预警事件标题:</label>
            <div class="layui-input-block">
                <input id="alarmEventTitle" type="text" name="alarmEventTitle" lay-verify="required|alarmEventTitle"
                       placeholder="预警事件标题" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>预警级别:</label>
            <div class="layui-input-block">
                <select name="alarmLevel" id="alarmLevel"  lay-verify="required" lay-filter="" type="select" >
                    <option value=""></option>

                </select>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>预警类型:</label>
            <div class="layui-input-block">
                <select name="alarmType" id="alarmType"  lay-verify="required" lay-filter="" type="select" >
                    <option value=""></option>
                </select>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>上限:</label>
            <div class="layui-input-block">
                <input id="upperLimit" type="text" name="upperLimit" lay-verify="required|upperLimit|number"
                       placeholder="请输入上限" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>下限:</label>
            <div class="layui-input-block">
                <input id="lowerLimit" type="text" name="lowerLimit" lay-verify="required|lowerLimit|number" placeholder="请输入下限"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>启用：</label>
            <div class="layui-input-block">
                <select name="enableStatus" id="enableStatus" lay-filter="enableStatus" type="select" lay-verify="required">
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
                      class="layui-textarea" lay-verify="alarmEventContent"></textarea>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-hide">
        <input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit"
               value="确认添加">
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
    var laydate = layui.laydate;
    var form = layui.form;
    var $ = layui.jquery;
    var submit = false;
    var isExist = false;
    var win = null;

    function SetData(data) {
        win = data.win ? data.win : window;
    }

    //获取预警类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#alarmType",
        dictTypeId: "WRANING_TYPE",
    });
    //设置预警类型的默认值
    $("#alarmType").val("102");
    form.render();

    //获取预警级别的下拉值
    layui.admin.renderDictSelect({
        elem: "#alarmLevel",
        dictTypeId: "WARNING_LEVEL",
    });
    $("#alarmLevel").val("101");
    form.render();

    //获取启用的下拉值
    layui.admin.renderDictSelect({
        elem: "#enableStatus",
        dictTypeId: "IS_USE",
    });
    //设置启用的默认值
    $("#enableStatus").val("101");
    form.render();

    // 判断字符
    form.verify({
        alarmEventId: function(value, item) {
            if(!new RegExp("^[A-Za-z0-9]+$").test(value)){
                return "输入预警事件编码有误，只能输入英文+数字";
            }
    		if (value.length > 20) {
    			return "预警事件编码不能超过20字";
    		}
    	},
        alarmEventTitle: function(value, item) {
    		if(value.length >20){
    			return "预警事件标题不能超过20字";
    		}
    	},
        upperLimit: function(value, item) {
            if(value.length >20){
                return "上限不能超过20字";
            }
        },
        lowerLimit: function(value, item) {
            if(value.length >20){
                return "下限不能超过20字";
            }
        },
        alarmEventContent: function(value, item) {
    		if (value.length > 255) {
    			return "备注不能超过255字";
    		}
    	}
    });

    // form.render();
    // //日期
    // laydate.render({
    // 	elem: '#invaldate',
    // 	format: 'yyyy-MM-dd',
    // 	//解决时间选择器一闪而过的情况
    // 	trigger: 'click',
    // });

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
    form.on("submit(layuiadmin-app-form-submit)", function (data) {
        var submitData = JSON.stringify(data.field);
        if (submit == false) {
            submit = true;
            if (isExist == false) {
                $.ajax({
                    url: "<%= request.getContextPath() %>/warn/alarmEvent/add",
                    type: "POST",
                    data: submitData,
                    cache: false,
                    contentType: "text/json",
                    success: function (result) {
                        layer.msg("添加成功", {
                            icon: 1,
                            time: 500
                        }, function () {
                            var index = parent.layer.getFrameIndex(window.name);
                            win.layui.table.reload("LAY-app-alarmEvent-list-reload");
                            win.window.formReder();
                            top.layer.close(index);
                        });
                    }
                });
            }
            else if (isExist == true) {
                layer.msg("预警事件编码已存在，请重新输入", {
                    icon: 2,
                    time: 2000
                });
                submit = false;
            }
        } else {
            layer.msg("正在添加...请稍等！");
        }
        return false;
    });


    //判断预警事件编码是否已存在
    $("#alarmEventId").blur(function () {
        var alarmEventId = $("#alarmEventId").val();
        if (alarmEventId != null && alarmEventId != "") {
            $.ajax({
                url: "<%= request.getContextPath() %>/warn/alarmEvent/check/isExist?alarmEventId=" + alarmEventId,
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