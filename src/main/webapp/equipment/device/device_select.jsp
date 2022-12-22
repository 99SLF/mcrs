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
    <title>选择终端</title>
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
                    <label class="layui-form-label">终端名称：</label>
                    <div class="layui-input-inline">
                        <input name="deviceName" class="layui-input" onenter="search"/>
                    </div>
                </div>
<%--             由于原型修改   暂时还没有这个字段--%>
                <div class="layui-inline">
                    <label class="layui-form-label">使用工序：</label>
                    <div class="layui-input-inline">
                        <input name="equipmentProperties" class="layui-input" onenter="search"/>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">工厂名称：</label>
                    <div class="layui-input-inline">
                        <input name="factoryName" class="layui-input" onenter="search"/>
                    </div>
                </div>
                <div class="layui-inline">
                    <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-deviceInfo-search">
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
<script type="text/javascript">
    var layer = layui.layer;
    var table = layui.table;
    var form = layui.form;
    var $ = layui.jquery;

    form.render();
    var deviceData = {};

    //监听搜索
    form.on("submit(LAY-app-deviceInfo-search)", function (data) {
        var field = data.field;
        var dataJson = {
            "deviceName": field.deviceName,
            // "equipmentId": field.equipmentId,
            "factoryName": field.factoryName,
            "isDevice": "1"
        };
        table.reload("LAY-app-device-list", {
            url: "<%= request.getContextPath() %>/equipment/device/query",
            where: field
        });
    });

    $(".layui-btn.layuiadmin-btn-list").on("click", function () {
        var type = $(this).data("type");
        active[type] ? active[type].call(this) : "";
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
        url: "<%= request.getContextPath() %>/equipment/device/query",
        method: "GET",
        height: "full-" + getFullSize(),
        page: true,
        limit: 10,
        limits: [10, 15, 20, 30],
        where: {"isDevice": "1"},
        parseData: function (res) {
            return {
                code: "0",
                msg: res.msg,
                count: res.total,
                data: res.data
            };
        },
        cols: [[{
            type: "radio"
        }, {
            title: "序号",
            type: "numbers"
        }, {
            field: "aPPId",
            title: "APPId",
            align: "center",
            minWidth: 100
        }, {
            field: "deviceName",
            title: "终端名称",
            align: "center",
            minWidth: 120
        }, {
            field: "equipmentId",
            title: "设备资源号",
            align: "center",
            minWidth: 150
        }, {
            field: "equipmentProperties",
            title: "设备类型",
            align: "center",
            minWidth: 100,
        }, {
            field: "protocolCommunication",
            title: "通信协议",
            align: "center",
            minWidth: 120,
        }, {
            field: "equipmentName",
            title: "接入点名称",
            align: "center",
            minWidth: 120,
        },
        //    由于原型修改，暂时还没有这个字段
        //     {
        //     field: "mesContinueIp",
        //     title: "使用工序",
        //     align: "center",
        //     minWidth: 120,
        // },
            {
            field: "factoryName",
            title: "工厂名称",
            align: "center",
            minWidth: 120,
        }]]
    });


    $("body").on("click", ".layui-table-body table.layui-table tbody tr td", function () {
        var objs = $($(this).parent()).siblings();
        $.each(objs, function (i, item) {
            if ($(item).find('.layui-form-checked').length > 0) {
                $(item).find("[data-field='0']").find('i').click();
            }
        });
        if ($(this).attr("data-field") === "0") return;
        $(this).siblings().eq(0).find('i').click();
    });
</script>
</body>
</html>