<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 李伟杰
  - Date: 2023-1-14 16:11:58
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>工序信息</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.0">

    <style>

        .layui-form-label {
            padding-left: 0px;
            width: 85px;
        }

        .layui-input {

            width: 180px;
        }

        zdr {
            width: 80px;
        }

    </style>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">

        </div>

        <div class="layui-card-body">

            <table id="LAY-app-device-list" lay-filter="LAY-app-device-list"></table>

        </div>
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
    var util = layui.util;
    //全加载：日期
    var laydate = layui.laydate;
    var isExits = false;

    //获取当前的树节点的值的数据库表id
    var nodeId = "<%=request.getParameter("realId")%>";//url数值类型不需要双引号，字符串类型需要双引号
    //全局参数
    var req_data;

    //功能名
    var funName = "list";

    var hiddenFields = [];

    //监听搜索
    form.on("submit(LAY-app-devicelist-search)", function (data) {
        var field = data.field;
        table.reload("LAY-app-device-list-reload", {
            page: {
                curr: 1
            },
            where: field
        });
    });


    table.on('sort(LAY-app-device-list)', function (obj) {
        table.reload('LAY-app-device-list-reload', {
            initSort: obj,
            where: {
                sortField: obj.field,
                sortOrder: obj.type
            }
        });
    });


    //表格排序
    table.on("sort(LAY-app-device-list)", function (obj) {
        table.reload("LAY-app-device-list-reload", {
            initSort: obj,
            where: {
                sortField: obj.field,
                sortOrder: obj.type
            }
        });
    });

    function getFullSize() {
        var fluid = $(".layui-fluid");
        var header = $(".layui-card-header");
        var cardbody = $(".layui-card-body");
        return header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height()) + (fluid.outerHeight(true) - fluid.height()) + 2;
    }


    $(window).resize(function () {
        table.reload("LAY-app-device-list-reload", {
            height: "full-" + getFullSize()
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

    xianShi();


    function xianShi(){
        // 查询
        table.render({
            elem: "#LAY-app-device-list",
            id: "LAY-app-device-list-reload",
            url: "<%= request.getContextPath() %>/ProcessController/queryNode?nodeId=" + nodeId,
            method: "GET",
            height: "full-" + getFullSize(),
            page: true,
            limit: 15,
            limits: [10, 15, 20, 30],
            toolbar: "#toolbar",
            defaultToolbar: ["filter"],
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
            parseData: function (res) {
                return {
                    code: res.code,
                    msg: res.msg,
                    count: res.total,
                    data: res.data
                };
            },
            cols: [[{
                title: "序号",
                type: "numbers"
            }, {
                field: "processCode",
                title: '工序代码',
                align: "center",
                minWidth: 80,
                hide: isHidden("processCode")
            }, {
                field: "processName",
                title: "工序名称",
                align: "center",
                minWidth: 150,
                hide: isHidden("processName")
            }, {
                field: "processRemarks",
                title: "工序描述",
                align: "center",
                minWidth: 250,
                hide: isHidden("processRemarks")
            }]]
        });

    }


    //批量选中
    $("body").on("click", ".layui-table-body table.layui-table tbody tr td", function () {
        if ($(this).attr("data-field") === "0") return;
        $(this).siblings().eq(0).find("i").click();
    });
</script>
</body>
</html>