<!--
- Author(s): 李伟杰
- Date: 2022-12-05 14:08:11
- Description:
-->
<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>终端状态</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/common/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/std/dist/style/admin.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/std/dist/style/custom.css?v=1.0.0">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/iconfont/iconfont.css">
    <style>
        .layui-card {
            margin-bottom: 0px
        }

        .layui-layer-adminRight {
            top: 0px !important;
            bottom: 0;
            box-shadow: 1px 1px 10px rgba(0, 0, 0, .1);
            border-radius: 0;
            overflow: auto
        }

        .layui-form-item .layui-inline {
            margin-bottom: 0px !important;
            margin-right: 0px !important;
        }

        .layui-form-label {
            width: 120px !important;
            padding: 5px 0px !important;
        }

        .layui-form-item .layui-input-inline {
            float: left;
            width: 150px;
            margin-right: 10px;
        }

        .layui-input {
            height: 30px !important;
        }
    </style>
</head>
<body>
<div class="layui-card">
    <script type="text/html" id="toolbar">
        <div class="layui-form layuiadmin-card-header-auto"
             lay-filter="layuiadmin-device_status-form" id="layuiadmin-device_status-form">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">设备资源号：</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="equipmentId" autocomplete="off">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">终端状态：</label>
                    <div class="layui-input-inline">
                        <select name="deviceStatus" id="deviceStatus" lay-filter="deviceStatus"
                                type="select">
                            <option value="">请选择</option>
                            <option value="101">正常</option>
                            <option value="102">异常</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">终端名称：</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="deviceName" autocomplete="off">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">终端类型：</label>
                    <div class="layui-input-inline">
                        <select name="deviceSoftwareType" id="deviceSoftwareType" lay-filter="deviceSoftwareType"
                                type="select">
                            <option value=""></option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline layui-hide">
                    <button id="LAY-app-device_status-search" class="layui-btn layuiadmin-btn-list" lay-submit
                            lay-filter="LAY-app-device_status-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
    </script>
    <div class="layui-card-body">
        <table id="LAY-app-device_status-list" lay-filter="LAY-app-device_status-list"></table>
    </div>
</div>
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script>
    layui.config({
        base: "<%=request.getContextPath()%>/"
    });
    jQuery = layui.$;
</script>
<%--字典--%>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
<script type="text/javascript"
        src="<%=request.getContextPath()%>/common/components/websocket/jquery.loadJSON.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/common/components/websocket/WebSocket.js"></script>
<script type="text/javascript"
        src="<%=request.getContextPath()%>/common/components/websocket/jquery.WebSocket.js"></script>
