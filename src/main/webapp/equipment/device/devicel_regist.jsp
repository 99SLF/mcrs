<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.zimax.cap.party.IUserObject" %>
<%@ page import="com.zimax.cap.datacontext.DataContextManager" %>
<%@ page import="javax.management.relation.InvalidRoleInfoException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 林俊杰
  - Date: 2022-12-01 16:12:23
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>终端注册</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <script src="common/layui/layui.all.js"></script>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm4">
            <label class="layui-form-label">设备资源号:<span style="color:red">*</span></label>
            <div class="layui-input-block">
                <input id="equipmentId" type="text" name="equipmentId" lay-verify="required|equipmentId"
                       placeholder="请输入设备资源号(必填)" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-col-sm4">
            <label class="layui-form-label">接入点名称:<span style="color:red">*</span></label>
            <div class="layui-input-block">
                <input id="assessName" type="text" name="assessName" lay-verify="required|assessName"
                       placeholder="接入点名称(必填)" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-col-sm4">
            <label class="layui-form-label" >APPID:<span style="color:red">*</span></label>
            <div class="layui-input-block">
                <input id="APPId" type="text" name="APPId" lay-verify="required|APPId" placeholder="请输入APPId"
                       autocomplete="off" class="layui-input" >
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm4">
            <label class="layui-form-label" >终端软件类型:<span style="color:red">*</span></label>
            <div class="layui-input-block">
                <input id="deviceSoftwareType" type="text" name="deviceSoftwareType" lay-verify="required|deviceSoftwareType"
                       placeholder="请输入终端软件类型" autocomplete="off" class="layui-input" >
            </div>
        </div>

        <div class="layui-col-sm4">
            <label class="layui-form-label">接入方式:<span style="color:red">*</span></label>
            <div class="layui-input-block">
                <input id="accessMethod" type="text" name="accessMethod" lay-verify="required|accessMethod"
                       placeholder="请输入接入方式" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-col-sm4">
            <label class="layui-form-label">版本号:<span style="color:red">*</span></label>
            <div class="layui-input-block">
                <input id="version" type="text" name="version" lay-verify="required|version" placeholder="请输入版本号"
                       autocomplete="off" class="layui-input" >
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space12">
        <div class="layui-col-sm4">
            <label class="layui-form-label">注册人:</label>
            <div class="layui-input-block">
                <%
                    IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();
                %>
                <%-- <input id="creator" type="text" name="creator" lay-verify="" placeholder="" autocomplete="off" class="layui-input">--%>
                <input type="text" class="layui-input" id="creator" name="creator"
                       value="<%=usetObject.getUserName()%>" readonly/>
            </div>
        </div>

<%--        <div class="layui-col-sm4">--%>
<%--            <label class="layui-form-label">注册角色：</label>--%>
<%--            <div class="layui-input-block">--%>
<%--                <input type="text" class="layui-input" id="createRole"--%>
<%--                       name="createRole" value="<%=usetObject.getUserName()%>" readonly />--%>
<%--            </div>--%>
<%--        </div>--%>
        <div class="layui-col-sm4">
            <label class="layui-form-label">注册时间：</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="createTime"
                       value="<%=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date())%>" readonly/>
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


    // 判断字符
    form.verify({
    	equipmentId: function(value, item) {
    		if (value.length > 30) {
    			return "设备资源号不能超过30个字符";
    		}
    	},
        assessName: function(value, item) {
    		if(value.length > 20){
    			return "接入点名称不能超过20个字符,";
    		}
    	},
        APPId: function(value, item) {
    		if (value.length > 100) {
    			return "APPId不能超过100个字符";
    		}
    	},
        deviceSoftwareType: function(value, item) {
            if (value.length > 20) {
                return "终端软件类型不能超过100个字符";
            }
        },
        accessMethod: function(value, item) {
            if (value.length > 10) {
                return "接入方式不能超过10个字符";
            }
        },
        version: function(value, item) {
            if (value.length > 20) {
                return "版本号不能超过20个字符";
            }
        }
    });
    //
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
        debugger;
        if (submit == false) {
            submit = true;
            if (isExist == false) {
                $.ajax({
                    url: "<%= request.getContextPath() %>/equipment/device/registrationDevice",
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
                            win.layui.table.reload("LAY-app-device-list-reload");
                            top.layer.close(index);
                        });
                    }
                });
            }
        } else {
            layer.msg("请稍等");
        }
        return false;
    });
</script>
</body>
</html>