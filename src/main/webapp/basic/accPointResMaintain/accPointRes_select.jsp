<%@page pageEncoding="UTF-8"%>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>

<!--
- Author(s): 李伟杰
- Date: 2022-12-23 08:08:11
- Description:
-->
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>选择接入点资源类型</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css" media="all">
</head>
<body>
<div class="layui-fluid">
    <div class="layui-card" style="margin-bottom: 0;">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">接入点名称：</label>
                    <div class="layui-input-inline">
                        <input name="accPointResName" class="layui-input"/>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">基地代码：</label>
                    <div class="layui-input-inline">
                        <input name="matrixCode" class="layui-input"/>
                    </div>
                </div>
                <div class="layui-inline">
                    <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-menuInfo-search" id="search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
        <div class="layui-card-body">
            <div class="layui-hide">
                <button class="layui-btn" data-type="getCheckData"></button>
            </div>
            <table id="LAY-app-menu-list" lay-filter="LAY-app-menu-list"></table>
        </div>
    </div>
    <div class="layui-form-item layui-hide">
        <input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="确认添加">
    </div>
</div>
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script type="text/javascript">
    var layer = layui.layer;
    var table = layui.table;
    var form = layui.form;
    var $ = layui.jquery;
    var active={};
    form.render();
    var accPointResData = {};

    //监听搜索
    form.on("submit(LAY-app-menuInfo-search)", function(data) {
        var field = data.field;
        var dataJson = {
            "accPointResName": field.accPointResName,
            "matrixCode":field.matrixCode,
            //表中暂未由该字段
            "isAccPointRes": "1"
        };
        table.reload("LAY-app-menu-list", {
            url: "<%= request.getContextPath() %>/accPointResController/query",
            where: field,
            page: {
                curr: 1
            }
        });
    });

    $(".layui-btn.layuiadmin-btn-list").on("click", function() {
        var type = $(this).data("type");
        active[type] ? active[type].call(this) : "";
    });
    //文本框回车事件
    $(".layui-input").on("keydown", function(event) {
        if (event.keyCode == 13) {
            debugger;
            var submit = $("#search");
            submit.click();
            return false;
        }
    });
    var selData = {};      //存放选中行数据

    //监听行单击事件（双击事件为：rowDouble）
    table.on('row(LAY-app-menu-list)', function(obj){
        selData = obj.data;
    });

    function getData() {   //获取点击行的数据
        return selData;
    }

    form.on('submit(layuiadmin-app-form-submit)',function(rel) {
        var formData = rel.field;
    });

    function getFullSize() {
        var fluid = $(".layui-fluid");
        var header = $(".layui-card-header");
        var card = $(".layui-card");
        var cardbody = $(".layui-card-body");
        return header.outerHeight(true)  + (card.outerHeight(true) - card.height()) + (cardbody.outerHeight(true) - cardbody.height()) + (fluid.outerHeight(true) - fluid.height()) ;
    }

    $(window).resize(function () {
        table.reload("LAY-app-menu-list", {
            height: "full-" + getFullSize()
        });
    });

    table.render({
        elem: "#LAY-app-menu-list",
        url: "<%= request.getContextPath() %>/accPointResController/query",
        method: "GET",
        height: "full-" + getFullSize(),
        page: true,
        limit: 10,
        limits: [10, 15, 20, 30],
        where:{"isAccPointRes": "1"},
        parseData: function(res) {
            return {
                code: "0",
                msg: res.msg,
                count: res.total,
                data: res.data
            };
        },
        cols:[[{
            type: "radio"
        }, {
            title: "序号",
            type: "numbers"
        },
            {
                field: "accPointResCode",
                title: "接入点代码",
                align: "center",
                minWidth: 100
            }, {
                field: "accPointResName",
                title: "接入点名称",
                align: "center",
                minWidth: 120
            }, {
                field: "isEnable",
                title: "是否启用",
                align: "center",
                minWidth: 80
            }, {
                field: "matrixCode",
                title: "基地代码",
                align: "center",
                minWidth: 100,
            },{
                field: "matrixName",
                title: "基地名称",
                align: "center",
                minWidth: 120,
            }, {
                field: "factoryCode",
                title: "工厂代码",
                align: "center",
                minWidth: 100,
            }, {
                field: "factoryName",
                title: "工厂名称",
                align: "center",
                minWidth: 120,
            }, {
                field: "processName",
                title: "使用工序",
                align: "center",
                minWidth: 140,
            }]]
    });


    $("body").on("click", ".layui-table-body table.layui-table tbody tr td", function() {
        var objs = $($(this).parent()).siblings();
        $.each(objs, function(i, item) {
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