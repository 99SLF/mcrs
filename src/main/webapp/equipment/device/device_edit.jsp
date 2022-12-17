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
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <div class="layui-form-item layui-row layui-col-space10">
        <%--	需要隐藏主键	--%>
        <input type="hidden" name="deviceId" value="default">
        <div class="layui-col-sm6">
            <label class="layui-form-label">APPID:<span style="color:red">*</span></label>
            <div class="layui-input-block">
                <input id="APPId" type="text" name="APPId" lay-verify="" placeholder="" autocomplete="off"
                       class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">终端名称:<span style="color:red">*</span></label>
            <div class="layui-input-block">
                <input id="deviceName" type="text" name="deviceName" lay-verify="required|deviceName" placeholder=""
                       autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">终端软件类型:<span style="color:red">*</span></label>
            <div class="layui-input-block">
                <select name="deviceSoftwareType" id="deviceSoftwareType" lay-filter="" type="select"  >
                    <option value=""></option>
                </select>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">是否启用：</label>
            <div class="layui-input-block">
                <select name="enable" id="enable" lay-filter="" type="select">
                    <option value="on">是</option>
                    <option value="off">否</option>
                </select>
            </div>
        </div>

        <%--        后续会添加，暂时保留--%>
        <%--        <div class="layui-col-sm4">--%>
        <%--            <label class="layui-form-label">接入点名称:<span style="color:red">*</span></label>--%>
        <%--            <div class="layui-input-block">--%>
        <%--                <input id="equipmentName" type="text" name="equipmentName" lay-verify="required|equipmentName" placeholder=""--%>
        <%--                       autocomplete="off" class="layui-input" readonly>--%>
        <%--            </div>--%>
        <%--        </div>--%>
        <%--        <div class="layui-col-sm4">--%>
        <%--            <label class="layui-form-label">接入点种类:<span style="color:red">*</span></label>--%>
        <%--            <div class="layui-input-block">--%>
        <%--                <input id="assessType" type="text" name="assessType" lay-verify="require|assessType" placeholder=""--%>
        <%--                       autocomplete="off" class="layui-input" value="test" readonly>--%>
        <%--            </div>--%>
        <%--        </div>--%>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">接入点资源号:<span style="color:red">*</span></label>
            <div class="layui-input-block">
                <input id="equipmentInt" name="equipmentInt" type="hidden"/>
                <input type="text" class="layui-input"  name="equipmentId" id="equipmentId"
                       lay-verify=""
                       autocomplete="off" placeholder="" readonly>
                <button type="button" class="layui-btn layui-btn-sm layui-btn-primary" id="onButtonEdit"
                        style="position:absolute;top:0px;right:0px;height:37px"><i
                        class="layui-icon layui-icon-more"></i></button>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">接入点IP:</label>
            <div class="layui-input-block">
                <input id="mesContinueIp" type="text" name="mesContinueIp" lay-verify="assessIp" placeholder=""
                       autocomplete="off"
                       class="layui-input" readonly>
            </div>
        </div>

    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">接入点属性:<span style="color:red">*</span></label>
            <div class="layui-input-block">
                <input id="equipmentProperties" type="text" name="equipmentProperties" lay-verify="assessAttributes"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label" >接入点安装位置:</label>
            <div class="layui-input-block">
                <input id="equipmentInstallLocation" type="text" name="equipmentInstallLocation"
                       lay-verify="assessInstallLocation" placeholder="" autocomplete="off" class="layui-input"
                        readonly>
            </div>
        </div>
        <%--        暂时保留，后续会添加--%>
        <%--        <div class="layui-col-sm4">--%>
        <%--            <label class="layui-form-label">工厂名称:</label>--%>
        <%--            <div class="layui-input-block">--%>
        <%--                <input id="factoryName" type="text" name="factoryName" lay-verify="factoryName" placeholder=""--%>
        <%--                       autocomplete="off" class="layui-input">--%>
        <%--            </div>--%>
        <%--        </div>--%>
        <%--        <div class="layui-col-sm4">--%>
        <%--            <label class="layui-form-label">接入方式:<span style="color:red">*</span></label>--%>
        <%--            <div class="layui-input-block">--%>
        <%--                <input id="accessMethod" type="text" name="accessMethod" lay-verify="required|accessMethod"--%>
        <%--                       placeholder="" autocomplete="off" class="layui-input">--%>
        <%--            </div>--%>
        <%--        </div>--%>

    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm12">
            <label class="layui-form-label">备注:</label>
            <div class="layui-input-block">
            <textarea cols="50" rows="10" style="width:100%;height:100px" name="remarks" id="remarks" autocomplete="off"
                      class="layui-input" lay-verify="remarks"></textarea>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space12" style="padding-top: 30px">
        <%--			<label class="layui-form-label">修改人:</label>--%>
        <div class="layui-input-block">
            <%
                IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();
            %>
            <input type="text" class="layui-hide" name="updater" value="<%=usetObject.getUserName()%>"
                   readonly/>
        </div>
        <%--			<label class="layui-form-label">修改时间:</label>--%>
        <div class="layui-input-block">
            <input type="text" class="layui-hide" name="updateTime"
                   value="<%=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date())%>" readonly/>
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
    layui.use('form', function(){
        var form = layui.form;
        $("#deviceSoftwareType").attr("disabled","disabled");
        form.render('select');
    });

    $('#onButtonEdit').addClass("layui-btn-disabled").attr("disabled",true);

    function SetData(data) {
        win = data.win ? data.win : window;
        var data = data.data;
        form.val("layuiadmin-app-form-list", {
            "APPId": data.aPPId,
            "deviceId": data.deviceId,
            "deviceName": data.deviceName,
            "deviceSoftwareType": data.deviceSoftwareType,
            "equipmentName": data.equipmentName,
            "mesContinueIp": data.mesContinueIp,
            "equipmentId": data.equipmentId,
            "equipmentInt": data.equipmentInt,
            "equipmentProperties": data.equipmentProperties,
            "equipmentInstallLocation": data.equipmentInstallLocation,
            "factoryName": data.factoryName,
            "equipmentContinuePort": data.equipmentContinuePort,
            "enable": data.enable,
            "remarks": data.remarks,
        });
    }

    //获取软件类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#deviceSoftwareType",
        dictTypeId: "SOFTWARE_TYPE",
    });
    //设置软件类型的默认值
    form.render();


    //判断字符
    form.verify({
        deviceName: function (value, item) {
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
        }

    });

    //选择设备资源号入口
    $("#onButtonEdit").click(function () {
        top.layer.open({
            type: 2,
            title: "选择设备资源",
            area: ["850px", "470px"],
            btn: ["确定", "取消"],
            content: "<%= request.getContextPath() %>/equipment/device/device_equipment.jsp",
            yes: function (index, layero) {
                var data = layero.find('iframe')[0].contentWindow.getData();
                $("#equipmentInt").val(data.equipmentInt);
                $("#equipmentId").val(data.equipmentId);
                $("#equipmentName").val(data.equipmentName);
                $("#mesContinueIp").val(data.mesContinueIp);
                $("#equipmentProperties").val(data.equipmentProperties);
                $("#equipmentInstallLocation").val(data.equipmentInstallLocation);
                top.layer.close(index);
            }
        });
    });
    form.render();
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
        debugger;
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