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
    <title>接入点信息维护编辑</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <%--	需要隐藏主键,主键必要	--%>
    <input type="hidden" name="accPointResId" value="default">

        <div class="layui-form-item layui-row layui-col-space10">

            <%--        <div class="layui-col-sm6">--%>
            <%--            <label class="layui-form-label"><span style="color:red">*</span>设备类型代码:</label>--%>
            <%--            <div class="layui-input-block">--%>
            <%--                <input id="equipTypeCode" type="text" name="equipTypeCode" lay-verify="required|equipTypeCode"--%>
            <%--                       placeholder="请输入设备类型代码(必填)" autocomplete="off" class="layui-input">--%>
            <%--            </div>--%>
            <%--        </div>--%>
            <div class="layui-col-sm6">
                <label class="layui-form-label"><span style="color:red">*</span>接入点名称:</label>
                <div class="layui-input-block">
                    <input id="accPointResName" type="text" name="accPointResName" lay-verify="required|accPointResName"
                           placeholder="" autocomplete="off" class="layui-input">
                </div>
            </div>

                <div class="layui-col-sm6">
                    <label class="layui-form-label"><span style="color:red">*</span>接入点代码:</label>
                    <div class="layui-input-block">
                        <input id="accPointResCode" type="text" name="accPointResCode" lay-verify="required|accPointResCode"
                               placeholder="" autocomplete="off" class="layui-input" readonly>
                    </div>
                </div>
        </div>

        <div class="layui-form-item layui-row layui-col-space10">
            <div class="layui-col-sm6">
                <label class="layui-form-label"><span style="color:red">*</span>是否启用:</label>
                <div class="layui-input-block">
                    <select name="equipTypeEnable" id="equipTypeEnable" lay-filter="required" type="select">
                        <option value="on">是</option>
                        <option value="off">否</option>
                    </select>
                </div>
            </div>
            <div class="layui-col-sm6">
                <label class="layui-form-label"><span style="color:red">*</span>基地代码:</label>
                <div class="layui-input-block">
                    <select name="matrixCode" id="matrixCode" lay-filter="required" type="select">
                        <%--                        <option value="on">是</option>--%>
                        <%--                        <option value="off">否</option>--%>
                    </select>
                </div>
            </div>

        </div>

        <div class="layui-form-item layui-row layui-col-space10">

            <div class="layui-col-sm6">
                <label class="layui-form-label"><span style="color:red">*</span>工厂代码:</label>
                <div class="layui-input-block">
                    <select name="factoryCode" id="factoryCode" lay-filter="required" type="select">
                        <%--                        <option value="on">是</option>--%>
                        <%--                        <option value="off">否</option>--%>
                    </select>
                </div>
            </div>

            <div class="layui-col-sm6">
                <label class="layui-form-label"><span style="color:red">*</span>工厂名称:</label>
                <div class="layui-input-block">
                    <input id="factoryName" type="text" name="factoryName"
                           lay-verify="required|factoryName"
                           placeholder="工厂名称" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item layui-row layui-col-space10">
            <div class="layui-col-sm6">
                <label class="layui-form-label"><span style="color:red">*</span>工序代码：</label>
                <div class="layui-input-block">
                    <select name="processCode" id="processCode" lay-filter="required" type="select">
                        <%--                        <option value="on">是</option>--%>
                        <%--                        <option value="off">否</option>--%>
                    </select>
                </div>
            </div>

            <div class="layui-col-sm6">
                <label class="layui-form-label"><span style="color:red">*</span>工序名称：</label>
                <div class="layui-input-block">
                    <input id="processName" type="text" name="processName" lay-verify="required|processName"
                           placeholder="工序名称" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item layui-row layui-col-space10">
            <div class="layui-col-sm12">
                <label class="layui-form-label">工序描述:</label>
                <div class="layui-input-block">
            <textarea cols="50" rows="10" style="width:100%;height:100px" name="processRemarks" id="processRemarks" autocomplete="off"
                      class="layui-input" lay-verify="processRemarks"></textarea>
                </div>
            </div>
        </div>
    <div class="layui-form-item layui-row layui-col-space12" style="padding-top: 30px">
        <div class="layui-form-item layui-row layui-hide">
            <div class="layui-input-block">
                <%--java代码--%>
                <%
                    IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();
                %>
                <input type="text" class="layui-hide" name="updater" value="<%=usetObject.getUserName()%>"
                       readonly/>
            </div>
        </div>
        <div class="layui-input-block">
            <input type="text" class="layui-hide" name="updateTime"
                   value="<%=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date())%>" readonly/>
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
            //要有主键
            "accPointResId": data.accPointResId,
            "accPointResName": data.accPointResName,
            "accPointResCode": data.accPointResCode,
            "isEnable": data.isEnable,
            "matrixCode": data.matrixCode,
            "factoryCode": data.factoryCode,
            "factoryName": data.factoryName,
            "processCode": data.processCode,
            "processName": data.processName,
            "processRemarks": data.processRemarks,
        });
    }
    form.render();


    // 判断字符
    form.verify({
        accPointResName: function (value, item) {
            if (value.length > 20) {
                return "接入点名称不能超过20字符";
            }
        }
    });

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
                    url: "<%= request.getContextPath() %>/accPointResController/update",
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