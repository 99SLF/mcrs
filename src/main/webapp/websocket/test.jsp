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
    <title>测试</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
</head>
<body>
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script>
    layui.config({
        base: "<%=request.getContextPath()%>/"
    });
    //先加载layui的js，再加载websocket的js，layui中的jQuery是小写的，不改js，在使用客户端引用，jQuery = layui.$; var $ = layui.$;
    jQuery = layui.$;
</script>

<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
<script type="text/javascript"
        src="<%=request.getContextPath()%>/common/components/websocket/jquery.loadJSON.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/common/components/websocket/WebSocket.js"></script>
<script type="text/javascript"
        src="<%=request.getContextPath()%>/common/components/websocket/jquery.WebSocket.js"></script>
<script type="text/javascript">
    var $ = layui.$;

    var test = new $.websocket({
        protocol: "mcrs/websocket/test",
        port: "8089",
        onOpen: function (event) {
            test.send("hello world");
        },
        onError: function (event) {
        },
        onMessage: function (event) {
            debugger;
            var json = JSON.parse(event.data);
            console.info(json);
        },
        onClose: function (event) {
            test = null;
        }
    });
</script>
</body>
</html>
</body>
</html>
