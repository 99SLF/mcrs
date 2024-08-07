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
  - Date: 2022-12-01 16:13:14
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>终端编辑</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <style>
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
            <label class="layui-form-label"><span style="color:red">*</span>启用:</label>
            <div class="layui-input-block">
                <select name="enable" id="enable" lay-filter="" lay-verify="required" type="select">
                    <option value=""></option>
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
                <input id="registerStatus" name="registerStatus" type="hidden"/>
                <input id="registerStatusShow" type="text" name="registerStatusShow" lay-verify="" placeholder=""
                       autocomplete="off" class="layui-input"  readonly>
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
                <input id="deviceName" type="text" name="deviceName" lay-verify="required" placeholder=""
                       autocomplete="off" class="layui-input">
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
                <input id="factoryName" type="text" name="factoryName" lay-verify="" placeholder=""
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
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">设备接入IP:</label>
            <div class="layui-input-block">
                <input id="equipmentIp" type="text" name="equipmentIp" lay-verify="" placeholder=""
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
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>终端程序解压路径:</label>
            <div class="layui-input-block">
                <input id="programInstallationPath" type="text" name="programInstallationPath" lay-verify="required|programInstallationPath"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>终端执行程序安装路径:</label>
            <div class="layui-input-block">
                <input id="executorInstallationPath" type="text" name="executorInstallationPath"
                       lay-verify="required|executorInstallationPath" placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>接入方式:</label>
            <div class="layui-input-block">
                <select name="accessMethod" id="accessMethod" lay-filter="" type="select" lay-verify="required">
                    <option value=""></option>
                </select>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">设备类型:</label>
            <div class="layui-input-block">
                <input id="" type="text" name="equipTypeName"
                       lay-verify="" placeholder="" autocomplete="off" class="layui-input"
                       readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm12">
            <label class="layui-form-label">备注:</label>
            <div class="layui-input-block">
            <textarea cols="50" rows="10" style="width:100%;height:100px" name="remarks" id="remarks" autocomplete="off"
                      class="layui-textarea" lay-verify="remarks"></textarea>
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
    var win = null;

    //禁用终端软件类型下拉框
    layui.use('form', function () {
        var form = layui.form;
        // $("#deviceSoftwareType").attr("disabled", "disabled");
        $("#deviceSoftwareType").removeAttr("disabled");
        form.render('select');
    });

    //禁用选择设备资源号按钮
    $('#selectEquipment').addClass("layui-btn-disabled").attr("disabled", true);


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
            "registerStatus": data.registerStatus,
            "registerStatusShow": layui.admin.getDictText("REGISTER_STATUS",data.registerStatus),
            "deviceSoftwareType": data.deviceSoftwareType,
            "deviceName": data.deviceName,
            "accPointResId": data.accPointResId,
            "accPointResName": data.accPointResName,
            "factoryName": data.factoryName,
            "equipmentInt": data.equipmentInt,
            "equipmentId": data.equipmentId,
            "equipTypeName": data.equipTypeName,
            "equipmentIp": data.equipmentIp,
            "equipmentContinuePort": data.equipmentContinuePort,
            "processName": data.processName,
            "equipmentInstallLocation": data.equipmentInstallLocation,
            "accessMethod": data.accessMethod,
            "remarks": data.remarks,
            "programInstallationPath": data.programInstallationPath,
            "executorInstallationPath": data.executorInstallationPath,
        });
    }

    //获取接入方式的下拉值
    layui.admin.renderDictSelect({
        elem: "#accessMethod",
        dictTypeId: "ACCESS_METHOD",
    });
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

    //获取启用类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#registerStatus",
        dictTypeId: "REGISTER_STATUS",
    });
    form.render();




    //判断字符
    form.verify({
        deviceName: function (value, item) {
            if(!new RegExp("^[a-zA-Z0-9\u4e00-\u9fa5]+$").test(value)){
                return "输入终端名称有误，只能输入汉字+英文+数字";
            }
            if (value.length > 20) {
                return "终端名称不能超过20个字符";
            }
        },
        // equipmentName: function (value, item) {
        //     if (value.length > 20) {
        //         return "接入点名称不能超过20个字符";
        //     }
        // },
        deviceSoftwareType: function (value, item) {
            if (value.length > 10) {
                return "终端软件类型不能超过10字符";
            }
        },
        assessType: function (value, item) {
            if (value.length > 10) {
                return "接入点类型不能超过10字符";
            }
        },
        assessIp: function (value, item) {
            if (value.length > 50) {
                return "接入点Ip不能超过50字符";
            }
        },
        equipmentId: function (value, item) {
            if (value.length > 30) {
                return "接入点资源号不能超过30字符";
            }
        },
        assessAttributes: function (value, item) {
            if (value.length > 30) {
                return "接入点属性不能超30字符";
            }
        },
        assessInstallLocation: function (value, item) {
            if (value.length > 30) {
                return "接入点安装位置不能超30字符";
            }
        },
        factoryName: function (value, item) {
            if (value.length > 20) {
                return "工厂名称不能超20字符";
            }
        },
        accessMethod: function (value, item) {
            if (value.length > 20) {
                return "接入方式不能超20字符";
            }
        },
        programInstallationPath: function (value, item) {
            //文件夹路径的正则表达式:^([a-zA-Z]:(([\\\\/])[^\\\\/:*?<>|]+)*([\\\\/])[^\\\\/:*?<>|]+\\.[^\\\\/:*?<>|]+,)*[a-zA-Z]:(([\\\\/])[^\\\\/:*?<>|]+)*([\\\\/])[^\\\\/:*?<>|.]+(/[^\\\\/:*?\"<>.|]|[/w,/s]*|[\\/])$
            if(!new RegExp("^([a-zA-Z]:(([\\\\/])[^\\\\/:*?<>|]+)*([\\\\/])[^\\\\/:*?<>|]+\\.[^\\\\/:*?<>|]+,)*[a-zA-Z]:(([\\\\/])[^\\\\/:*?<>|]+)*([\\\\/])[^\\\\/:*?<>|.]+(/[^\\\\/:*?\"<>.|]|[/w,/s]*|[\\/])$").test(value)){
                return "输入终端程序安装路径有误";
            }
            if (value.length > 100) {
                return "终端程序安装路径不能超过100个字符";
            }
        },
        executorInstallationPath: function (value, item) {
            //文件路径的正则表达式:^([a-zA-Z]:(([\\\\/])[^\\\\/:*?<>|]+)*([\\\\/])[^\\\\/:*?<>|]+\\.[^\\\\/:*?<>|]+,)*[a-zA-Z]:(([\\\\/])[^\\\\/:*?<>|]+)*([\\\\/])[^\\\\/:*?<>|]+\\.[^\\\\/:*?<>|]+$
            if(!new RegExp("^.*?\.(exe)$").test(value)){
                return "输入终端执行程序安装路径有误";
            }
            if (value.length > 100) {
                return "终端执行程序安装路径不能超过100个字符";
            }
        },
        remarks: function (value, item){
            if (value.length >255){
                return "备注不能超过255个字符";
            }
        }

    });

    //选择设备资源号入口
    $("#selectEquipment").click(function () {
        top.layer.open({
            type: 2,
            title: "选择设备资源",
            area: ["850px", "470px"],
            btn: ["确定", "取消"],
            content: "<%= request.getContextPath() %>/equipment/equipment/equipment_select.jsp",
            yes: function (index, layero) {
                var data = layero.find('iframe')[0].contentWindow.getData();
                $("#equipmentInt").val(data.equipmentInt);
                $("#equipmentId").val(data.equipmentId);
                $("#equipmentIp").val(data.equipmentIp);
                $("#equipmentContinuePort").val(data.equipmentContinuePort);
                $("#equipmentInstallLocation").val(data.equipmentInstallLocation);
                top.layer.close(index);
            }
        });
    });
    <%--//选择接入点资源入口--%>
    <%--$("#accPoint").click(function () {--%>
    <%--    top.layer.open({--%>
    <%--        type: 2,--%>
    <%--        title: "选择接入点资源",--%>
    <%--        area: ["850px", "470px"],--%>
    <%--        btn: ["确定", "取消"],--%>
    <%--        content: "<%= request.getContextPath() %>/basic/accPointResMaintain/accPointRes_select.jsp",--%>
    <%--        yes: function (index, layero) {--%>
    <%--            var data = layero.find('iframe')[0].contentWindow.getData();--%>
    <%--            $("#accPointResId").val(data.accPointResId);--%>
    <%--            $("#accPointResName").val(data.accPointResName);--%>
    <%--            $("#factoryName").val(data.factoryName);--%>
    <%--            $("#processName").val(data.processName);--%>
    <%--            top.layer.close(index);--%>
    <%--        }--%>
    <%--    });--%>
    <%--});--%>
    <%--form.render();--%>
    // //日期
    // laydate.render({
    // 	elem: '#invaldate',
    // 	format: 'yyyy-MM-dd',
    // 	//解决时间选择器一闪而过的情况
    // 	trigger: 'click',
    // });
    //
    // var startDate = laydate.render({
    // 	elem: '#star_time',
    // 	//设置日期的类型
    // 	type: 'date',
    // 	trigger:'click',
    // 	done: function(value, date) {
    // 		if (value != "") {
    // 			date.month = date.month - 1;
    // 			date.date = date.date + 1;
    // 			endDate.config.min = date;
    // 		} else {
    // 			endDate.config.min = startDate.config.min;
    // 		}
    // 	},
    // });
    //
    // var endDate = laydate.render({
    // 	//绑定的控件名称
    // 	elem: '#end_time',
    // 	//设置日期的类型
    // 	type: 'date',
    // 	//theme: '#2c78da',
    // 	trigger: 'click',
    // 	done: function(value, date) {
    // 		if (value != "") {
    // 			date.month = date.month - 1;
    // 			date.date = date.date - 1;
    // 			startDate.config.max = date;
    // 		} else {
    // 			startDate.config.max = endDate.config.max;
    // 		}
    // 	}
    // });

    //监听提交
    form.on("submit(layuiadmin-app-form-edit)", function (data) {
        var submitData = JSON.stringify(data.field);
        if (submit == false) {
            submit = true;
            if (isExist == false) {
                $.ajax({
                    url: "<%= request.getContextPath() %>/equipment/device/update",
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
                            win.window.formReder();
                            top.layer.close(index);
                        });
                    }
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