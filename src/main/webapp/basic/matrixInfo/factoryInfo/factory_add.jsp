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
  - Date: 2023-1-15 22:10:17
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>工厂信息新增</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <style>
        .layui-form-label {
            width: 120px;
        }

        .layui-input-block {
            margin-left: 150px;
            min-height: 30px
        }
    </style>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
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
    <div class="layui-form-item layui-row layui-hide">
        <div class="layui-input-block">
            <input type="text" class="layui-hide" name="createTime"
                   value="<%=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date())%>" readonly/>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-hide">
        <div class="layui-input-block">
            <%IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();%>
            <input type="text" class="layui-hide" name="creator" value="<%=usetObject.getUserId()%>"
                   readonly/>
        </div>
    </div>

    <div class="layui-form-item layui-hide">
        <input type="button" lay-submit lay-filter="layuiadmin-app-form-submit"
               lay-filter="*"
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

    var parentId = "";

    // 全局变量，用户从存储从后端查询出来的结果数据
    function SetData(dataJson) {
        win = dataJson.win ? dataJson.win : window;
        parentId = dataJson.parentId ? dataJson.parentId : "";
    }


    //数据字典项加载
    form.render();


    // 判断字符
    form.verify({
        factoryAddress: function (value, item) {
            if (value.length > 225) {
                return "工厂地址输入不能超过255个字";
            }
        }
    });


    //监听提交
    form.on("submit(layuiadmin-app-form-submit)", function (data) {
        // var submitData = JSON.stringify(data.field);

        var sData = {};
        if (submit == false) {
            submit = true;
            sData = data.field;
            sData["matrixId"] = parentId;
            var submitData = JSON.stringify(sData);
            if (isExist == false) {
                $.ajax({
                    url: "<%= request.getContextPath() %>/FactoryController/add",
                    type: "POST",//post自动过滤掉field中不需要的数据，实体接什么就保留什么
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

