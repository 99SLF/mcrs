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
  - Date: 2023-1-15 16:13:14
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>工厂信息编辑</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <%--	需要隐藏主键,主键必要	--%>
    <input type="hidden" name="factoryId" value="default">
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>工厂名称:</label>
            <div class="layui-input-block">
                <input id="factoryName" type="text" name="factoryName" lay-verify="required|factoryName"
                       placeholder="请输入工厂名称(必填)" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm12">
            <label class="layui-form-label"><span style="color:red">*</span>工厂地址:</label>
            <div class="layui-input-block">
            <textarea cols="50" rows="10" style="width:100%;height:100px" name="factoryAddress" id="factoryAddress"
                      autocomplete="off"
                      class="layui-input" lay-verify=""></textarea>
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

    //数据字典项加载
    form.render();
    var win = null;
    var key = "";
    var context = "";
    var detail = "";

    function SetData(dataJson) {
        //编辑页面取的是管理页面表格数据，做编辑操作，表格值必须都要有
        win = dataJson.win ? dataJson.win : window;
        key = dataJson.key ? dataJson.key : "";
        context = dataJson.context ? dataJson.context : "";
        detail = dataJson.detail ? dataJson.detail : "";
        form.val("layuiadmin-app-form-list", {
            //要有主键
            "factoryId": dataJson.key,
            "factoryName": dataJson.context,
            "factoryAddress": dataJson.detail,
        });
    }



    //监听提交
    form.on("submit(layuiadmin-app-form-edit)", function (dataJson) {
        var submitData = JSON.stringify(dataJson.field);
        if (submit == false) {
            submit = true;
            if (isExist == false) {
                $.ajax({
                    url: "<%= request.getContextPath() %>/FactoryController/update",
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
                        win.rendTree();
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