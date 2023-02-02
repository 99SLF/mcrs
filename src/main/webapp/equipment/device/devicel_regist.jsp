<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.zimax.cap.party.IUserObject" %>
<%@ page import="com.zimax.cap.datacontext.DataContextManager" %>
<%@ page import="javax.management.relation.InvalidRoleInfoException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 林俊杰
  - Date: 2022-12-01 16:12:23
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>终端注册</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">

    <div class="layui-form-item layui-row layui-col-space6">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>终端名称:</label>
            <div class="layui-input-block">
                <input id="deviceName" type="text" name="deviceName" lay-verify="required|deviceName"
                       placeholder="终端名称(必填)" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space6">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>设备资源号:</label>
            <div class="layui-input-block">
                <input id="equipmentInt" name="equipmentInt" type="hidden"/>
                <input type="text" class="layui-input" name="equipmentId" id="equipmentId"
                       lay-verify="required"
                       autocomplete="off" placeholder="请选择设备" readonly>
                <button type="button" class="layui-btn layui-btn-sm layui-btn-primary" id="onButtonEdit"
                        style="position:absolute;top:0px;right:0px;height:37px"><i
                        class="layui-icon layui-icon-more"></i></button>
            </div>
        </div>
    </div>


    <div class="layui-form-item layui-row layui-col-space6">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>终端类型:</label>
            <div class="layui-input-block">
                <select name="deviceSoftwareType" id="deviceSoftwareType" lay-filter="deviceSoftwareType" type="select"
                        lay-verify="required">
                    <option value=""></option>
                </select>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space6">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>是否启用：</label>
            <div class="layui-input-block">
                <select name="enable" id="enable" lay-filter="" type="select"  lay-verify="required">
                    <option value=""></option>
                </select>
            </div>
        </div>
        </div>
    <div class="layui-form-item layui-row layui-col-space6">
        <label class="layui-form-label"><span style="color:red">*</span>接入方式:</label>
        <div class="layui-input-block">
            <select name="accessMethod" id="accessMethod" lay-filter="accessMethod" type="select"  lay-verify="required">
                <option value=""></option>
            </select>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space6">
        <label class="layui-form-label"><span style="color:red">*</span>接入点名称:</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="accPointResName" id="accPointResName"
                   lay-verify="required"
                   autocomplete="off" placeholder="" readonly>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space6">
        <label class="layui-form-label"><span style="color:red">*</span>终端程序安装路径</label>
        <div class="layui-input-block">
            <input id="programInstallationPath" type="text" name="programInstallationPath" lay-verify="required"
                   placeholder="终端程序安装路径(必填)" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space6">
        <label class="layui-form-label"><span style="color:red">*</span>终端执行程序安装路径:</label>
        <div class="layui-input-block">
            <input id="executorInstallationPath" type="text" name="executorInstallationPath" lay-verify="required"
                   placeholder="" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space6">
        <div class="layui-col-sm6">
            <label class="layui-form-label">备注:</label>
            <div class="layui-input-block">
            <textarea cols="50" rows="10" style="width:100%;height:100px" name="remarks" id="remarks" autocomplete="off"
                      class="layui-input" lay-verify="remarks"></textarea>
            </div>
        </div>
    </div>

