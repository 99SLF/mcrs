<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>点位配置</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/custom.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/iconfont/iconfont.css">
    <style>
        .layui-form-label {
            width: 140px;
        }

        .layui-input-block {
            margin-left: 150px;
            min-height: 36px
        }
    </style>

</head>
<body style="background-color: white;">
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-row">
                <h1>参数信息</h1>
            </div>
        </div>
        <div class="layui-form" lay-filter="pointDispose-edit" id="pointDispose-edit" style="padding:20px;">
            <div class="layui-row layui-col-space10 layui-form-item">
                <div class="layui-col-sm4">
                    <label class="layui-form-label"><span style="color:red">*</span>APPID：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="appId" id="appId"
                               autocomplete="off" readonly>
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">终端名称：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="deviceName" id="deviceName"
                               autocomplete="off" readonly>
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">设备资源号：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="equipmentId" id="equipmentId"
                               autocomplete="off" readonly>
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space10 layui-form-item">
                <div class="layui-col-sm4">
                    <label class="layui-form-label">接入点IP：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="equipmentIp" id="equipmentIp"
                               autocomplete="off" readonly>
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">端口号：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="equipmentContinuePort" id="equipmentContinuePort"
                               autocomplete="off" readonly>
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">接入点名称：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="equipmentName" id="equipmentName"
                               autocomplete="off" readonly>
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space10 layui-form-item">
                <div class="layui-col-sm4">
                    <label class="layui-form-label">工厂名称：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="factoryName" id="factoryName"
                               autocomplete="off" readonly>
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">使用工序：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="production" id="production"
                               autocomplete="off" readonly>
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">设备类型：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="equipmentProperties" id="equipmentProperties"
                               autocomplete="off" readonly>
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space10 layui-form-item">
                <div class="layui-col-sm4">
                    <label class="layui-form-label">通信协议：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="protocolCommunication" id="protocolCommunication"
                               autocomplete="off" readonly>
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">下料执行作业：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="downWork" id="downWork"
                               autocomplete="off">
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">上料执行作业：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="upWork" id="upWork"
                               autocomplete="off" >
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space10 layui-form-item">
                <div class="layui-col-sm4">
                    <label class="layui-form-label">上料过账模式：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="upModel" id="upModel"
                               autocomplete="off">
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">下料过账模式：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="downModel" id="downModel"
                               autocomplete="off">
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">数量单位：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="dataUnit" id="dataUnit"
                               autocomplete="off">
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space10 layui-form-item">
                <div class="layui-col-sm4">
                    <label class="layui-form-label">数据计算方法：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="dataMethod" id="dataMethod"
                               autocomplete="off">
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">单片机总长度：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="chipLength" id="chipLength"
                               autocomplete="off" lay-verify=”int” value="0">
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">比例：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="scale" id="scale"
                               autocomplete="off" lay-verify=”int” value="0">
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space10 layui-form-item">
                <div class="layui-col-sm4">
                    <label class="layui-form-label">系数：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="ratio" id="ratio"
                               autocomplete="off" lay-verify=”int” value="0">
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">数采检查参数：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="checkParam" id="checkParam"
                               autocomplete="off"lay-verify=”int” value="0">
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">放卷卸料设定卷径：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="rollDiameter" id="rollDiameter"
                               autocomplete="off"lay-verify=”int” value="0">
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space10 layui-form-item">
                <div class="layui-col-sm4">
                    <label class="layui-form-label">标签验证周期：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="lableCycle" id="lableCycle"
                               autocomplete="off"lay-verify=”int” value="0">
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">防串读监测时间：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="monitorDate" id="monitorDate"
                               autocomplete="off" lay-verify=”int” value="0">

                    </div>
                </div>
            </div>
            <div class="layui-form-item layui-hide">
                <input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit"
                       value="确认添加">
            </div>
        </div>
        <div class="layui-card-body">
            <div class="layui-toolbar" id="toolbarPlc" hidden="true">
                <button class="layui-btn layuiadmin-btn-list layui-btn-sm" lay-event="addPlc"><i
                        class="layui-icon layui-icon-add-circle-fine"></i>新建PLC点位组
                </button>
            </div>
            <div class="layui-toolbar" id="toolbarRfid" hidden="true">
                <button class="layui-btn layuiadmin-btn-list layui-btn-sm" lay-event="addRfid"><i
                        class="layui-icon layui-icon-add-circle-fine"></i>新建RFID点位组
                </button>
            </div>
            <div class="layui-tab layui-tab-brief">
                <ul class="layui-tab-title">
                    <li class="layui-this">PLC点位组</li>
                    <li>RFID点位组</li>
                </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">
                        <div class="layui-card-body">
                            <table id="plc" lay-filter="plc" class="layui-table " lay-skin="none"></table>
                        </div>
                    </div>
                    <div class="layui-tab-item">
                        <div class="layui-card-body">
                            <table id="rfid" lay-filter="rfid" class="layui-table " lay-skin="none"></table>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<script type="text/html" id="table-plc-list">
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i
            class="layui-icon layui-icon-edit"></i>编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i
            class="layui-icon layui-icon-delete"></i>删除</a>
