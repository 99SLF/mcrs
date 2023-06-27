<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<!--
 : SSW ，李伟杰
  - Date: 2021-03-30 10:42:05
  - Description:
-->
<head>
    <title>权限信息</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" media="all">
    <style>
        .layuiBtn{
            text-align:center;
        }
    </style>
</head>
<body style="margin:0px;height:100%;">
<div id="test3" class="demo-transfer" style="margin-top:10px;margin-left:60px"></div>
<script src="<%=request.getContextPath()%>/common/layui/layui.all.js"></script>
<script>
    layui.config({
        base: "<%=request.getContextPath()%>/"
    });
</script>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
<script>
    var layer = layui.layer;
    var transfer = layui.transfer;
    var $ = layui.jquery;
    var userId = null;
    var transfers = [];
    var win = null;
    var job = {};

    function SetData(data) {
        win = data.win ? data.win : window;
        job = {
            jobId: data.jobId,
        };
        getAuthorizedRoleList();
    }

    //获取授权角色
    function getAuthorizedRoleList() {
        $.ajax({
            url: "<%=request.getContextPath()%>/EmpController/queryAuthorizedRoles?jobId="+job.jobId,
            type: "GET",
            cache: false,
            contentType: "text/json",
            success: function(result) {
                for (var i = 0; i < result.data.length; i++) {
                    var roleData = result.data[i];
                    var data = {};
                    data["value"] = roleData.roleId;
                    data["title"] = roleData.roleName;
                    data["num"] = 0;
                    transfers.push(data);
                };
                getUnauthorizedRoleList();
            }
        });
    }

    //获取未授权角色
    function getUnauthorizedRoleList() {
        $.ajax({
            url: "<%=request.getContextPath()%>/EmpController/queryUnauthorizedRoles?jobId="+job.jobId,
            type: "GET",
            cache: false,
            contentType: "text/json",
            success: function(result) {
                for (var i = 0; i < result.data.length; i++) {
                    var role = result.data[i];
                    var data = {};
                    data["value"] = role.roleId;
                    data["title"] = role.roleName;
                    data["num"] = 1;
                    transfers.push(data);
                }
                real();
            }
        });
    }

    function real() {
        var value = [];
        for(var i = 0; i < transfers.length; i++) {
            if (transfers[i]["num"] == 1) {
                value.push(transfers[i]["value"]);
            }
        }
        var jobId = job.jobId;
        transfer.render({
            elem: "#test3",
            width: "200",
            height: "400",
            title: ["已授权的角色", "未授权的角色"],
            data: transfers,
            value: value,
            onchange: function(data, index) {
                var list = [];
                for (var i = 0; i < data.length; i++) {
                    var roleList1 = {
                        roleName: data[i].title,
                        roleId: data[i].value
                    };
                    list.push(roleList1);
                }
                var roleList = JSON.stringify(list);
                if (index == 0) {
                    $.ajax({
                        url: "<%=request.getContextPath()%>/EmpController/deleteRoles/"+jobId,
                        cache: false,
                        data: roleList,
                        type: "POST",
                        contentType: "text/json",
                        success: function(text) {
                            if (text.code) {
                                layer.msg("取消授权成功",{
                                    icon: 1,
                                    time: 1000
                                },function (){
                                    win.layui.table.reload('LAY-app-user-list-reload');
                                });
                            }
                        },
                        error: function() {
                        }
                    });
                } else if (index == 1) {
                    $.ajax({
                        url: "<%=request.getContextPath()%>/EmpController/addRoles/"+jobId,
                        cache: false,
                        data: roleList,
                        type: "POST",
                        contentType: "text/json",
                        success: function(text) {

                            if (text.code) {
                                layer.msg("授权成功",{
                                    icon: 1,
                                    time: 1000
                                },function (){
                                    win.layui.table.reload('LAY-app-user-list-reload');
                                });
                            }
                        },
                        error: function() {
                        }
                    });
                }
            }
        });
    }
</script>
</body>
</html>