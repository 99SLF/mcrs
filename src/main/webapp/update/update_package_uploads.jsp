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
  - Author(s): 李伟杰
  - Date: 2022-12-01 16:12:23
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>更新包上传</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <script src="common/layui/layui.all.js"></script>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-md4">
            <label class="layui-form-label"><span style="color:red">*</span>更新包单号:</label>
            <div class="layui-input-block">
                <input id="uploadNumber" type="text" name="uploadNumber" lay-verify="required|uploadNumber"
                       placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-col-md4">
            <label class="layui-form-label"><span style="color:red">*</span>是否为主要版本</label>
            <div class="layui-input-block">
                <input type="checkbox" id="majorVersion" name="majorVersion" lay-skin="switch" value="off"
                       lay-text="是|否">
            </div>
        </div>

        <div class="layui-col-md4">
            <label class="layui-form-label">版本号：</label>
            <div class="layui-input-block">
                <input id="version" type="text" name="version" lay-verify="required|version" placeholder=""
                       autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm4">
            <label class="layui-form-label"><span style="color:red">*</span>终端软件类型:</label>
            <div class="layui-input-block">
                <%--下拉选择框--%>
                <select name="deviceSoType" id="deviceSoType" lay-filter="deviceSoType" type="select">
                    <option value=""></option>
                </select>
            </div>
        </div>

        <div class="layui-col-sm4">
            <label class="layui-form-label"><span style="color:red">*</span>更新策略:</label>
            <div class="layui-input-block">
                <%--下拉选择框--%>
                <select name="uploadStrategy" id="uploadStrategy" lay-filter="uploadStrategy" type="select">
                    <option value=""></option>
                </select>
            </div>
        </div>
        <div>
            <div class="layui-form-item layui-row layui-col-space10">
                <div class="layui-col-sm4">
                    <label class="layui-form-label"><span style="color:red">*</span>更新包</label>
                    <div class="layui-input-block">
                        <button class="layui-btn layuiadmin-btn-list layui-btn-warm layui-btn-sm" lay-event="upload">
                            <i class="layui-icon">&#xe67c;</i>附件上传
                        </button>
                    </div>
                </div>
            </div>

            <div class="layui-form-item layui-row layui-col-space10">

                <label class="layui-form-label">备注：</label>
                <div class="layui-input-block">
            <textarea class="layui-textarea field-effect field-content" name="remarks" id="remarks"
                      autocomplete="off" placeholder="" lay-verify="remarks"></textarea>
                </div>

                <div>
                    <div class="layui-form-item layui-row layui-col-space12">
                        <div class="layui-col-sm4">
                            <label class="layui-form-label">制单时间：</label>
                            <div class="layui-input-block">
                                <input type="text" class="layui-input" name="versionUploadTime"
                                       value="<%=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date())%>"
                                       readonly/>
                            </div>
                        </div>
                        <div class="layui-col-sm4">
                            <label class="layui-form-label">制单人:</label>
                            <div class="layui-input-block">
                                <%
                                    IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();
                                %>
                                <input type="text" class="layui-input" id="uploader" name="uploader"
                                       value="<%=usetObject.getUserName()%>" readonly/>
                            </div>
                        </div>

                    </div>

                    <div class="layui-form-item layui-hide">
                        <input type="button" lay-submit lay-filter="layuiadmin-app-form-submit"
                               id="layuiadmin-app-form-submit"
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
        equipmentId: function (value, item) {
            if (value.length > 30) {
                return "设备资源号不能超过30个字符";
            }
        },
        assessName: function (value, item) {
            if (value.length > 20) {
                return "接入点名称不能超过20个字符,";
            }
        },
        APPId: function (value, item) {
            if (value.length > 100) {
                return "APPId不能超过100个字符";
            }
        },
        deviceSoftwareType: function (value, item) {
            if (value.length > 20) {
                return "终端软件类型不能超过100个字符";
            }
        },
        accessMethod: function (value, item) {
            if (value.length > 10) {
                return "接入方式不能超过10个字符";
            }
        },
        version: function (value, item) {
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