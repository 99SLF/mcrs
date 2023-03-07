<%@page pageEncoding="UTF-8"%>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 李伟杰
  - Date: 2021-03-30 10:42:05
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>修改用户</title>
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
    <input type="hidden" name="operatorId" value="default">
    <input type="hidden" name="password" value="default">
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label" ><span style="color:red">*</span>用户登录账号名：</label>
            <div class="layui-input-block">
                <input id="userId" type="text" name="userId" lay-verify="required|checkUserId" placeholder="用户登录名(必填)" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label" ><span style="color:red">*</span>用户名称：</label>
            <div class="layui-input-block">
                <input id="userName" type="text" name="userName" lay-verify="required|userName" placeholder="角色名称(必填)" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">密码失效日期：</label>
            <div class="layui-input-block">
                <input type="text" name="invalDate" id="invaldate" autocomplete="off" class="layui-input" lay-verify="required" readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>用户状态：</label>
            <div class="layui-input-block">
                <%--下拉选择框--%>
                <select name="status" id="status" lay-filter="status" lay-verify="required" disabled>
                </select>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>用户类型：</label>
            <div class="layui-input-block">
                <%--下拉选择框--%>
                <select name="userType" id="userType" lay-filter="userType" lay-verify="required" disabled>
                </select>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label" >有效开始时间：</label>
            <div class="layui-input-block">
                <input type="text" name="startDate" id="startdate" autocomplete="off" class="layui-input" lay-verify="required"  readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label" >有效截止时间：</label>
            <div class="layui-input-block">
                <input type="text" name="endDate" id="enddate" autocomplete="off" class="layui-input" lay-verify="required"  readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">手机号：</label>
            <div class="layui-input-block">
                <input type="text" name="userPhone" id="userPhone" lay-verify="phone" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label" >邮箱地址：</label>
            <div class="layui-input-block">
                <input type="text" name="email" id="email" lay-verify="checkEmail" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm12">
            <label class="layui-form-label">用户描述：</label>
            <div class="layui-input-block">
            <textarea cols="50" rows="10" style="width:100%;height:100px" name="userDescription" id="userDescription"
                      autocomplete="off"
                      class="layui-textarea" lay-verify="userDescription"  readonly></textarea>
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

    layui.admin.renderDictSelect({    //获取用户状态的下拉值
        elem: "#status",
        dictTypeId: "COF_USERSTATUS"
    });

    layui.admin.renderDictSelect({    //获取用户状态的下拉值
        elem: "#userType",
        dictTypeId: "USER_TYPE"
    });
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
        operatorId = data.operatorId
        form.val("layuiadmin-app-form-list", {
            //添加选项几个弄几个，包括一个主键
            "operatorId": data.operatorId,
            "userId": data.userId,
            "userName": data.userName,
            "invalDate": util.toDateString(data.invalDate, "yyyy-MM-dd"),
            "startDate": util.toDateString(data.startDate, "yyyy-MM-dd"),
            "endDate": util.toDateString(data.endDate, "yyyy-MM-dd"),
            "userType" : data.userType,
            "userPhone" : data.userPhone,
            "userDescription" : data.userDescription,
            "email": data.email,
            "status": data.status,
        });

    }
</script>
</body>
</html>