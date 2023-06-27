<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 2023/6/20
  Time: 12:00
  To change this template use File | Settings | File Templates.
--%>
<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport"
        content="width=equipment-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <title>添加角色</title>
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
      <label class="layui-form-label"><span style="color:red">*</span>角色代码：</label>
      <div class="layui-input-block">
        <input id="roleCode" type="text" name="roleCode" lay-verify="required|checkRoleCode" placeholder="角色代码(必填)"
               autocomplete="off" class="layui-input">
      </div>
    </div>
    <div class="layui-col-sm6">
      <label class="layui-form-label"><span style="color:red">*</span>角色名字：</label>
      <div class="layui-input-block">
        <input id="roleName" type="text" name="roleName" lay-verify="required" placeholder="角色名字(必填)"
               autocomplete="off" class="layui-input">
      </div>
    </div>
    <div class="layui-row layui-form-item">
      <label class="layui-form-label layui-form-project">角色描述：</label>
      <div class="layui-input-block layui-textarea-block">
        <textarea class="layui-textarea" name="roleDesc" autocomplete="off" lay-verify="length255"class="layui-textarea"></textarea>
      </div>
    </div>
  </div>

  <div class="layui-form-item layui-hide">
    <input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit"
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

  //全加载：日期
  var laydate = layui.laydate;
  var form = layui.form;
  var $ = layui.jquery;
  var submit = false;
  var isExist = false;
  var win = null;

  function SetData(data) {
    win = data.win ? data.win : window;
  }

  // form.render();

  //判断字符
  form.verify({
    checkRoleCode: function (value, item) {
      if (!new RegExp("^[a-zA-Z0-9_]+$").test(value)) {
        return "输入的角色代码有误，只能输入英文字母、数字、下划线";
      }
      if (value.length > 20) {
        return "输入的角色代码有误，不能超过20个字符";
      }
      var checkResult = "";
      var flag = "1";
      $.ajax({
        url: "<%=request.getContextPath()%>/EmpRoleController/isExist?roleCode=" + value,
        type: "GET",
        // data: json,
        // data: userId,
        async: false,
        contentType: "text/json",
        cache: false,
        success: function (text) {
          if (text.code == "1") {
            checkResult = "角色代码已存在";
          }
        },
        error: function () {
        }
      });
      return checkResult;
    },
  });


  //监听提交
  form.on("submit(layuiadmin-app-form-submit)", function (data) {
    // var submitData = JSON.stringify(data.field);
    if (submit == false) {
      submit = true;
      var submitData = JSON.stringify(data.field);
      if (isExist == false) {
        $.ajax({
          url: "<%=request.getContextPath()%>/EmpRoleController/add",
          type: "POST",
          data: submitData,
          cache: false,
          contentType: "text/json",
          success: function (result) {
            layer.msg("添加成功", {
              icon: 1,
              time: 2000
            }, function () {
              var index = parent.layer.getFrameIndex(window.name);
              win.layui.table.reload('LAY-app-user-list-reload');
              win.window.formReder();
              top.layer.close(index);
            });
          }
        });
      } else if (isExist == true) {
        submit = false;
        layer.msg("角色代码已存在，请重新输入", {
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


</script>
</body>
</html>
