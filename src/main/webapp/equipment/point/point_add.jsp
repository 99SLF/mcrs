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
        <div class="layui-form" lay-filter="pointDispose-add" id="order-add" style="padding:20px;">
            <div class="layui-row layui-col-space10 layui-form-item">
                <div class="layui-col-sm4">
                    <label class="layui-form-label">APPID：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="appId" id="appId" lay-verify="required"
                               autocomplete="off" readonly>
                        <button type="button" class="layui-btn layui-btn-sm layui-btn-primary" id="selectAppId"
                                style="position:absolute;top:0px;right:0px;height:37px">
                            <i class="layui-icon layui-icon-more"></i>
                        </button>
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">终端名称：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="deviceName" id="deviceName" lay-verify="required"
                               autocomplete="off" readonly>
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">设备资源号：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="equipmentId" id="equipmentId" lay-verify="required"
                               autocomplete="off" readonly>
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space10 layui-form-item">
                <div class="layui-col-sm4">
                    <label class="layui-form-label">接入点IP：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="equipmentIp" id="equipmentIp" lay-verify="required"
                               autocomplete="off" readonly>
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">端口号：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="equipmentContinuePort" id="equipmentContinuePort"
                               lay-verify="required" autocomplete="off" readonly>
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">接入点名称：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="equipmentName" id="equipmentName"
                               lay-verify="required" autocomplete="off" readonly>
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space10 layui-form-item">
                <div class="layui-col-sm4">
                    <label class="layui-form-label">工厂名称：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="factoryName" id="factoryName" lay-verify="required"
                               autocomplete="off" readonly>
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">使用工序：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="production" id="production" lay-verify="required"
                               autocomplete="off" readonly>
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">设备类型：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="equipmentProperties" id="equipmentProperties"
                               lay-verify="required" autocomplete="off" readonly>
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space10 layui-form-item">
                <div class="layui-col-sm4">
                    <label class="layui-form-label">通信协议：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="protocolCommunication" id="protocolCommunication"
                               lay-verify="required" autocomplete="off" readonly>
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">下料执行作业：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="downwork" id="downwork" lay-verify="required"
                               autocomplete="off" readonly>
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">上料执行作业：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="upWork" id="upWork" lay-verify="required"
                               autocomplete="off" readonly>
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space10 layui-form-item">
                <div class="layui-col-sm4">
                    <label class="layui-form-label">上料过账模式：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="upModel" id="upModel" lay-verify="required"
                               autocomplete="off" readonly>
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">下料过账模式：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="downModel" id="downModel" lay-verify="required"
                               autocomplete="off" readonly>
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">数量单位：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="dataUnit" id="dataUnit" lay-verify="required"
                               autocomplete="off" readonly>
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space10 layui-form-item">
                <div class="layui-col-sm4">
                    <label class="layui-form-label">数据计算方法：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="dataMethod" id="dataMethod" lay-verify="required"
                               autocomplete="off">
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">单片机总长度：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="chipLength" id="chipLength" lay-verify="required"
                               autocomplete="off">
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">比例：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="scale" id="scale" lay-verify="required"
                               autocomplete="off">
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space10 layui-form-item">
                <div class="layui-col-sm4">
                    <label class="layui-form-label">系数：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="ratio" id="ratio" lay-verify="required"
                               autocomplete="off">
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">数采检查参数：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="checkParam" id="checkParam" lay-verify="required"
                               autocomplete="off">
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">放卷卸料设定卷径：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="rollDiameter" id="rollDiameter"
                               lay-verify="required" autocomplete="off">
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space10 layui-form-item">
                <div class="layui-col-sm4">
                    <label class="layui-form-label">标签验证周期：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="lableCycle" id="lableCycle" lay-verify="required"
                               autocomplete="off">
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label">防串读监测时间：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="monitorDate" id="monitorDate" lay-verify="required"
                               autocomplete="off">
                    </div>
                </div>
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
    var $ = layui.jquery;
    var reg = /^\d+$|^\d*\.\d+$/;
    var laydate = layui.laydate;
    form.render();
    //监听普通搜索按钮点击事件
    form.on('select(status)', function (rel) {
        var submit = $("#search");
        submit.click();
        return false;
    });
    var funName = "point_add";
    //过滤字段
    var hiddenFields = [];
    table.on('sort(plc)', function (obj) { //注：sort 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
        table.reload('plc', {
            initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。
            , where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
                field: obj.field //排序字段
                , order: obj.type //排序方式
            }
        });
    });
    table.on('sort(rfid)', function (obj) { //注：sort 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
        table.reload('rfid', {
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


    //监听按钮点击事件
    var active = {
        addPlc: function () {
            top.layer.open({
                type: 2,
                title: "PLC点位配置",
                content: "<%= request.getContextPath() %>/equipment/point/point_plc_add.jsp",
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
        }, {
            field: "plcGroupType",
            title: "组别类型",
            edit: 'text',
            align: "left",
            minWidth: 100,
        }, {
            field: "plcGroupRname",
            title: "组映射RFID名称",
            edit: 'text',
            align: "center",
            minWidth: 100,
        }, {
            field: "rfidNum",
            title: "RFID天线编码",
            edit: 'text',
            align: "center",
            minWidth: 100,
        }, {
            field: "remarks",
            title: "备注",
            edit: 'text',
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
            field: "rawMaterial",
            title: "加工方法",
            align: "center",
            width: 120,
            templet: function (d) {
                return layui.admin.getDictText("BIZ_RAWMATERIAL", d.rawMaterial);
            }
        }, {
            field: 'matterNum',
            title: '物料编号',
            align: 'center',
            minWidth: 140,
            templet: function (d) {
                return d.queryMatter == null ? "" : d.queryMatter.matterNum;
            }
        }, {
            field: 'matterName',
            title: '材料名称/加工方法',
            minWidth: 100,
            align: "center",
            templet: function (d) {
                return d.queryMatter == null ? "" : d.queryMatter.matterName;
            }
        }, {
            field: 'secondaryUnit',
            title: '二级单位',
            align: 'center',
            minWidth: 100,
            templet: function (d) {
                return d.queryMatter == null ? "" : layui.admin.getDictText("SECONDARY_UNIT", d.queryMatter.secondaryUnit);
            }
        }, {
            field: 'coefficient',
            title: '系数',
            align: 'center',
            minWidth: 100,
        }, {
            field: 'singleQuantity',
            title: '单耗量',
            align: 'center',
            minWidth: 100,
        }, {
            field: 'supplierName',
            title: '供应商',
            minWidth: 100,
            align: "center",
            templet: function (d) {
                return d.supplier == null ? "" : d.supplier.supplierName;
            }
        }, {
            field: 'issuingMethod',
            title: '发料方式',
            align: 'center',
            minWidth: 100,
            templet: function (d) {
                return layui.admin.getDictText("BIZ_ISSUANCEMETHOD", d.issuingMethod);
            }
        }, {
            field: 'issuingWarehouse',
            title: '发料仓',
            align: 'center',
            minWidth: 100,
            templet: function (d) {
                return layui.admin.getDictText("BIZ_ISSUINGWAREHOUSE", d.issuingWarehouse);
            }
        }, {
            title: "操作",
            align: "center",
            fixed: "right",
            width: 200,
            toolbar: "#table-rfid-list"
        }]]
    });

    function setPlcDatas(plcData) {
        debugger;
        var plcDatas = table.cache['plc'];
        plcDatas.push(plcData);
        table.reload('plc',{
            data : plcDatas
        });
    }
    table.on('tool(plc)', function(obj) {
        var data = obj.data;
        if (obj.event == "addPlc") {
            top.layui.index.openTabsPage( "<%=request.getContextPath() %>/bom/info/order_list.jsp?modeNum="+data.modeNum ,"订单明细");
        }
    });
    //单击行事件
    $('body').on("click", ".layui-table-body table.layui-table tbody tr td", function () {
        if ($(this).attr("data-field") === "0")
            return;
        $(this).siblings().eq(0).find('i').click();
    });
</script>
</body>
</html>