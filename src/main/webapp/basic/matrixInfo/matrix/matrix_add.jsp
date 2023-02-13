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
    <title>基地信息新增</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <style>
        .layui-form-label {
            width: 120px;
        }

        .layui-input-block {
            margin-left: 150px;
            min-height: 30px
        }

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
            <label class="layui-form-label"><span style="color:red">*</span>基地名称:</label>
            <div class="layui-input-block">
                <input id="matrixName" type="text" name="matrixName" lay-verify="required|matrixName"
                       placeholder="请输入基地名称(必填)" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm12">
            <label class="layui-form-label"><span style="color:red">*</span>基地地址:</label>
            <div class="layui-input-block">
            <textarea name="matrixAddress" id="matrixAddress"
                      autocomplete="off"
                      class="layui-textarea" lay-verify="matrixAddress"></textarea>
            </div>
        </div>
    </div>
    <%--    <div class="layui-form-item layui-row layui-hide">--%>
    <%--        <div class="layui-input-block">--%>
    <%--            <input type="text" class="layui-hide" name="createTime"--%>
    <%--                   value="<%=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date())%>" readonly/>--%>
    <%--        </div>--%>
    <%--    </div>--%>
    <%--    <div class="layui-form-item layui-row layui-hide">--%>
    <%--        <div class="layui-input-block">--%>
    <%--            <%IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();%>--%>
    <%--            <input type="text" class="layui-hide" name="creator" value="<%=usetObject.getUserId()%>"--%>
    <%--                   readonly/>--%>
    <%--        </div>--%>
    <%--    </div>--%>

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

    // 判断字符
    form.verify({
        matrixAddress: function (value, item) {
            debugger;
            if (value.length > 225) {
                return "基地地址内容不能超过255个字";
            }
        },
        matrixName: function (value,item){
            var flag = "1";
            var checkResult = "";
            $.ajax({
                url: "<%=request.getContextPath()%>/MatrixController/check/isExist?parentId=" + parentId + "&matrixName=" + value +"&flag=" + flag,
                type: "GET",
                async: false,
                contentType: "text/json",
                cache: false,
                success: function (text) {
                    debugger;
                    if (text.code == "1") {
                        checkResult = "基地名称已存在";
                    }
                },
                error: function() {
                }
            });
            return checkResult;
        }
    });


    //监听提交
    form.on("submit(layuiadmin-app-form-submit)", function (data) {
        // var submitData = JSON.stringify(data.field);
        var sData = {};
        if (submit == false) {
            submit = true;
            sData = data.field;
            sData["parentId"] = parentId;
            var submitData = JSON.stringify(sData);
            if (isExist == false) {
                $.ajax({
                    url: "<%= request.getContextPath() %>/MatrixController/add",
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
                            top.layer.close(index);
                        });
                        win.rendTree();
                    }
                });
            } else if (isExist == true) {
                submit = false;
                layer.msg("基地已存在，请重新输入", {
                    icon: 2,
                    time: 2000
                });
                submit = false;
            }
        } else {
            layer.msg("请稍等");
        }
        return false;
    });


    // 判断基地名称是否已存在
    $("#matrixName").blur(function () {
        var matrixName = $("#matrixName").val();
        if (matrixName != null && matrixName != "") {
            $.ajax({
                url: "<%=request.getContextPath()%>/MatrixController/check/isExist?parentId=" + parentId + "&matrixName=" + matrixName,
                type: "GET",
                async: false,
                contentType: "text/json",
                cache: false,
                success: function (text) {
                    //通过接口返回，返回检测记录条数
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

