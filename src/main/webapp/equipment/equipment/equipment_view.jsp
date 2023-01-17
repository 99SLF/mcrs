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
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
             style="padding: 20px 30px 0 0;">
            <div class="layui-form-item layui-row layui-col-space10">
                <%--		需要隐藏主键--%>
                <input type="hidden" name="equipmentInt" value="default">
                <div class="layui-col-sm6">
                    <label class="layui-form-label">设备资源号:</label>
                    <div class="layui-input-block">
                        <input id="equipmentId" type="text" name="equipmentId" lay-verify="required|equipmentId"
                               placeholder="" autocomplete="off" class="layui-input" readonly>
                    </div>
                </div>
                <div class="layui-col-sm6">
                    <label class="layui-form-label">设备名称:</label>
                    <div class="layui-input-block">
                        <input id="equipmentName" type="text" name="equipmentName" lay-verify="required|equipmentName"
                               placeholder="" autocomplete="off" class="layui-input" readonly>
                    </div>
                </div>
            </div>

            <div class="layui-form-item layui-row layui-col-space10">
                <div class="layui-col-sm6">
                    <label class="layui-form-label">设备安装位置:</label>
                    <div class="layui-input-block">
                        <input id="equipmentInstallLocation" type="text" name="equipmentInstallLocation"
                               lay-verify="" placeholder="" autocomplete="off" class="layui-input" readonly>
                    </div>
                </div>
                <div class="layui-col-sm6">
                    <label class="layui-form-label">设备类型:</label>
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
                    <label class="layui-form-label">MES连接IP:</label>
                    <div class="layui-input-block">
                        <input id="mesIpAddress" type="text" name="mesIpAddress" lay-verify="required"
                               placeholder="" autocomplete="off" class="layui-input" readonly>
                    </div>
                </div>

                <div class="layui-col-sm6">
                    <label class="layui-form-label">支持通信协议:</label>
                    <div class="layui-input-block">
                        <input id="protocolCommunication" type="text" name="protocolCommunication" lay-verify="required"
                               placeholder="" autocomplete="off" class="layui-input" readonly>
                    </div>
                </div>
            </div>

            <div class="layui-form-item layui-row layui-col-space10">
                <div class="layui-col-sm6">
                    <label class="layui-form-label">设备连接端口:</label>
                    <div class="layui-input-block">
                        <input id="equipmentContinuePort" type="text" name="equipmentContinuePort" lay-verify="required"
                               placeholder="" autocomplete="off" class="layui-input" readonly>
                    </div>
                </div>

                <div class="layui-col-sm6">
                    <label class="layui-form-label">设备连接IP:</label>
                    <div class="layui-input-block">
                        <input id="equipmentIp" type="text" name="equipmentIp" lay-verify="required"
                               placeholder="" autocomplete="off" class="layui-input" readonly>
                    </div>
                </div>
            </div>

            <div class="layui-form-item layui-row layui-col-space10">
                <div class="layui-col-sm6">
                    <label class="layui-form-label">接入点名称:</label>
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
                    <label class="layui-form-label">工厂代码:</label>
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
                    <label class="layui-form-label">启用:</label>
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
                        <input id="createName" type="text" name="createName" lay-verify=""
                               placeholder="" autocomplete="off" class="layui-input" readonly>
                    </div>
                </div>

                <div class="layui-col-sm6">
                    <label class="layui-form-label">创建时间:</label>
                    <div class="layui-input-block">
                        <input id="createTime" type="text" name="createTime" lay-verify=""
                               placeholder="" autocomplete="off" class="layui-input" readonly>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-card-body">
            <h2>工位信息</h2>
            <div class="layui-card-body">
                <table id="workStation" lay-filter="workStation" class="layui-table " lay-skin="none"></table>
            </div>
        </div>
    </div>
