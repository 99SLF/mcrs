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
  - Date: 2023-1-6 11:56:14
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>终端详情</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <div class="layui-form-item layui-row layui-col-space10">
        <%--	需要隐藏主键	--%>
        <input type="hidden" name="deviceId" value="default">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>APPID:</label>
            <div class="layui-input-block">
                <input id="APPId" type="text" name="APPId" lay-verify="" placeholder="" autocomplete="off"
                       class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">版本号:</label>
            <div class="layui-input-block">
                <input id="version" type="text" name="version" lay-verify="" placeholder="" autocomplete="off"
                       class="layui-input" readonly>
            </div>
        </div>

    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">启用：</label>
            <div class="layui-input-block">
                <select name="enable" id="enable" lay-filter="" type="select">
                    <option value="on">是</option>
                    <option value="off">否</option>
                </select>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">需要更新:</label>
            <div class="layui-input-block">
                <input id="needUpdate" type="text" name="needUpdate" lay-verify="" placeholder=""
                       autocomplete="off" class="layui-input" readonly>
            </div>
        </div>

    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">注册状态:</label>
            <div class="layui-input-block">
                <input id="registerStatus" type="text" name="registerStatus" lay-verify="" placeholder=""
                       autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>终端类型:</label>
            <div class="layui-input-block">
                <select name="deviceSoftwareType" id="deviceSoftwareType" lay-filter="" type="select">
                    <option value=""></option>
                </select>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>终端名称:</label>
            <div class="layui-input-block">
                <input id="deviceName" type="text" name="deviceName" lay-verify="required|deviceName" placeholder=""
                       autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>接入点名称:</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="accPointResName" id="accPointResName"
                       lay-verify=""
                       autocomplete="off" placeholder="" readonly>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">工厂名称:</label>
            <div class="layui-input-block">
                <input id="factoryName" type="text" name="factoryName" lay-verify="factoryName" placeholder=""
                       autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">使用工序:</label>
            <div class="layui-input-block">
                <input id="processName" type="text" name="processName" lay-verify=""
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>设备资源号:</label>
            <div class="layui-input-block">
                <input id="equipmentInt" name="equipmentInt" type="hidden"/>
                <input type="text" class="layui-input" name="equipmentId" id="equipmentId"
                       lay-verify=""
                       autocomplete="off" placeholder="" readonly>
                <button type="button" class="layui-btn layui-btn-sm layui-btn-primary" id="selectEquipment"
                        style="position:absolute;top:0px;right:0px;height:37px"><i
                        class="layui-icon layui-icon-more"></i></button>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">设备接入IP:</label>
            <div class="layui-input-block">
                <input id="equipmentIp" type="text" name="equipmentIp" lay-verify="equipmentIp" placeholder=""
                       autocomplete="off"
                       class="layui-input" readonly>
            </div>
        </div>

    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">设备接入端口:</label>
            <div class="layui-input-block">
                <input id="equipmentContinuePort" type="text" name="equipmentContinuePort" lay-verify=""
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">设备安装位置:</label>
            <div class="layui-input-block">
                <input id="equipmentInstallLocation" type="text" name="equipmentInstallLocation"
                       lay-verify="assessInstallLocation" placeholder="" autocomplete="off" class="layui-input"
                       readonly>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>终端程序安装路径:</label>
            <div class="layui-input-block">
                <input id="programInstallationPath" type="text" name="programInstallationPath" lay-verify="required"
                       placeholder="" autocomplete="off" class="layui-input"  readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>终端执行程序安装路径:</label>
            <div class="layui-input-block">
                <input id="executorInstallationPath" type="text" name="executorInstallationPath"
                       lay-verify="required" placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>接入方式:</label>
            <div class="layui-input-block">
                <select name="accessMethod" id="accessMethod" lay-filter="" type="select">
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
    //禁用终端软件类型下拉选择框
    layui.use('form', function(){
        var form = layui.form;
        $("#deviceSoftwareType").attr("disabled","disabled");
        form.render('select');
    });
    //禁用接入方式下拉选择框
    layui.use('form', function(){
        var form = layui.form;
        $("#accessMethod").attr("disabled","disabled");
        form.render('select');
    });

    //禁用选择设备
    $('#selectEquipment').addClass("layui-btn-disabled").attr("disabled",true);

    //禁用选择接入点资源
    $('#accPoint').addClass("layui-btn-disabled").attr("disabled",true);

    //获取接入方式的下拉值
    layui.admin.renderDictSelect({
        elem: "#accessMethod",
        dictTypeId: "ACCESS_METHOD",
    });
    //设置接入方式的默认值
    $("#accessMethod").val("101");
    form.render();

    //获取软件类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#deviceSoftwareType",
        dictTypeId: "DEVICE_SOFTWARE_TYPE",
    });
    form.render();


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
            //需要传入主键
            "deviceId": data.deviceId,
            "APPId": data.aPPId,
            "version": data.version,
            "needUpdate": data.needUpdate,
            "enable": data.enable,
            "registerStatus": layui.admin.getDictText("REGISTER_STATUS",data.registerStatus),
            "deviceSoftwareType": data.deviceSoftwareType,
            "deviceName": data.deviceName,
            "accPointResId": data.accPointResId,
            "accPointResName": data.accPointResName,
            "factoryName": data.factoryName,
            "equipmentInt": data.equipmentInt,
            "equipmentId": data.equipmentId,
            "equipmentIp": data.equipmentIp,
            "equipmentContinuePort": data.equipmentContinuePort,
            "processName": data.processName,
            "equipmentInstallLocation": data.equipmentInstallLocation,
            "accessMethod": data.accessMethod,
            "remarks": data.remarks,
            "creator": data.creator,
            "createTime": layui.util.toDateString(data.createTime,'yyyy-MM-dd HH:mm:ss'),
            "programInstallationPath": data.programInstallationPath,
            "executorInstallationPath": data.executorInstallationPath,
        });
    }

    form.render();

</script>
</body>
</html>