</script>
<script type="text/html" id="table-rfid-list">
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i
            class="layui-icon layui-icon-edit"></i>编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i
            class="layui-icon layui-icon-delete"></i>删除</a>
</script>
<script src="<%=request.getContextPath()%>/common/layui/layui.all.js"></script>
<script>
    layui.config({
        base: "<%=request.getContextPath()%>/"
    });
</script>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
<script type="text/javascript">
    var layer = layui.layer;
    var table = layui.table;
    var submit = false;
    var isExist = false;
    var form = layui.form;
    var editIndex = 0;
    var $ = layui.jquery;
    var reg = /^\d+$|^\d*\.\d+$/;
    var laydate = layui.laydate;
    var i=0;
    form.render();
    var funName = "point_add";
    var win = null;
    //过滤字段
    var hiddenFields = [];
    function SetData(data){
        win = data.win ? data.win : window;
        var pointDispose = data.data;
        form.val("pointDispose-edit",{
            "appId": pointDispose.appId,
            "deviceName": pointDispose.deviceName,
            "equipmentId": pointDispose.equipmentId,
            "equipmentIp":pointDispose.equipmentIp,
            "equipmentContinuePort": pointDispose.equipmentContinuePort,
            "equipmentName":pointDispose.equipmentName,
            "factoryName":pointDispose.factoryName,
            "production": pointDispose.production,
            "equipmentProperties":pointDispose.equipmentProperties,
            "downWork": pointDispose.downWork,
            "upWork": pointDispose.upWork,
            "upModel": pointDispose.upModel,
            "downModel": pointDispose.downModel,
            "dataUnit": pointDispose.dataUnit,
            "dataMethod": pointDispose.dataMethod,
            "chipLength": pointDispose.chipLength,
            "scale": pointDispose.scale,
            "ratio":pointDispose.ratio,
            "checkParam": pointDispose.checkParam,
            "rollDiameter":pointDispose.rollDiameter,
            "lableCycle":pointDispose.lableCycle,
            "monitorDate":pointDispose.monitorDate
        })
        $.ajax({
            url: "<%=request.getContextPath() %>/pointdispose/get?appId=" + pointDispose.appId,
            type: "GET",
            async: false,
            cache: false,
            contentType: "text/json",
            success: function (result) {
                debugger;
                if (result) {
                    table.reload('plc',{
                        data : result.data.plcGroupList
                    });
                    table.reload('rfid',{
                        data : result.data.rfidGroupList
                    });
                } else {
                    layer.msg("查询失败");
                }
            }
        });
    }
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

    //文本框回车事件
    $(".layui-input").on("keydown", function (event) {
        if (event.keyCode == 13) {
            var submit = $("#search");
            submit.click();
            return false;
        }
    });

    function getFullSize() {
        var fluid = $(".layui-fluid");
        var header = $(".layui-card-header");
        var cardbody = $(".layui-card-body");
        return header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height()) + (fluid.outerHeight(true) - fluid.height()) + 2;
    }

    $(window).resize(function () {
        table.reload("tableReload", {
            height: "full-" + getFullSize()
        });
    });

    table.on('toolbar(plc)', function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });
    table.on('toolbar(rfid)', function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    form.on("submit(layuiadmin-app-form-submit)", function (data) {
        var pointDispose = data.field;
        if (submit == false) {
            submit = true;
            var plcGroupList = table.cache['plc'];
            pointDispose.plcGroupList = plcGroupList;
            var rfidGroupList = table.cache['rfid'];
            pointDispose.rfidGroupList = rfidGroupList;
            var submitData = JSON.stringify(pointDispose);
            if (submitData != null) {
                i = i + 1;
            }
            if (i == 1) {
                $.ajax({
                    url: "<%= request.getContextPath() %>/pointdispose/update",
                    type: "PUT",
                    data: submitData,
                    cache: false,
                    contentType: 'text/json',
                    success: function(result) {
                        debugger;
                        if (result.exception) {
                            layer.alert(result.exception.message, {
                                icon: 2,
                                title: "系统提示"
                            });
                        } else if (result) {
                            layer.msg("更新成功", {
                                icon: 1,
                                time: 2000
                            }, function() {
                                var index = parent.layer.getFrameIndex(window.name);
                                win.layui.table.reload("pointDispose");
                                top.layer.close(index);
                                win.window.updateFuncgroupSelect();
                            });
                        } else {
                            layer.msg("添加失败");
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        layer.msg(jqXHR.responseText, {
                            time: 2000,
                            icon: 5
                        });
                    }
                });
            }
            //var index = parent.layer.getFrameIndex(window.name);
           // top.layer.close(index);
        } else {
            layer.msg("请稍等");
        }
        return false;
    });

    //监听按钮点击事件
    var active = {
        addPlc: function () {
            top.layer.open({
                type: 2,
                title: "PLC点位配置",
                content: "<%= request.getContextPath() %>/equipment/point/plcPoint/point_plc_add.jsp",
                area: ["1000px", "560px"],
                resize: false,
                btn: ["确定", "取消"],
                success: function (layero, index) {
                    var dataJson = {
                        win: window,
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {
                    var submit = layero.find("iframe").contents().find("#layuiadmin-app-form-submit");
                    submit.click();
                }
            });
        },
        addRfid: function () {
            top.layer.open({
                type: 2,
                title: "RFID点位配置",
                content: "<%= request.getContextPath() %>/equipment/point/rfidPoint/point_rfid_add.jsp",
                area: ["1000px", "560px"],
                resize: false,
                btn: ["确定", "取消"],
                success: function (layero, index) {
                    var dataJson = {
                        win: window,
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {
                    var submit = layero.find("iframe").contents().find("#layuiadmin-app-form-submit");
                    submit.click();
                }
            });
        }
    }

    /*   PLC */

    table.render({
        elem: "#plc",
        id: "plc",
        data: [],
        height: "full-" + getFullSize(),
        toolbar: "#toolbarPlc",
        defaultToolbar: [""],
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
            field: "plcGroupName",
            title: "组别名称",
            align: "center",
            minWidth: 120,
            templet: function(data) {
                data.plcGroupName = data.plcGroupName == null ? "" : data.plcGroupName;
                var html = '<div><a rel="nofollow" href="javascript:void(0);" style="color:#1E9FFF" lay-event="showView">' + data.plcGroupName+ '</a></div>';
                return html;
            }
        }, {
            field: "plcGroupType",
            title: "组别类型",
            align: "left",
            minWidth: 100,
        }, {
            field: "plcGroupRname",
            title: "组映射RFID名称",
            align: "center",
            minWidth: 100,
        }, {
            field: "rfidNum",
            title: "RFID天线编码",
            align: "center",
            minWidth: 100,
        }, {
            field: "remarks",
            title: "备注",
            align: "center",
            minWidth: 120,
        }, {
            title: "操作",
            align: "center",
            fixed: "right",
            width: 200,
            toolbar: "#table-plc-list"
        }]],
    });

    table.render({
        elem: "#rfid",
        id: "rfid",
        data: [],
        defaultToolbar: [""],
        toolbar: "#toolbarRfid",
        height: "full-" + getFullSize(),
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
        }, {
            field: "rfidNum",
            title: "RFID-ID",
            align: "center",
            minWidth: 120,
            templet: function(data) {
                data.rfidNum = data.rfidNum == null ? "" : data.rfidNum;
                var html = '<div><a rel="nofollow" href="javascript:void(0);" style="color:#1E9FFF" lay-event="showView">' + data.rfidNum+ '</a></div>';
                return html;
            }
        }, {
            field: 'ipAddr',
            title: '连接IP',
            align: 'center',
            minWidth: 100,
        }, {
            field: 'port',
            title: '端口',
            minWidth: 100,
            align: "center",
        }, {
            title: "操作",
            align: "center",
            fixed: "right",
            minWidth: 120,
            toolbar: "#table-rfid-list"
        }]]
    });

    function setPlcGroup(plcGroup) {
        var plcGroupList = table.cache['plc'];
        plcGroupList.push(plcGroup);
        table.reload('plc',{
            data : plcGroupList
        });
    }
    function setRfidGroup(rfidGroup) {
        var rfidGroupList = table.cache['rfid'];
        rfidGroupList.push(rfidGroup);
        table.reload('rfid',{
            data : rfidGroupList
        });
    }
    function setEditPlcGroup(plcGroup) {
        var plcGroupList = table.cache['plc'];
        plcGroupList.splice(editIndex,1,plcGroup);
        table.reload('plc',{
            data : plcGroupList
        });
    }
    function setEditRfidGroup(rfidGroup) {
        var rfidGroupList = table.cache['rfid'];
        rfidGroupList.splice(editIndex,1,rfidGroup);
        table.reload('rfid',{
            data : rfidGroupList
        });
    }
    table.on("tool(plc)", function (obj) {
        if (obj.event == 'edit') {
            editIndex =  obj.tr.data("index");
            top.layer.open({
                type: 2,
                title: "编辑PLC点位配置",
                content: "<%= request.getContextPath() %>/equipment/point/plcPoint/point_plc_edit.jsp",
                area: ["1000px", "560px"],
                resize: false,
                btn: ["确定", "取消"],
                success: function (layero, index) {
                    var dataJson = {
                        win: window,
                        plcGroup: obj.data
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {
                    var submit = layero.find("iframe").contents().find("#layuiadmin-app-form-submit");
                    submit.click();
                }
            });
        } else if(obj.event == "del") {
            var Data = table.cache["plc"];
            if (obj.tr.data("index") >= -1) {
                Data.splice(obj.tr.data("index"), 1);	//根据索引删除当前行
                table.reload('plc',{
                    data : Data
                });
            }
        }else if(obj.event == "showView") {
            top.layer.open({
                type: 2,
                title: "PLC点位配置详情",
                content: "<%= request.getContextPath() %>/equipment/point/plcPoint/point_plc_view.jsp",
                area: ["1000px","560px"],
                resize: false,
                btn: ["关闭"],
                success: function(layero, index) {
                    var dataJson = {
                        plcGroup: obj.data,
                        win: window
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
            });
        }
    })

    table.on("tool(rfid)", function (obj) {
        if (obj.event == 'edit') {
            editIndex =  obj.tr.data("index");
            top.layer.open({
                type: 2,
                title: "编辑RFID点位配置",
                content: "<%= request.getContextPath() %>/equipment/point/rfidPoint/point_rfid_edit.jsp",
                area: ["1000px", "560px"],
                resize: false,
                btn: ["确定", "取消"],
                success: function (layero, index) {
                    var dataJson = {
                        win: window,
                        rfidGroup: obj.data
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {
                    var submit = layero.find("iframe").contents().find("#layuiadmin-app-form-submit");
                    submit.click();
                }
            });
        } else if(obj.event == "del") {
            var Data = table.cache["rfid"];
            if (obj.tr.data("index") >= -1) {
                Data.splice(obj.tr.data("index"), 1);	//根据索引删除当前行
                table.reload('rfid',{
                    data : Data
                });
            }
        }else if(obj.event == "showView") {
            top.layer.open({
                type: 2,
                title: "RFID点位配置详情",
                content: "<%= request.getContextPath() %>/equipment/point/rfidPoint/point_rfid_view.jsp",
                area: ["1000px","560px"],
                resize: false,
                btn: ["关闭"],
                success: function(layero, index) {
                    debugger;
                    var dataJson = {
                        rfidGroup: obj.data,
                        win: window
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
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