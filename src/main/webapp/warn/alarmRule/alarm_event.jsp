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
    <title>选择预警事件</title>
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
                    <label class="layui-form-label">预警事件编码：</label>
                    <div class="layui-input-inline">
                        <input name="alarmEventId" class="layui-input" onenter="search"/>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">预警事件标题：</label>
                    <div class="layui-input-inline">
                        <input name="alarmEventTitle" class="layui-input" onenter="search"/>
                    </div>
                </div>
                <div class="layui-inline">
                    <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-alarmEventInfo-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
        <div class="layui-card-body">
            <div class="layui-hide">
                <button class="layui-btn" data-type="getCheckData"></button>
            </div>
            <table id="LAY-app-alarmEvent-list" lay-filter="LAY-app-alarmEvent-list"></table>
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
    var alarmEventData = {};

    //监听搜索
    form.on("submit(LAY-app-alarmEventInfo-search)", function (data) {
        var field = data.field;
        var dataJson = {
            "alarmEventInt": field.alarmEventInt,
            "alarmEventId": field.alarmEventId,
            "alarmEventTitle": field.alarmEventTitle,
            "isAlarmEvent": "1"
        };
        table.reload("LAY-app-alarmEvent-list", {
            url: "<%= request.getContextPath() %>/warn/alarmEvent/query",
            where: field
        });
    });

    $(".layui-btn.layuiadmin-btn-list").on("click", function () {
        var type = $(this).data("type");
        active[type] ? active[type].call(this) : "";
    });

    var selData = {};      //存放选中行数据

    //监听行单击事件（双击事件为：rowDouble）
    table.on('row(LAY-app-alarmEvent-list)', function (obj) {
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
        table.reload("LAY-app-alarmEvent-list", {
            height: "full-" + getFullSize()
        });
    });

    table.render({
        elem: "#LAY-app-alarmEvent-list",
        url: "<%= request.getContextPath() %>/warn/alarmEvent/query",
        method: "GET",
        height: "full-" + getFullSize(),
        page: true,
        limit: 10,
        limits: [10, 15, 20, 30],
        where: {"isAlarmEvent": "1"},
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
            field: "alarmEventId",
            title: "预警事件编码",
            align: "center",
            minWidth: 100
        }, {
            field: "alarmEventTitle",
            title: "预警事件标题",
            align: "center",
            minWidth: 120
        }, {
            field: "alarmLevel",
            title: "预警事件级别",
            align: "center",
            minWidth: 150
        }, {
            field: "alarmType",
            title: "预警事件类型",
            align: "center",
            minWidth: 150,
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