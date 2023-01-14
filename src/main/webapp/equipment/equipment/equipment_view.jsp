<%@ page import="com.zimax.cap.party.IUserObject" %>
<%@ page import="com.zimax.cap.datacontext.DataContextManager" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 林俊杰
  - Date: 2023-1-5 16:35:14
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>设备详情</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <div class="layui-form-item layui-row layui-col-space10">
        <%--		需要隐藏主键--%>
        <input type="hidden" name="equipmentInt" value="default">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>设备资源号:</label>
            <div class="layui-input-block">
                <input id="equipmentId" type="text" name="equipmentId" lay-verify="required|equipmentId"
                       placeholder="请输入设备资源号(必填)" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>设备名称:</label>
            <div class="layui-input-block">
                <input id="equipmentName" type="text" name="equipmentName" lay-verify="required|equipmentName"
                       placeholder="请输入设备名称(必填)" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>设备安装位置:</label>
            <div class="layui-input-block">
                <input id="equipmentInstallLocation" type="text" name="equipmentInstallLocation"
                       lay-verify="" placeholder="请输入设备安装位置" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>设备类型:</label>
            <div class="layui-input-block">
                <input id="equipTypeId" name="equipTypeId" type="hidden"/>
                <input type="text" class="layui-input" name="equipTypeName" id="equipTypeName"
                       lay-verify=""
                       autocomplete="off" placeholder="" readonly>
                <button type="button" class="layui-btn layui-btn-sm layui-btn-primary" id="selectequipType"
                        style="position:absolute;top:0px;right:0px;height:37px"><i
                        class="layui-icon layui-icon-more" readonly=""></i></button>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>MES连接IP:</label>
            <div class="layui-input-block">
                <input id="mesIpAddress" type="text" name="mesIpAddress" lay-verify="required"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>支持通信协议:</label>
            <div class="layui-input-block">
                <input id="protocolCommunication" type="text" name="protocolCommunication" lay-verify="required"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>设备连接端口:</label>
            <div class="layui-input-block">
                <input id="equipmentContinuePort" type="text" name="equipmentContinuePort" lay-verify="required"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>设备连接IP:</label>
            <div class="layui-input-block">
                <input id="equipmentIp" type="text" name="equipmentIp" lay-verify="required"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>接入点名称:</label>
            <div class="layui-input-block">
                <input id="accPointResId" name="accPointResId" type="hidden"/>
                <input type="text" class="layui-input" name="accPointResName" id="accPointResName"
                       lay-verify=""
                       autocomplete="off" placeholder="" readonly>
                <button type="button" class="layui-btn layui-btn-sm layui-btn-primary" id="selectAcc"
                        style="position:absolute;top:0px;right:0px;height:37px"><i
                        class="layui-icon layui-icon-more"></i></button>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">基地代码:</label>
            <div class="layui-input-block">
                <input id="matrixCode" type="text" name="matrixCode" lay-verify="required"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>工厂代码:</label>
            <div class="layui-input-block">
                <input id="factoryCode" type="text" name="factoryCode" lay-verify="required"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label">使用工序:</label>
            <div class="layui-input-block">
                <input id="processName" type="text" name="processName" lay-verify="required"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>


    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>是否启用:</label>
            <div class="layui-input-block">
                <select name="enable" id="enable" lay-verify="required" type="select">
                    <option value=""></option>
                </select>
            </div>
        </div>

    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm12">
            <label class="layui-form-label">备注:</label>
            <div class="layui-input-block">
            <textarea cols="50" rows="10" style="width:100%;height:100px" name="remarks" id="remarks" autocomplete="off"
                      class="layui-input" lay-verify="remarks" readonly></textarea>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">创建人:</label>
            <div class="layui-input-block">
                <input id="creator" type="text" name="creator" lay-verify="required"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label">创建时间:</label>
            <div class="layui-input-block">
                <input id="createTime" type="text" name="createTime" lay-verify="required"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
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

    var win = null;

    //禁用启用下拉选择框
    layui.use('form', function(){
        var form = layui.form;
        $("#enable").attr("disabled","disabled");
        form.render('select');
    });

    //禁用选择设备类型入口
    $('#selectequipType').addClass("layui-btn-disabled").attr("disabled",true);

    //禁用选择接入点资源入口
    $('#selectAcc').addClass("layui-btn-disabled").attr("disabled",true);

    //获取启用类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#enable",
        dictTypeId: "IS_USE",
    });
    form.render();

    function SetData(data) {
        win = data.win ? data.win : window;
        var data = data.data;
        form.val("layuiadmin-app-form-list", {
            //要有主键
            "equipmentInt": data.equipmentInt,
            "equipmentId": data.equipmentId,
            "equipmentName": data.equipmentName,
            "equipmentInstallLocation": data.equipmentInstallLocation,
            "equipTypeId": data.equipTypeId,
            "equipTypeName": data.equipTypeName,
            "mesIpAddress": data.mesIpAddress,
            "protocolCommunication": data.protocolCommunication,
            "equipmentContinuePort": data.equipmentContinuePort,
            "equipmentIp": data.equipmentIp,
            "accPointResId": data.accPointResId,
            "accPointResName": data.accPointResName,
            "matrixCode": data.matrixCode,
            "factoryCode": data.factoryCode,
            "processName": data.processName,
            "enable": data.enable,
            "remarks": data.remarks,
            "creator": data.creator,
            "createTime": layui.util.toDateString(data.createTime,'yyyy-MM-dd HH:mm:ss'),
        });
    }

    form.render();

</script>
</body>
</html>