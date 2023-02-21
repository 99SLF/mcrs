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
    <title>基地信息编辑</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <style>
        .layui-form-label {
            width: 120px;
        }

        .layui-input-block {
            margin-left: 150px;
            min-height: 30px
        }
        .layui-textarea{
            height: 5px!important;
            /*min-height: 60px!important;*/
        }
    </style>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <%--	需要隐藏主键,主键必要	--%>
    <input type="hidden" name="matrixId" value="default">
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
            <textarea cols="50" rows="10" style="width:100%;height:100px" name="matrixAddress" id="matrixAddress"
                      autocomplete="off"
                      class="layui-textarea" lay-verify="matrixAddress"></textarea>
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

    // 判断字符
    form.verify({
        matrixName: function (value, item) {
            if (value.length > 225) {
                return "基地地址输入不能超过255个字";
            }
        }
    });

    var win = null;
    var key = "";
    var context = "";
    var detail = "";
    var parentId = "";

    function SetData(dataJson) {
        //编辑页面取的是管理页面表格数据，做编辑操作，表格值必须都要有
        win = dataJson.win ? dataJson.win : window;
        key = dataJson.key ? dataJson.key : "";
        context = dataJson.context ? dataJson.context : "";
        detail = dataJson.detail ? dataJson.detail : "";
        parentId = dataJson.parentId ? dataJson.parentId : "";

        form.val("layuiadmin-app-form-list", {
            //要有主键
            "matrixId": dataJson.key,
            "matrixName": dataJson.context,
            "matrixAddress": dataJson.detail,

        });


    }
    // 判断字符
    form.verify({
        matrixAddress: function (value, item) {
            debugger;
            if (value.length > 255) {
                return "基地地址内容不能超过255个字";
            }
        },
        matrixName: function (value,item){
            if(!new RegExp("^[a-zA-Z0-9\u4e00-\u9fa5]+$").test(value)){
                return "输入基地名称有误，只能输入汉字+英文+数字";
            }
            if (value.length > 20) {
                return "基地名称不能超过20个字符";
            }
            var flag = "0";
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
    // 判断基地名称是否已存在
    $("#matrixName").blur(function () {
        debugger;
        var matrixName = $("#matrixName").val();
        if (matrixName != null && matrixName != "") {
            $.ajax({
                url: "<%=request.getContextPath()%>/MatrixController/check/isExist?parentId=" + key + "&matrixName=" + matrixName,
                type: "GET",
                async: false,
                contentType: "text/json",
                cache: false,
                success: function (text) {
                    debugger;
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

    //监听提交
    form.on("submit(layuiadmin-app-form-edit)", function (dataJson) {
        var submitData = JSON.stringify(dataJson.field);

        if (submit == false) {
            submit = true;
            if (isExist == false) {
                $.ajax({
                    url: "<%= request.getContextPath() %>/MatrixController/update",
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
            } else if(isExist == true) {
                submit = false;
                layer.msg("基地已存在，请重新输入", {
                    icon: 2,
                    time: 2000
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