<%--    <div class="layui-inline">--%>
<%--        <div class="layui-col-sm1">--%>
<%--            &lt;%&ndash;            <label class="layui-form-label">注册人:</label>&ndash;%&gt;--%>
<%--            <div class="layui-input-block">--%>
<%--                <%--%>
<%--                    IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();--%>
<%--                %>--%>
<%--                &lt;%&ndash; <input id="creator" type="text" name="creator" lay-verify="" placeholder="" autocomplete="off" class="layui-input">&ndash;%&gt;--%>
<%--                <input type="text" class="layui-input" id="creator" name="creator"--%>
<%--                       value="<%=usetObject.getUserName()%>"/>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="layui-col-sm1">--%>
<%--            <div class="layui-input-block">--%>
<%--                <input type="text" class="layui-input" name="createTime"--%>
<%--                       value="<%=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date())%>" readonly/>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>


    <div class="layui-input-block">
        <input id="APPId" type="text" name="APPId" lay-verify="required" placeholder=""
               autocomplete="off" class="layui-hide">
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
    var laydate = layui.laydate;
    var form = layui.form;
    var $ = layui.jquery;
    var submit = false;
    var isExist = false;
    var isExistDSW = false;
    var isExistEQI = false;
    var win = null;

    function SetData(data) {
        win = data.win ? data.win : window;
    }

    form.on('select(deviceSoftwareType)', function (data) {
        check();
    });


    form.render();

    //APPID=equipmentId+deviceSoftwareType
    function check() {
        var a = document.getElementById("equipmentId").value;
        var b = document.getElementById("deviceSoftwareType").value;
        if (a && b) {
            var c = a + b;
            document.getElementById("APPId").value = c;
        } else {
            document.getElementById("APPId").value = "";
        }
    }

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
    //设置软件类型的默认值
    $("#deviceSoftwareType").val("101");
    form.render();

    //获取启用类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#enable",
        dictTypeId: "IS_USE",
    });
    //设置启用的默认值
    $("#enable").val("101");
    form.render();


    // 判断字符
    form.verify({
        // equipmentId: function (value, item) {
        //     if (value.length > 30) {
        //         return "设备资源号不能超过30个字符";
        //     }
        // },
        deviceName: function (value, item) {
            if (value.length > 20) {
                return "终端名称不能超过20个字符,";
            }
        }
    });
    //
    // form.render();
    // //日期
    // laydate.render({
    // 	elem: '#invaldate',
    // 	format: 'yyyy-MM-dd',
    // 	//解决时间选择器一闪而过的情况
    // 	trigger: 'click',
    // });

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

    //选择设备资源号入口
    $("#onButtonEdit").click(function () {
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
                $("#accPointResName").val(data.accPointResName);
                top.layer.close(index);
                check();
                //因为对设备做唯一判断，故APPId验证重复，取消APPId验证
                // Exist();
            }
        });
    });


    <%--//判断APPId是否已存在--%>
    <%--function Exist() {--%>
    <%--    var APPId = $("#APPId").val();--%>

    <%--    if (APPId != null && APPId != "") {--%>
    <%--        $.ajax({--%>
    <%--            url: "<%= request.getContextPath() %>/equipment/device/check/isExist?APPId=" + APPId,--%>
    <%--            type: "GET",--%>
    <%--            cache: false,--%>
    <%--            contentType: "text/json",--%>
    <%--            cache: false,--%>
    <%--            success: function (text) {--%>
    <%--                if (text.code == "1") {--%>

    <%--                    isExist = true;--%>
    <%--                } else {--%>
    <%--                    isExist = false;--%>
    <%--                }--%>
    <%--            }--%>
    <%--        });--%>
    <%--    } else {--%>
    <%--        return;--%>
    <%--    }--%>
    <%--    console.log(isExist);--%>
    <%--};--%>


    //判断是否已存在终端软件类型对应更新包
    function deviceSoftwareType() {
        var deviceSoftwareType = $("#deviceSoftwareType").val();
        if (deviceSoftwareType != null && deviceSoftwareType != "") {
            $.ajax({
                url: "<%= request.getContextPath() %>/equipment/device/checkDST/isExist?deviceSoftwareType=" + deviceSoftwareType,
                type: "GET",
                cache: false,
                contentType: "text/json",
                cache: false,
                async: false,
                success: function (text) {
                    if (text.code == "1") {
                        isExistDSW = true;
                    } else {
                        isExistDSW = false;
                    }
                }
            });
        } else {
            return;
        }
        console.log(isExistDSW);
    };

    //判断设备是否已被注册
    function equipmentInt() {
        var equipemntInt = $("#equipmentInt").val();

        if (equipmentInt != null && equipmentInt != "") {
            $.ajax({
                url: "<%= request.getContextPath() %>/equipment/device/checkEquipment/isExist?equipmentInt=" + equipemntInt,
                type: "GET",
                cache: false,
                contentType: "text/json",
                cache: false,
                async: false,
                success: function (text) {
                    if (text.code == "1") {

                        isExistEQI = true;
                    } else {
                        isExistEQI = false;
                    }
                }
            });
        } else {
            return;
        }
        console.log(isExistEQI);
    };


    //监听提交
    form.on("submit(layuiadmin-app-form-submit)", function (data) {
        deviceSoftwareType();
        equipmentInt();
        if (submit == false) {
            submit = true;
            var submitData = JSON.stringify(data.field);
            if ( isExistDSW == false && isExistEQI == false) {
                $.ajax({
                    url: "<%= request.getContextPath() %>/equipment/device/registrationDevice",
                    type: "POST",
                    data: submitData,
                    cache: false,
                    contentType: 'text/json',
                    success: function (result) {
                        layer.msg("添加成功", {
                            icon: 1,
                            time: 2000
                        }, function () {
                            var index = top.layer.getFrameIndex(window.name);
                            win.layui.table.reload("LAY-app-device-list-reload");
                            win.window.formReder();
                            top.layer.close(index);
                            win.window.updata_select();
                        });
                    }
                });
            }
            //因为对设备注册做出唯一限制，故APPId的重复判断失效，弃用
            // else if (isExist == true && isExistDSW==false && isExistEQI == false) {
            //     layer.msg("APPId已存在，请重新选择正确的设备资源号与终端软件类型", {
            //         icon: 2,
            //         time: 2000
            //     });
            //     submit = false;
            // }
            else if ( isExistDSW==true && isExistEQI == false) {
                layer.msg("当前终端软件类型不存在更新包，请上传更新包后重试", {
                    icon: 2,
                    time: 2000
                });
                submit = false;
            }
            else if ( isExistDSW==false && isExistEQI == true) {
                layer.msg("当前选择设备已被注册，请选择未被注册设备", {
                    icon: 2,
                    time: 2000
                });
                submit = false;
            }
        } else {
            layer.msg("请检查该软件类型更新包是否上传以及选择设备是否已被注册");
        }
        return false;
    });
</script>
</body>
</html>