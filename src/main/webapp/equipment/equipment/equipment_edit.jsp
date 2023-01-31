<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 林俊杰
  - Date: 2022-12-01 16:10:42
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>设备编辑</title>
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
                               lay-verify="" placeholder="请输入设备安装位置" autocomplete="off" class="layui-input"
                               readonly>
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
                      class="layui-input" lay-verify="remarks"></textarea>
                    </div>
                </div>
            </div>
            <div class="layui-form-item layui-hide">
                <input type="button" lay-submit lay-filter="layuiadmin-app-form-edit" id="layuiadmin-app-form-edit"
                       value="确认修改">
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
<script type="text/html" id="table-list">
    <button class="layui-btn layui-btn-primary layui-btn-xs" title="新增" lay-event="add"><i
            class="layui-icon layui-icon-add-circle-fine layuiadmin-button-btn"></i></button>
    <button class="layui-btn layui-btn-primary layui-btn-xs" title="删除" lay-event="del"><i
            class="layui-icon layui-icon-reduce-circle layuiadmin-button-btn"></i></button>
</script>
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
    var equipmentInt=null;

    var table = layui.table;

    var isExistEIP = false;

    //全局参数
    var req_data;

    //功能名
    var funName = "list";

    var hiddenFields = [];


    //获取启用类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#enable",
        dictTypeId: "IS_USE",
    });
    form.render();

    function SetData(data) {
        debugger;
        win = data.win ? data.win : window;
        var data = data.data;
        equipmentInt = data.equipmentInt;
        form.val("layuiadmin-app-form-list", {
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
                    win.window.formReder();
                } else {
                    layer.msg("查询失败");
                }
            }
        });
        form.render();
    }

    //禁用选择设备类型入口
    $('#selectequipType').addClass("layui-btn-disabled").attr("disabled", true);

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
                $("#equipTypeName").val(data.equipTypeName);
                $("#mesIpAddress").val(data.mesIpAddress);
                $("#protocolCommunication").val(data.protocolCommunication);
                top.layer.close(index);
                check();
            }
        });
    });

    //禁用选择接入点资源入口
    $('#selectAcc').addClass("layui-btn-disabled").attr("disabled", true);
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
                Exist();
            }
        });
    });

    //判断字符
    form.verify({
        equipmentId: function (value, item) {
            if (value.length > 20) {
                return "设备资源号不能超过20个字符";
            }
        },
        equipmentName: function (value, item) {
            if (value.length > 20) {
                return "设备名称不能超过20个字符";
            }
        },
        equipmentIp: function(value, item){
            function isValidIP(ip) {
                var reg = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/
                return reg.test(ip);
            }
            if(isValidIP(value) == false){
                return '请输入正确的IP地址';
            }
        },
        equipmentInstallLocation: function (value, item) {
            if (value.length > 20) {
                return "设备安装位置不能超过20字符";
            }
        },
        equipmentContinuePort: function (value, item) {
            if (value.length > 20) {
                return "设备连接端口不能超过20字符";
            }
        },
        mesContinueIp: function (value, item) {
            if (value.length > 30) {
                return "MES连接IP不能超过30字符";
            }
        },
        remarks: function (value, item) {
            if (value.length > 255) {
                return "备注不能超过255个字符";
            }
        }
    });

    form.render();

    //判断设备连接Ip是否已被占用
    $("#equipmentIp").blur(function () {
        var equipmentIp = $("#equipmentIp").val();
        if (equipmentIp != null && equipmentIp != "") {
            $.ajax({
                url: "<%= request.getContextPath() %>/equipment/equipmentIp/check/isExist?equipmentIp=" + equipmentIp + "&equipmentInt=" + equipmentInt,
                type: "GET",
                cache: false,
                contentType: "text/json",
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
    form.on("submit(layuiadmin-app-form-edit)", function (data) {
        var equipment = data.field;
        if (submit == false) {
            submit = true;
            var workStationLists = table.cache['workStation'];
            if (workStationLists.length == 1 &&  workStationLists[0].workStationNum == "") {
                equipment.workStationList = '';
            } else {
                equipment.workStationList = workStationLists;
                var i;
                for (i = 0; i < workStationLists.length; i++) {
                    if (workStationLists[i].workStationNum == null || workStationLists[i].workStationNum == "") {
                        layer.msg("工位数据存在空值，请检查输入的工位数据");
                        submit = false;
                        return;
                    }
                }
            }
            var submitData = JSON.stringify(equipment);
            if (isExist == false) {
                $.ajax({
                    url: "<%= request.getContextPath() %>/equipment/equipment/update",
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
                            win.layui.table.reload("LAY-app-equipment-list-reload");
                            win.window.formReder();
                            top.layer.close(index);
                        });
                    }
                });
            }
        } else if (isExist == true) {
            layer.msg("当前输入IP已被占用，请重新输入正确IP", {
                icon: 2,
                time: 2000
            });
            submit = false;
        } else {
            layer.msg("请稍等");
        }
        return false;
    });

    table.on('sort(workStation)', function (obj) { //注：sort 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
        table.reload('workStation', {
            initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。
            , where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
                field: obj.field //排序字段
                , order: obj.type //排序方式
            }
        });
        win.window.formReder();
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
        win.window.formReder();
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
            edit: 'text',
            minWidth: 200,
        }, {
            title: "操作",
            align: "center",
            fixed: "right",
            width: 120,
            toolbar: "#table-list"
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

    table.on("tool(workStation)", function (obj) {
        if (obj.event == 'add') {
            var Data = table.cache["workStation"];
            if (Data != null) {
            }
            var datas = {
                "workStationNum": "",
            }
            Data.push(datas);
            tables.reload({
                data: Data
            });
        } else if (obj.event == "del") {
            var Data = table.cache["workStation"];
            if (Data.length > 1) {
                if (obj.tr.data("index") > -1) {
                    Data.splice(obj.tr.data("index"), 1);	//根据索引删除当前行
                }

            }else {
                Data[0].workStationNum="";
            }
            tables.reload({
                data: Data
            });
        }
    })
    //单击行事件
    $('body').on("click", ".layui-table-body table.layui-table tbody tr td", function () {
        if ($(this).attr("data-field") === "0")
            return;
        $(this).siblings().eq(0).find('i').click();
    });
</script>
</body>
</html>