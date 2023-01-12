<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.zimax.cap.party.IUserObject" %>
<%@ page import="com.zimax.cap.datacontext.DataContextManager" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 林俊杰
  - Date: 2022-12-01 16:10:17
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>设备添加</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>设备资源号:</label>
            <div class="layui-input-block">
                <input id="equipmentId" type="text" name="equipmentId" lay-verify="required|equipmentId"
                       placeholder="请输入设备资源号(必填)" autocomplete="off" class="layui-input">
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
                       lay-verify="required|equipmentInstallLocation" placeholder="请输入设备安装位置" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>设备类型:</label>
            <div class="layui-input-block">
                <input id="equipTypeId" name="equipTypeId" type="hidden"/>
                <input type="text" class="layui-input" name="equipTypeName" id="equipTypeName"
                       lay-verify="required"
                       autocomplete="off" placeholder="" readonly>
                <button type="button" class="layui-btn layui-btn-sm layui-btn-primary" id="selectequipType"
                        style="position:absolute;top:0px;right:0px;height:37px"><i
                        class="layui-icon layui-icon-more"></i></button>
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
                <input id="equipmentContinuePort" type="text" name="equipmentContinuePort" lay-verify="required|number|equipmentContinuePort"
                       placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>设备连接IP:</label>
            <div class="layui-input-block">
                <input id="equipmentIp" type="text" name="equipmentIp" lay-verify="required|equipmentIp"
                       placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>接入点名称:</label>
            <div class="layui-input-block">
                <input id="accPointResId" name="accPointResId" type="hidden"/>
                <input type="text" class="layui-input" name="accPointResName" id="accPointResName"
                       lay-verify="required"
                       autocomplete="off" placeholder="" readonly>
                <button type="button" class="layui-btn layui-btn-sm layui-btn-primary" id="selectAcc"
                        style="position:absolute;top:0px;right:0px;height:37px"><i
                        class="layui-icon layui-icon-more"></i></button>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">基地代码:</label>
            <div class="layui-input-block">
                <input id="matrixCode" type="text" name="matrixCode" lay-verify=""
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
                <input id="processName" type="text" name="processName" lay-verify=""
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
                      class="layui-input" lay-verify="remarks" placeholder="备注不能超过255字符"></textarea>
            </div>
        </div>
    </div>

    <div class="layui-input-block">
        <%
            IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();
        %>
        <%--                <input type="text" class="layui-hide" name="creator" value="<%=usetObject.getUserId()%>"/>--%>
        <%--				显示当前用户名--%>
        <input type="text" class="layui-hide" name="creator" value="<%=usetObject.getUserName()%>"
               readonly/>
    </div>


    <div class="layui-input-block">
        <input type="text" class="layui-hide" name="createTime"
               value="<%=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date())%>" readonly/>
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
    var win = null;

    function SetData(data) {
        win = data.win ? data.win : window;
    }
    //
    // //获取设备类型的下拉值
    // layui.admin.getDictText("ORDER_STATUS",data.orderStatus);
    // layui.admin.renderDictSelect({
    //     elem: "#equipTypeName",
    //     dictTypeId: "EQUIPMENT_PROPERTY",
    // });
    // form.render();


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
        equipmentId: function (value, item) {
            if (value.length > 20) {
                return "设备资源号不能超过20字符";
            }
        },
        equipmentName: function (value, item) {
            if (value.length > 20) {
                return "设备名称不能超过20字";
            }
        },
        equipmentInstallLocation: function (value, item) {
            if (value.length > 50) {
                return "设备安装位置不能超过50字";
            }
        },
        equipmentContinuePort: function (value, item) {
            if (value.length > 20) {
                return "设备连接端口不能超过20字";
            }
        },
        equipmentIp: function (value, item) {
            if (value.length > 20) {
                return "设备连接IP不能超过20个字符";
            }
        },
        remarks: function (value, item) {
            if (value.length > 255) {
                return "备注不能超过255个字符";
            }
        }
    });

    form.render();

    //选择设备类型入口
    $("#selectequipType").click(function () {
        top.layer.open({
            type: 2,
            title: "选择设备类型",
            area: ["850px", "470px"],
            btn: ["确定", "取消"],
            content: "<%= request.getContextPath() %>/basic/equipType/equipType_select.jsp",
            yes: function (index, layero) {
                var data = layero.find('iframe')[0].contentWindow.getData();
                $("#equipTypeId").val(data.equipTypeId);
                $("#equipTypeName").val(layui.admin.getDictText("EQUIPMENT_PROPERTY",data.equipTypeName));
                $("#mesIpAddress").val(data.mesIpAddress);
                $("#protocolCommunication").val(data.protocolCommunication);
                top.layer.close(index);
                check();
                Exist();
            }
        });
    });

    //选择接入点资源入口
    $("#selectAcc").click(function () {
        top.layer.open({
            type: 2,
            title: "选择接入点资源",
            area: ["850px", "470px"],
            btn: ["确定", "取消"],
            content: "<%= request.getContextPath() %>/basic/accPointResMaintain/accPointRes_select.jsp",
            yes: function (index, layero) {
                var data = layero.find('iframe')[0].contentWindow.getData();
                $("#accPointResId").val(data.accPointResId);
                $("#accPointResName").val(data.accPointResName);
                $("#matrixCode").val(data.matrixCode);
                $("#factoryCode").val(data.factoryCode);
                $("#processName").val(data.processName);
                top.layer.close(index);
                check();
            }
        });
    });

    //判断设备资源号是否已存在
    $("#equipmentId").blur(function () {
        var equipmentId = $("#equipmentId").val();
        if (equipmentId != null && equipmentId != "") {
            $.ajax({
                url: "<%= request.getContextPath() %>/equipment/equipment/check/isExist?equipmentId=" + equipmentId,
                type: "GET",
                cache: false,
                contentType: "text/json",
                cache: false,
                success: function (text) {
                    if (text.code == "1") {
                        isExist = true;
                    } else {
                        isExist = false;
                    }
                }
            });
        } else {
            return;
        }
    });

    //监听提交

    form.on("submit(layuiadmin-app-form-submit)", function (data) {
        if (submit == false) {
            submit = true;
            var submitData = JSON.stringify(data.field);
            if (isExist == false) {
                $.ajax({
                    url: "<%= request.getContextPath() %>/equipment/equipment/add",
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
                            win.layui.table.reload("LAY-app-equipment-list-reload");
                            top.layer.close(index);
                            win.window.updata_select();
                        });
                    }
                });
            } else if (isExist == true) {
                layer.msg("设备资源号已存在，请重新输入", {
                    icon: 2,
                    time: 2000
                });
                submit = false;
            }
        } else {
            layer.msg("正在添加...请稍等！");
        }
        return false;
    });
</script>
</body>
</html>