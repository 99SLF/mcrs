<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 林俊杰
  - Date: 2022-12-01 16:08:11
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>选择设备</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.0">
</head>
<body>
<div class="layui-fluid">
    <div class="layui-card" style="margin-bottom: 0;">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">设备资源号：</label>
                    <div class="layui-input-inline">
                        <input name="equipmentId" class="layui-input" onenter="search"/>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">使用工序：</label>
                    <div class="layui-input-inline">
                        <input name="processName" class="layui-input" onenter="search"/>
                    </div>
                </div>
                <div class="layui-inline">
                    <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-deviceInfo-search"
                            id="LAY-app-deviceInfo-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
        <div class="layui-card-body">
            <div class="layui-hide">
                <button class="layui-btn" data-type="getCheckData"></button>
            </div>
            <table id="LAY-app-device-list" lay-filter="LAY-app-device-list"></table>
        </div>
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
    var table = layui.table;
    var form = layui.form;
    var $ = layui.jquery;
    var submit = false;
    var reg = /^\d+$|^\d*\.\d+$/;
    var laydate = layui.laydate;
    form.render();
    var dataJson = [];
    var funName = "list";
    //过滤字段
    var hiddenFields = [];
    var win = null;

    var tableData = null;

    form.render();
    var deviceData = {};

    //获取使用工序的下拉值
    layui.admin.renderDictSelect({
        elem: "#processName",
        dictTypeId: "USE_PROCESS",
    });
    form.render();


    //监听搜索
    form.on("submit(LAY-app-deviceInfo-search)", function (data) {
        var field = data.field;
        var dataJson = {
            "equipmentInt": field.equipmentInt,
            "equipmentId": field.equipmentId,
            "equipTypeName": field.equipTypeName,
            "processName": field.processName,
            "isEquipment": "1"
        };
        table.reload("LAY-app-device-list", {
            url: "<%= request.getContextPath() %>/equipment/equipment/query",
            where: field
        });
    });

    //使用工序下拉框监听事件
    form.on("select(processName)", function (data) {
        var submit = $("#LAY-app-deviceInfo-search");
        submit.click();
    });

    //文本框回车事件
    $(".layui-input").on("keydown", function (event) {
        if (event.keyCode == 13) {
            var submit = $("#LAY-app-deviceInfo-search");
            submit.click();
            return false;
        }
    });

    var selData = {};      //存放选中行数据

    //监听行单击事件（双击事件为：rowDouble）
    table.on('row(LAY-app-device-list)', function (obj) {
        selData = obj.data;
    });

    function getData() {   //获取点击行的数据
        return selData;
    }

    form.on('submit(layuiadmin-app-form-submit)', function (rel) {
        var formData = rel.field;
    });

    function getFullSize() {
        var fluid = $(".layui-fluid");
        var header = $(".layui-card-header");
        var card = $(".layui-card");
        var cardbody = $(".layui-card-body");
        return header.outerHeight(true) + (card.outerHeight(true) - card.height()) + (cardbody.outerHeight(true) - cardbody.height()) + (fluid.outerHeight(true) - fluid.height());
    }

    $(window).resize(function () {
        table.reload("LAY-app-device-list", {
            height: "full-" + getFullSize()
        });
    });

    table.render({
        elem: "#LAY-app-device-list",
        url: "<%= request.getContextPath() %>/equipment/equipment/query",
        method: "GET",
        height: "full-" + getFullSize(),
        page: true,
        limit: 10,
        limits: [10, 15, 20, 30],
        where: {"isEquipment": "1"},
        parseData: function (res) {
            debugger;
            return {
                code: "0",
                msg: res.msg,
                count: res.total,
                data: res.data
            };
        },
        cols: [[{
            type: "checkbox"
        }, {
            title: "序号",
            type: "numbers"
        }, {
            field: "equipmentId",
            title: "设备资源号",
            align: "center",
            minWidth: 100
        }, {
            field: "equipmentName",
            title: "设备名称",
            align: "center",
            minWidth: 100
        },{
            field: "equipTypeName",
            title: "设备类型",
            align: "center",
            minWidth: 120
        }, {
            field: "equipmentInstallLocation",
            title: "设备安装位置",
            align: "center",
            minWidth: 150
        }, {
            field: "equipmentIp",
            title: "设备IP",
            align: "center",
            minWidth: 150,
        }, {
            field: "accPointResName",
            title: "接入点名称",
            align: "center",
            minWidth: 150,
        }, {
            field: "matrixCode",
            title: "基地代码",
            align: "center",
            minWidth: 150,
        }, {
            field: "factoryCode",
            title: "工厂代码",
            align: "center",
            minWidth: 150,
        }, {
            field: "processName",
            title: "使用工序",
            align: "center",
            minWidth: 150,
        }, {
            field: "workStationList",
            title: "工位",
            align: "center",
            minWidth: 150,
        }]]
    });


    function GetData() {
        var checkStatus = table.checkStatus('LAY-app-device-list');
        tableData = checkStatus.data;
        return tableData;
    }


    // $("body").on("click", ".layui-table-body table.layui-table tbody tr td", function () {
    //     var objs = $($(this).parent()).siblings();
    //     $.each(objs, function (i, item) {
    //         if ($(item).find('.layui-form-checked').length > 0) {
    //             $(item).find("[data-field='0']").find('i').click();
    //         }
    //     });
    //     if ($(this).attr("data-field") === "0") return;
    //     $(this).siblings().eq(0).find('i').click();
    // });

    //批量选中
    $("body").on("click", ".layui-table-body table.layui-table tbody tr td", function () {
        if ($(this).attr("data-field") === "0") return;
        $(this).siblings().eq(0).find("i").click();
    });
</script>
</body>
</html>