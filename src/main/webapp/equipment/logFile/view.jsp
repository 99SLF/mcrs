<%--
  Created by IntelliJ IDEA.
  User: 王广玉
  Date: 2023/1/11
  Time: 13:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>新增配置文件</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.1">
</head>
<body>
<div class="layui-fluid">
    <div class="layui-form" lay-filter="coding-add" id="coding-add" style="padding: 20px 30px 0 0;">
        <div class="layui-row layui-col-space10 layui-form-item" >
            <div class="layui-input-block">
                <textarea class="layui-textarea" id="fileCont" name="fileCont" style="height: 350px" readonly></textarea>
            </div>
        </div>

        <div class="layui-form-item layui-hide">
            <button class="layui-btn layui-btn-normal layui-hide" id='save_data' lay-submit lay-filter="save_data"></button>
        </div>
    </div>
</div>

<script src="<%=request.getContextPath()%>/common/layui/layui.all.js"></script>
<script>
    layui.config({
        base: "<%=request.getContextPath()%>/"
    });
</script>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
<script type="text/javascript">
    var layer = layui.layer;
    var table = layui.table;
    var form = layui.form;
    var $ = layui.jquery;

    var win=null;
    function SetData(obj) {
        win = obj.win ? obj.win : window;
        data = obj.data ? obj.data : null;
        fileCont = obj.fileCont ? obj.fileCont : null;
        form.val("coding-add",{
            "fileCont" : fileCont,
        });
    }



</script>
</body>
</html>