<script type="text/javascript">
    var layer = layui.layer;
    var table = layui.table;
    var form = layui.form;
    var $ = layui.jquery;
    var util = layui.util;
    var admin = layui.admin;
    var view = layui.view;

    //websocket引用
    var $ = layui.$;
    // 过滤字段
    var hiddenFields = [];
    // 功能名
    var funName = "device_status_list";
    // 高级查询参数
    var advancedFormData = {};
    // 焦点名称
    var focusName = null;

    //获取软件类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#deviceSoftwareType",
        dictTypeId: "DEVICE_SOFTWARE_TYPE",
    });

    form.render();
    //获取软件运行状态
    layui.admin.renderDictSelect({
        elem: "#deviceSoftwareStatus",
        dictTypeId: "DEVICE_SOFTWARE_STATUS",
    });
    form.render();
    //接入状态
    layui.admin.renderDictSelect({
        elem: "#accessStatus",
        dictTypeId: "EQUIPMENT_ACCESS_STATUS",
    });
    form.render();

    // 监听搜索
    form.on("submit(LAY-app-device_status-search)", function (data) {
        var field = data.field;
        reloadData(field);
        var formData = {
            equipmentId: field.equipmentId,
            deviceName: field.deviceName,
            deviceStatus: field.deviceStatus,
            deviceSoftwareType: field.deviceSoftwareType
        };
        form.val("layuiadmin-device_status-form", formData);
        advancedFormData = $.extend(advancedFormData, formData);
    });


    function reloadData(formData) {
        //读取表格数据 表格id
        table.reload("LAY-app-device_status-list-reload", {
            where: formData,
            page: {
                curr: 1
            }
        });
        formReder();
        if (focusName) {
            $("input[name=" + focusName + "]").focus();
        }
    }

    function setFormData(data) {
        advancedFormData = data;
        reloadData(data);
        form.val("layuiadmin-device_status-form", {
            equipmentId: data.equipmentId,
            deviceName: data.deviceName,
            deviceSoftwareType: field.deviceSoftwareType,
            deviceSoftwareType: data.deviceSoftwareType
        });
    }

    function getFullSize() {
        var header = $(".layui-card-header");
        var cardbody = $(".layui-card-body");
        return header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height()) + 1;
    }

    // 监听按钮点击事件
    var active = {
        search: function () {
            var submit = $("#LAY-app-device_status-search");
            submit.click();
            return false;
        },
        query: function () {
            var url = "<%=request.getContextPath() %>/monitor/device_status_form_query.jsp";
            admin.popupRight({
                type: 2,
                content: [url, "yes"],
                btn: ["查询", "重置", "取消"],
                success: function (layero, index) {
                    var dataJson = {
                        win: window,
                        data: advancedFormData
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {
                    var submit = layero.find("iframe").contents().find("#LAY-app-device_status-search-advanced");
                    submit.click();
                    top.layer.close(index);
                },
                btn2: function (index, layero) {
                    layero.find("iframe")[0].contentWindow.reset();
                }
            });
        }
    };

    // 右侧表头按钮事件监听
    table.on("toolbar(LAY-app-device_status-list)", function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    // 表格排序
    table.on("sort(LAY-app-device_status-list)", function (obj) {
        table.reload("LAY-app-device_status-list-reload", {
            initSort: obj,
            where: {
                field: obj.field,
                order: obj.type
            }
        });
    });

    // 查询过滤字段
    $.ajax({
        url: "<%=request.getContextPath() %>/cols/filter/query/" + funName,
        type: "GET",
        async: false,
        cache: false,
        contentType: "text/json",
        success: function (result) {
            if (result) {
                hiddenFields = result.data;
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


    table.render({
        elem: "#LAY-app-device_status-list",
        id: "LAY-app-device_status-list-reload",
        url: "<%= request.getContextPath() %>/DeviceRuntime/query",
        method: "GET",
        height: "full-" + getFullSize(),
        page: true,
        limit: 30,
        toolbar: "#toolbar",
        defaultToolbar: [{
            title: "查询",
            layEvent: "search",
            icon: "layui-icon layui-icon-search layuiadmin-button-btn",
        }, "filter"],
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
        limits: [30, 50, 70, 100],
        parseData: function (res) {
            return {
                code: res.code,
                msg: res.msg,
                count: res.total,
                data: res.data
            };
        },
        //设置表头。值是一个二维数组。方法渲染方式必填
        cols: [[{
            type: "checkbox",
        }, {
            title: "序号",
            type: "numbers",
        }, {
            field: "equipmentId",
            title: "设备资源号",
            align: "center",
            // sort: true,
            hide: isHidden("equipmentId"),
            minWidth: 150
        }, {
            field: "deviceName",
            title: "终端名称",
            align: "center",
            // sort: true,
            hide: isHidden("deviceName"),
            minWidth: 150
        }, {
            field: "equipmentIp",
            title: "设备IP",
            align: "center",
            // sort: true,
            hide: isHidden("equipmentIp"),
            minWidth: 150
        },{
            field: "deviceSoftwareType",
            title: "终端类型",
            align: "center",
            hide: isHidden("deviceSoftwareType"),
            minWidth: 150,
            templet: function (d) {

                return layui.admin.getDictText("DEVICE_SOFTWARE_TYPE", d.deviceSoftwareType);
            }
        }, {
            field: "deviceStatus",
            title: "终端状态",
            align: "center",
            // sort: true,
            hide: isHidden("deviceStatus"),
            minWidth: 150,
            templet: function (d) {
                if (d.deviceStatus == "101") {

                    return '<span class="layui-badge-dot layui-bg-green"></span>' + "  " + '<span style="color:green">' + "正常" + '</span>';

                } else if (d.deviceStatus == "102") {
                    return '<span class="layui-badge-dot"></span>' + "  " + '<span style="color:red">' + "异常" + '</span>';

                } else {
                    return "";
                }
            }
        }, {
            field: "deviceSoftwareStatus",
            title: "软件运行状态",
            align: "center",
            hide: isHidden("deviceSoftwareStatus"),
            minWidth: 150,
            templet: function (d) {
                var deviceSoftwareStatus = layui.admin.getDictText("DEVICE_SOFTWARE_STATUS", d.deviceSoftwareStatus);
                if (d.deviceSoftwareStatus == "100") {

                    return '<span class="layui-badge-dot layui-bg-orange"></span>' + "  " + '<span style="color:orange">' + deviceSoftwareStatus + '</span>';

                } else if (d.deviceSoftwareStatus == "101") {

                    return '<span class="layui-badge-dot layui-bg-green"></span>' + "  " + '<span style="color:green">' + deviceSoftwareStatus + '</span>';

                } else if (d.deviceSoftwareStatus == "102") {
                    return '<span class="layui-badge-dot"></span>' + "  " + '<span style="color:red">' + deviceSoftwareStatus + '</span>';

                } else {
                    return "";
                }
            }
        }, {
            //field:设定字段名。字段名的设定非常重要，且是表格数据列的唯一标识;title:设定标题名称
            field: "plcStatus",
            title: "PLC接入状态",
            align: "center",
            minWidth: 150,
            hide: isHidden("plcStatus"),
            templet: function (d) {
                var plcStatus = layui.admin.getDictText("EQUIPMENT_ACCESS_STATUS", d.plcStatus);
                if (d.plcStatus == "101") {

                    return '<span class="layui-badge-dot layui-bg-green"></span>' + "  " + '<span style="color:green">' + plcStatus + '</span>';

                } else if (d.plcStatus == "102") {
                    return '<span class="layui-badge-dot"></span>' + "  " + '<span style="color:red">' + plcStatus + '</span>';

                } else if (d.plcStatus == "100") {

                    return '<span class="layui-badge-dot layui-bg-orange"></span>' + "  " + '<span style="color:orange">' + plcStatus + '</span>';

                } else {
                    return ""
                }
            }

        }, {
            //field:设定字段名。字段名的设定非常重要，且是表格数据列的唯一标识;title:设定标题名称
            field: "rfidStatus",
            title: "RFID接入状态",
            align: "center",
            minWidth: 150,
            hide: isHidden("rfidStatus"),
            templet: function (d) {
                var rfidStatus = layui.admin.getDictText("EQUIPMENT_ACCESS_STATUS", d.rfidStatus);
                if (d.rfidStatus == "101") {

                    return '<span class="layui-badge-dot layui-bg-green"></span>' + "  " + '<span style="color:green">' + rfidStatus + '</span>';

                } else if (d.rfidStatus == "102") {
                    return '<span class="layui-badge-dot"></span>' + "  " + '<span style="color:red">' + rfidStatus + '</span>';

                } else if (d.rfidStatus == "100") {

                    return '<span class="layui-badge-dot layui-bg-orange"></span>' + "  " + '<span style="color:orange">' + rfidStatus + '</span>';

                } else {
                    return "";
                }
            }
        },
            //{
            //     field: "deviceWarningNum",
            //     title: "累计终端告警",
            //     align: "center",
            //     hide: isHidden("deviceWarningNum"),
            //     minWidth: 150
            // }, {
            //     field: "cpuRate",
            //     title: "cup使用率",
            //     align: "center",
            //     hide: isHidden("cpuRate"),
            //     minWidth: 150
            // }, {
            //     field: "storageRate",
            //     title: "内存使用率",
            //     align: "center",
            //     hide: isHidden("storageRate"),
            //     minWidth: 150
            // }, {
            //     field: "errorRate",
            //     title: "误读率",
            //     align: "center",
            //     hide: isHidden("errorRate"),
            //     minWidth: 150
            // },
            {
                field: "softMonitorTime",
                title: "发生时间",
                align: "center",
                hide: isHidden("softMonitorTime"),
                minWidth: 200,
                templet: function (d) {
                    return d.softMonitorTime == null ? "" : util.toDateString(d.softMonitorTime, 'yyyy-MM-dd HH:mm:ss');
                }
            }]]
    });
    var host = window.location.host;
    var port = host.split(":");
    var json = ""
    var contextPath = "<%=request.getContextPath() %>";
    contextPath = contextPath.substring(1);

    //判断当前浏览器是否支持WebSocket
    var deviceStatus = new $.websocket({
        protocol: contextPath + "/websocket/device_status",
        domain: port[0],
        port: port[1],
        onOpen: function (event) {
        },
        onError: function (event) {
        },
        onMessage: function (event) {
            json = JSON.parse(event.data);
            //测试修改数据的方法!
            //$("tr:eq(1)  td:eq(2)"):这代表了要选中表格的第二行中的第三个单元格
            //如果在后面再加上.text() 代表要取出这个单元格中的文本。
            //html()方法返回被选元素的内容，即括号内未设置参数。若设置参数，返回设置参数的内容。并且该参数内容覆盖所有想匹配的元素的内容,参数可为函数，即function(index,dcontent)
            // $("p").html("AAA");所有p标签的内容变为：AAA

            var _trs = $(".layui-table-body.layui-table-main:eq(0) tbody:eq(0)").children();

            function find(tr, equipmentId) {
                var _tds = $(tr).children();
                var bool = false;
                _tds.each(function (j) {
                    var _td = _tds[j];
                    var dataField = $(_td).attr("data-field");
                    if (dataField === "equipmentId") {
                        if ($($(_td).children()[0]).html() === equipmentId) {
                            bool = true;
                        }
                    }
                });
                return bool;
            }

            function update(tr, json) {
                var _tds = $(tr).children();
                _tds.each(function (j) {
                    var _td = _tds[j];
                    var dataField = $(_td).attr("data-field");
                    switch (dataField) {
                        case "plcStatus":
                            var plcStatus = layui.admin.getDictText("EQUIPMENT_ACCESS_STATUS", json.plcStatus)
                            change(json.plcStatus,_td,plcStatus);
                            break;

                        case "deviceSoftwareStatus":
                            var deviceSoftwareStatus = layui.admin.getDictText("DEVICE_SOFTWARE_STATUS", json.deviceSoftwareStatus)
                            change(json.deviceSoftwareStatus,_td,deviceSoftwareStatus);
                            break;
                        case "rfidStatus":
                            var rfidStatus = layui.admin.getDictText("EQUIPMENT_ACCESS_STATUS", json.rfidStatus)
                            change(json.rfidStatus,_td,rfidStatus);
                            break;
                        case "deviceStatus":
                            var  deviceStatus;
                            var   value;
                            if(json.deviceSoftwareStatus=="101" && json.plcStatus=="101"&& json.rfidStatus=="101"&&json.deviceSoftwareStatus=="101"){
                              deviceStatus="101";
                                value = "正常";
                            }else{
                                 deviceStatus="102";
                                   value = "异常";
                            }
                            change(deviceStatus,_td,value);
                            break;
                        case "softMonitorTime":
                            $($(_td).children()[0]).html(json.softMonitorTime==null?"":util.toDateString(json.softMonitorTime, 'yyyy-MM-dd HH:mm:ss'));
                            break;
                    }
                });
            }

            _trs.each(function (i) {
                var _tr = _trs[i];
                if (find(_tr, json.resource)) {
                    update(_tr, json);
                }

            });
        },
        onClose: function (event) {
            deviceStatus = null;
        }
    });


    formReder();

    function formReder() {
        // 文本框回车事件
        $(".layui-input").on("keydown", function (event) {
            if (event.keyCode == 13) {
                focusName = event.target.name;
                var submit = $("#LAY-app-device_status-search");
                submit.click();
                return false;
            }
        });

        //软件类型下拉框监听事件
        form.on("select(deviceSoftwareType)", function (data) {
            var submit = $("#LAY-app-device_status-search");
            submit.click();
        });
        form.on("select(deviceStatus)", function (data) {
            var submit = $("#LAY-app-device_status-search");
            submit.click();
        });

        //获取软件类型的下拉值
        layui.admin.renderDictSelect({
            elem: "#deviceSoftwareType",
            dictTypeId: "DEVICE_SOFTWARE_TYPE",
        });
        form.render();
        //获取软件运行状态
        layui.admin.renderDictSelect({
            elem: "#deviceSoftwareStatus",
            dictTypeId: "DEVICE_SOFTWARE_STATUS",
        });
        form.render();
        //接入状态
        layui.admin.renderDictSelect({
            elem: "#accessStatus",
            dictTypeId: "EQUIPMENT_ACCESS_STATUS",
        });
        form.render();
    }


    $(window).resize(function () {
        table.reload("LAY-app-device_status-list-reload", {
            height: "full-" + getFullSize()
        });
    });

    $("body").on("click", ".layui-table-body table.layui-table tbody tr td", function () {
        if ($(this).attr("data-field") === "0") return;
        $(this).siblings().eq(0).find("i").click();
    });
    function change(status,_td,statusValue){
        if (status == "101") {
            $($(_td).children()[0]).children("span").eq(0).removeClass('layui-badge-dot layui-bg-green');
            $($(_td).children()[0]).children("span").eq(0).removeClass('layui-badge-dot layui-bg-red');
            $($(_td).children()[0]).children("span").eq(0).removeClass('layui-badge-dot layui-bg-orange');
            $($(_td).children()[0]).children("span").eq(0).addClass('layui-badge-dot layui-bg-green');
            $($(_td).children()[0]).children("span").eq(1).attr("style", "color:green");
            $($(_td).children()[0]).children("span").eq(1).html(statusValue);
        }
        if (status == "102") {
            $($(_td).children()[0]).children("span").eq(0).removeClass('layui-badge-dot layui-bg-green');
            $($(_td).children()[0]).children("span").eq(0).removeClass('layui-badge-dot layui-bg-red');
            $($(_td).children()[0]).children("span").eq(0).removeClass('layui-badge-dot layui-bg-orange');
            $($(_td).children()[0]).children("span").eq(0).addClass('layui-badge-dot layui-bg-red');
            $($(_td).children()[0]).children("span").eq(1).attr("style", "color:red");
            $($(_td).children()[0]).children("span").eq(1).html(statusValue);
        }
        if (status == "100") {
            $($(_td).children()[0]).children("span").eq(0).removeClass('layui-badge-dot layui-bg-green');
            $($(_td).children()[0]).children("span").eq(0).removeClass('layui-badge-dot layui-bg-red');
            $($(_td).children()[0]).children("span").eq(0).removeClass('layui-badge-dot layui-bg-orange');
            $($(_td).children()[0]).children("span").eq(0).addClass('layui-badge-dot layui-bg-orange');
            $($(_td).children()[0]).children("span").eq(1).attr("style", "color:orange");
            $($(_td).children()[0]).children("span").eq(1).html(statusValue);
        }

    }
</script>
</body>
</html>