</div>
<%--<script type="text/html" id="table-list">--%>
<%--    <button class="layui-btn layui-btn-primary layui-btn-xs layui-btn-disabled" title="新增" lay-event="add"><i--%>
<%--            class="layui-icon layui-icon-add-circle-fine layuiadmin-button-btn layui-btn-disabled"></i></button>--%>
<%--    <button class="layui-btn layui-btn-primary layui-btn-xs layui-btn-disabled" title="删除" lay-event="del"><i--%>
<%--            class="layui-icon layui-icon-reduce-circle layuiadmin-button-btn layui-btn-disabled"></i></button>--%>
<%--</script>--%>
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
    var table = layui.table;

    var isExistEIP = false;

    //全局参数
    var req_data;

    //功能名
    var funName = "list";

    var hiddenFields = [];

    //禁用启用下拉选择框
    layui.use('form', function () {
        var form = layui.form;
        $("#enable").attr("disabled", "disabled");
        form.render('select');
    });

    //禁用选择设备类型入口
    $('#selectequipType').addClass("layui-btn-disabled").attr("disabled", true);

    //禁用选择接入点资源入口
    $('#selectAcc').addClass("layui-btn-disabled").attr("disabled", true);


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
            "createName": data.createName,
            "createTime": layui.util.toDateString(data.createTime),
        });
        $.ajax({
            url: "<%=request.getContextPath() %>/equipment/equipment/workStation/get?equipmentInt=" + data.equipmentInt,
            type: "GET",
            async: false,
            cache: false,
            contentType: "text/json",
            success: function (result) {
                if (result) {
                    table.reload('workStation', {
                        data: result.data.workStationList,
                    });
                } else {
                    layer.msg("查询失败");
                }
            }
        });
        form.render();
    }

    form.render();

    table.on('sort(workStation)', function (obj) { //注：sort 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
        table.reload('workStation', {
            initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。
            , where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
                field: obj.field //排序字段
                , order: obj.type //排序方式
            }
        });

    });
    //查询过滤字段
    $.ajax({
        url: "<%=request.getContextPath() %>/cols/filter/query/" + funName,
        type: "GET",
        async: false,
        cache: false,
        contentType: "text/json",
        success: function (result) {
            if (result) {
                hiddenFields = result.data
            } else {
                layer.msg("查询失败");
            }
        }
    });

    //判断是否隐藏函数
    function isHidden(field) {
        for (var i = 0; i < hiddenFields.length; i++) {
            if (hiddenFields[i].field == field) {
                return true;
            }
        }
        return false;
    }

    function getFullSize() {
        var fluid = $(".layui-fluid");
        var header = $(".layui-card-header");
        var cardbody = $(".layui-card-body");
        return header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height()) + (fluid.outerHeight(true) - fluid.height()) + 2;
    }

    $(window).resize(function () {
        table.reload("workStation", {
            height: "full-" + getFullSize()
        });
    });

    table.on('toolbar(workStation)', function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });
    //监听按钮点击事件
    var active = {}


    var tables = table.render({
        elem: "#workStation",
        id: "workStation",
        data: [],
        limit: 99999,
        colHideChange: function (col, checked) {
            var field = col.field;
            var hidden = col.hide;
            $.ajax({
                url: "<%=request.getContextPath() %>/cols/filter/set?funName=" + funName + "&field=" + field + "&hidden=" + hidden,
                type: "GET",
                cache: false,
                contentType: "text/json",
                success: function (result) {
                    if (result) {
                    } else {
                        layer.msg("列筛选失败");
                    }
                }
            });
        },
        cols: [[{
            title: '序号',
            type: 'numbers',
            hide: false
        }, {
            field: "workStationNum",
            title: "工位代码",
            align: "center",
            minWidth: 200,
        }]],

    });
    var param = {
        "workStationNum": "",
    }
    var dataJson = [];
    dataJson.push(param);
    tables.reload({
        data: dataJson
    });

    // table.on("tool(workStation)", function (obj) {
    //     if (obj.event == 'add') {
    //         var Data = table.cache["workStation"];
    //         if (Data != null) {
    //         }
    //         var datas = {
    //             "workStationNum": "",
    //         }
    //         Data.push(datas);
    //         tables.reload({
    //             data: Data
    //         });
    //     } else if (obj.event == "del") {
    //         var Data = table.cache["workStation"];
    //         if (Data.length > 1) {
    //             if (obj.tr.data("index") > -1) {
    //                 Data.splice(obj.tr.data("index"), 1);	//根据索引删除当前行
    //             }
    //
    //         } else {
    //             Data[0].workStationNum = "";
    //         }
    //         tables.reload({
    //             data: Data
    //         });
    //     }
    // })
</script>
</body>
</html>