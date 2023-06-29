<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 2023/6/20
  Time: 12:00
  To change this template use File | Settings | File Templates.
--%>

<%@page pageEncoding="UTF-8"%>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>修改员工</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
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
     style="padding: 20px 30px 0 0 ">
    <input type="hidden" name="jobId" >
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>工号：</label>
            <div class="layui-input-block">
                <input id="jobNo" type="text" name="jobNo" lay-verify="required|checkJobNo" placeholder="工号(必填)"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>等级：</label>
            <div class="layui-input-block">
                <input id="grade" type="text" name="grade" lay-verify="required|grade" placeholder="等级(必填)"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>姓名：</label>
            <div class="layui-input-block">
                <input id="jobName" type="text" name="jobName" lay-verify="" placeholder="姓名"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-hide">
        <input type="button" lay-submit lay-filter="layuiadmin-app-form-edit" id="layuiadmin-app-form-edit" value="确认编辑">
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
    var util = layui.util;

    var isExist = false;
    var submit = false;

    var jobNoCheck ='';
    form.render();
    //日期
    laydate.render({
        elem: '#invaldate',
        format: 'yyyy-MM-dd',
        trigger: 'click',   //解决时间选择器一闪而过的情况
    });




    var operatorId ="";
    var win = null;
    function SetData(data) {
        win = data.win ? data.win : window;
        var data = data.data;
        jobNoCheck = data.jobNo
        form.val("layuiadmin-app-form-list", {
            //添加选项几个弄几个，包括一个主键
            "jobId": data.jobId,
            "jobNo": data.jobNo,
            "jobName": data.jobName,
            "grade": data.grade
        });
    }


    //判断字符
    form.verify({
        grade: function(value,item) {
            var reg=/^[0-9]*$/;
            if(!reg.test(value)){
                return '此项为数字，请重新输入';
            }
        },
    });

    //判断角色代码是否已存在
    $("#jobNo").blur(function () {
        var jobNo = $("#jobNo").val();
        if (jobNo != jobNoCheck) {
            $.ajax({
                url: "<%= request.getContextPath()%>/EmpController/isExist?jobNo=" + jobNo,
                type: "GET",
                cache: false,
                contentType: "text/json",
                success: function (text) {
                    if (text.code == "1") {
                        isExist = true;
                    } else {
                        isExist = false;
                    }
                }
            });
        } else {
            isExist = false;
        }
    });

    //监听提交
    form.on("submit(layuiadmin-app-form-edit)", function(data) {
        delete data.field.password;
        var submitData = JSON.stringify(data.field);
        if (submit == false) {
            submit = true;
            if (isExist == false) {
                $.ajax({
                    url: "<%=request.getContextPath()%>/EmpController/update",
                    type: "POST",
                    data: submitData,
                    cache: false,
                    contentType: "text/json",
                    success: function(result) {
                        layer.msg("修改成功", {
                            icon: 1,
                            time: 2000
                        }, function() {
                            var index = parent.layer.getFrameIndex(window.name);
                            win.layui.table.reload('LAY-app-user-list-reload');
                            top.layer.close(index);
                        });
                    }
                });
            } else if(isExist == true) {
                submit = false;
                layer.msg("员工已存在，请重新输入", {
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