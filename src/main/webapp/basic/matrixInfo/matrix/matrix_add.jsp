<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.zimax.cap.party.IUserObject" %>
<%@ page import="com.zimax.cap.datacontext.DataContextManager" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 李伟杰
  - Date: 2022-12-21 22:10:17
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>基础基地数据新增</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <style>
        .layui-form-label {
            width: 120px;
        }

        .layui-input-block {
            margin-left: 150px;
            min-height: 36px
        }
    </style>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>基地名称:</label>
            <div class="layui-input-block">
                <input id="matrixName" type="text" name="matrixName" lay-verify="required|matrixName"
                       placeholder="请输入基地名称(必填)" autocomplete="off" class="layui-input">
            </div>
        </div>

    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>基地地址:</label>
            <div class="layui-input-block">
                <input id="matrixAddress" type="text" name="matrixAddress" lay-verify="required|matrixAddress"
                       placeholder="请输入基地地址(必填)" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-hide">
        <div class="layui-input-block">
            <input type="text" class="layui-hide" name="createTime"
                   value="<%=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date())%>" readonly/>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-hide">
        <div class="layui-input-block">
            <%--java代码--%>
            <%
                IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();
            %>
            <input type="text" class="layui-hide" name="creator" value="<%=usetObject.getUserName()%>"
                   readonly/>
        </div>
    </div>

    <div class="layui-form-item">
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
        matrixName: function (value, item) {
            if (value.length > 20) {
                return "设备类型名称不能超过20字符";
            }
        },
        matrixAddress: function (value, item) {
            if (value.length > 20) {
                return "厂家不能超过20字";
            }
        }
    });

    form.render();

    //监听提交
    form.on("submit(layuiadmin-app-form-submit)", function (data) {
        // var submitData = JSON.stringify(data.field);
        debugger;
        if (submit == false) {
            submit = true;
            var submitData = JSON.stringify(data.field);
            debugger;
            if (isExist == false) {
                $.ajax({
                    url: "<%= request.getContextPath() %>/MatrixController/add",
                    type: "POST",
                    data: submitData,
                    cache: false,
                    contentType: "text/json",
                    success: function (result) {
                        layer.msg("新增成功", {
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