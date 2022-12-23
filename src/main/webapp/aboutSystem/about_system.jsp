<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 林俊杰
  - Date: 2022-12-01 16:11:58
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>关于系统</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
</head>
<body>
<h1 style="padding-left: 30px">系统版本信息</h1>
<fieldset class="layui-elem-field layui-field-title">
</fieldset>

<div class="layui-form">
    <div class="layui-form-item layui-row layui-col-space12">
        <div class="layui-col-sm2">
        </div>
        <div class="layui-col-sm8">
        <table class="layui-table" style="text-align:center">
            <tbody>
            <tr>
                <td style="width: 130px;height: 65px;background-color: #F1F1F1">平台版本</td>
                <td>V1.0</td>
                <td style="width: 240px;height: 65px;background-color: #F1F1F1">作者</td>
                <td>芝麻自动化</td>
            </tr>
            <tr>
                <td style="width: 120px;height: 65px;background-color: #F1F1F1">发布时间</td>
                <td>2022/11/29</td>
                <td style="width: 240px;height: 65px;background-color: #F1F1F1">版本说明</td>
                <td>暂无</td>
            </tr>
            </tbody>
        </table>
        </div>
    </div>
</div>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
</body>
</html>
