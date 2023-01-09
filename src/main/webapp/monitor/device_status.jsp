<!--
- Author(s): 李伟杰
- Date: 2022-12-05 14:08:11
- Description:
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>终端状态</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.0">

    <style type="text/css">
        .layui-card {
            margin-bottom: 0px
        }
    </style>
</head>
<body>
<div class="layui-card">
    <div class="layui-form layui-card-header layuiadmin-card-header-auto">
        <div class="layui-form-item">

            <div class="layui-inline">
                <label class="layui-form-label">设备资源号：</label>
                <div class="layui-input-inline">
                    <input type="text" name="equipmentId" value="" placeholder="请输入设备资源号" autocomplete="off"
                           class="layui-input">
                </div>
                <label class="layui-form-label">APPID：</label>
                <div class="layui-input-inline">
                    <input type="text" name="APPId" value="" placeholder="请输入APPID" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">终端软件类型：</label>
                <div class="layui-input-inline">
                    <select name="deviceSoftwareType" id="deviceSoftwareType" lay-filter="deviceSoftwareType"
                            type="select">
                        <option value=""></option>
                    </select>
                </div>
                <label class="layui-form-label">软件运行状态：</label>
                <div class="layui-input-inline">
                    <select name="deviceSoRunStatus" id="deviceSoRunStatus" lay-filter="deviceSoRunStatus"
                            type="select">
                        <option value=""></option>
                    </select>
                </div>
                <div class="layui-inline layui-search" style="padding-left:15px">
                    <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-rolelist-search"
                            id="LAY-app-rolelist-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="layui-card-body">
        <%--        <div class="layui-toolbar" id="toolbar" hidden="true">--%>
        <%--            <button class="layui-btn layuiadmin-btn-list layui-btn-sm"  lay-event="add"><i class="layui-icon layui-icon-add-circle-fine"></i>添加</button>--%>
        <%--            <button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="batchdel"><i class="layui-icon layui-icon-delete"></i>删除</button>--%>
        <%--        </div>--%>
        <table id="LAY-app-application-list" lay-filter="LAY-app-application-list"></table>
        <%--        <script type="text/html" id="table-role-list">--%>
        <%--            <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>--%>
        <%--            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>--%>
        <%--        </script>--%>
    </div>
</div>
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script>
    layui.config({
        base: "<%=request.getContextPath()%>/"
    });
</script>
<%--字典--%>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
<script type="text/javascript">
    var layer = layui.layer;
    var table = layui.table;
    var form = layui.form;
    var $ = layui.jquery;
    //过滤字段
    var hiddenFields = [];
    //功能名
    var funName = "application_list";
    //时间工具类引用
    var util = layui.util;
    var laydate = layui.laydate;

    //日期时间选择器
    // laydate.render({
    // 	elem: '#test0'
    // 	,type: 'datetime'
    // });
    //
    // //日期时间选择器
    // laydate.render({
    // 	elem: '#test1'
    // 	,type: 'datetime'
    // });

    layui.admin.renderDictSelect({
        elem: "#deviceSoftwareType",
        dictTypeId: "DEVICE_SOFTWARE_TYPE"
    });

    layui.admin.renderDictSelect({
        elem: "#deviceSoRunStatus",
        dictTypeId: "DEVICE_SOFTWARE_STATUS"
    });
    //需要加载字典项
    form.render();
    //监听搜索
    form.on("submit(LAY-app-rolelist-search)", function (data) {
        var field = data.field;
        table.reload("LAY-app-application-list-reload", {
            where: field
        });
    });

    //下拉框监听事件
    form.on('select(appType)', function (data) {
        var submit = $("#LAY-app-rolelist-search");
        submit.click();
    });

    //文本框回车事件
    $(".layui-input").on("keydown", function (event) {
        if (event.keyCode == 13) {
            var submit = $("#LAY-app-rolelist-search");
            submit.click();
            return false;
        }
    });


    /* //按钮事件监听
    $(".layui-btn.layuiadmin-btn-list").on("click", function() {
        var type = $(this).data("type");
        active[type] ? active[type].call(this) : "";
    }); */

    function getFullSize() {
        var header = $(".layui-card-header");
        var cardbody = $(".layui-card-body");
        return header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height()) + 1;
    }

    // //左侧表头按钮事件监听
    // table.on('toolbar(LAY-app-application-list)', function(obj){
    //     var type = obj.event;
    //     active[type] ? active[type].call(this) : "";
    // });

    //表格排序
    table.on('sort(LAY-app-application-list)', function (obj) {
        table.reload('LAY-app-application-list-reload', {
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


    table.render({
        elem: "#LAY-app-application-list",
        id: "LAY-app-application-list-reload",
        url: "<%= request.getContextPath() %>/DeviceRuntime/query",
        method: "GET",
        height: "full-" + getFullSize(),
        page: true,
        limit: 10,
        toolbar: "#toolbar",
        defaultToolbar: ["filter"],
        //列筛选
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
        limits: [10, 15, 20, 30],
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
            minWidth: 120
        }, {
            //field:设定字段名。字段名的设定非常重要，且是表格数据列的唯一标识;title:设定标题名称
            field: "aPPId",
            title: "APPID",
            align: "center",
            hide: isHidden("aPPId"),
            minWidth: 120
        }, {
            field: "deviceSoftwareType",
            title: "终端软件类型",
            align: "center",
            hide: isHidden("deviceSoftwareType"),
            minWidth: 80,
            templet: function (d) {

                return layui.admin.getDictText("DEVICE_SOFTWARE_TYPE", d.deviceSoftwareType);
            }
        }, {
            field: "deviceSoRunStatus",
            title: "软件运行",
            align: "center",
            hide: isHidden("deviceSoRunStatus"),
            minWidth: 80,
            templet: function (d) {
                return layui.admin.getDictText("DEVICE_SOFTWARE_STATUS", d.deviceSoRunStatus);
            }
        }
            , {
                field: "accessStatus",
                title: "设备接入",
                align: "center",
                hide: isHidden("accessStatus"),
                minWidth: 80,
                templet: function (d) {
                    return layui.admin.getDictText("EQUIPMENT_ACCESS_STATUS", d.accessStatus);
                }
            }, {
                field: "deviceWarning",
                title: "设备资源号累计终端告警",
                align: "center",
                hide: isHidden("deviceWarning"),
                minWidth: 220
            }, {
                field: "cpuRate",
                title: "cup运行率",
                align: "center",
                hide: isHidden("cpuRate"),
                minWidth: 60
            }, {
                field: "storageRate",
                title: "内存使用量",
                align: "center",
                hide: isHidden("storageRate"),
                minWidth: 60
            }, {
                field: "errorRate",
                title: "误读率",
                align: "center",
                hide: isHidden("errorRate"),
                minWidth: 60
            }
        ]]
    });

    $(window).resize(function () {
        table.reload("LAY-app-application-list-reload", {
            height: "full-" + getFullSize()
        });
    });


    $("body").on("click", ".layui-table-body table.layui-table tbody tr td", function () {
        if ($(this).attr("data-field") === "0") return;
        $(this).siblings().eq(0).find('i').click();
    });
</script>
</body>
</html>