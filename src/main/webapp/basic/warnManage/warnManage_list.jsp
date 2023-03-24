<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 施林丰
  - Date: 2022-12-01 16:06:00
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>预警管理</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.0">
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
        <div class="layui-form layuiadmin-card-header-auto" lay-filter="layuiadmin-alarmEvent-form"
             id="layuiadmin-alarmEvent-form">
            <div class="layui-form-item">
                <div class="layui-inline">
                        <label class="layui-form-label">预警等级：</label>
                        <div class="layui-input-inline">
                            <input type="text" name="warnGrade" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline layui-hide">
                    <button id="LAY-app-alarmEvent-list-search" class="layui-btn layuiadmin-btn-list" lay-submit
                            lay-filter="LAY-app-alarmEvent-list-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
    </script>
    <div class="layui-card-body">
        <table id="LAY-app-alarmEvent-list" lay-filter="LAY-app-alarmEvent-list"></table>

        <script type="text/html" id="table-alarmEvent-list">
            <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i
                    class="layui-icon layui-icon-edit"></i>编辑</a>
            <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="view"><i
                    class="layui-icon layui-icon-view"></i>查看</a>
        </script>
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
    var isExits = false;
    var admin = layui.admin;
    var view = layui.view;

    //全局参数
    var req_data;

    //功能名
    var funName = "alarm_event_list";

    // 高级查询参数
    var advancedFormData = {};
    // 焦点名称
    var focusName = null;

    var formData = {};

    var hiddenFields = [];

    var laydate = layui.laydate;

    //监听搜索
    form.on("submit(LAY-app-alarmEvent-list-search)", function (data) {
        var field = data.field;
        reloadData(field);
        formData = {
            warnGrade: field.warnGrade,
        };
        form.val("layuiadmin-alarmEvent-form", formData);
        advancedFormData = $.extend(advancedFormData, formData);
    });

    function reloadData(formData) {
        table.reload("LAY-app-alarmEvent-list-reload", {
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
        form.val("layuiadmin-alarmEvent-form", {
            warnGrade: data.warnGrade,
        });
    }

    // //预警类型下拉框监听事件
    // form.on("select(alarmType)", function (data) {
    //     var submit = $("#LAY-app-alarmEventlist-search");
    //     submit.click();
    // });
    // //预警级别下拉框监听事件
    // form.on("select(alarmLevel)", function (data) {
    //     var submit = $("#LAY-app-alarmEventlist-search");
    //     submit.click();
    // });
    //
    //
    // //文本框回车事件
    // $(".layui-input").on("keydown", function (event) {
    //     if (event.keyCode == 13) {
    //         var submit = $("#LAY-app-alarmEventlist-search");
    //         submit.click();
    //         return false;
    //     }
    // });

    var active = {
        //查询按钮
        search: function () {
            var submit = $("#LAY-app-alarmEvent-list-search");
            submit.click();
            return false;
        },
        //预警等级新建
        add: function () {
            top.layer.open({
                type: 2,
                title: "预警等级新增",
                content: "<%= request.getContextPath() %>/basic/warnManage/warnManage_add.jsp",
                area: ["800px", "580px"],
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

    };

    table.on('sort(LAY-app-alarmEvent-list)', function (obj) {
        table.reload('LAY-app-alarmEvent-list-reload', {
            initSort: obj,
            where: {
                sortField: obj.field,
                sortOrder: obj.type
            }
        });
        formReder();
    });

    //左侧表头按钮事件监听
    table.on("toolbar(LAY-app-alarmEvent-list)", function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    //表格排序
    table.on("sort(LAY-app-alarmEvent-list)", function (obj) {
        table.reload("LAY-app-alarmEvent-list-reload", {
            initSort: obj,
            where: {
                sortField: obj.field,
                sortOrder: obj.type
            }
        });
        formReder();
    });

    function getFullSize() {
        var fluid = $(".layui-fluid");
        var header = $(".layui-card-header");
        var cardbody = $(".layui-card-body");
        return header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height()) + (fluid.outerHeight(true) - fluid.height()) + 2;
    }


    $(window).resize(function () {
        table.reload("LAY-app-alarmEvent-list-reload", {
            height: "full-" + getFullSize()
        });
        formReder();
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
        elem: "#LAY-app-alarmEvent-list",
        id: "LAY-app-alarmEvent-list-reload",
        url: "<%= request.getContextPath() %>/warnManage/queryWarn",
        method: "GET",
        height: "full-" + getFullSize(),
        page: true,
        limit: 10,
        limits: [10, 15, 20, 30],
        toolbar: "#toolbar",
        defaultToolbar: [{
            title: "查询",
            layEvent: "search",
            icon: "layui-icon layui-icon-search layuiadmin-button-btn",
        },{
            title: "添加预警等级",
            layEvent: "add",
            icon: "layui-icon layui-icon-add-circle-fine",
        },"filter"],
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
        cols: [[ {
            title: "序号",
            type: "numbers"
        }, {
            field: "warnGrade",
            title: "预警等级",
            align: "center",
            minWidth: 120,
            hide: isHidden("warnGrade")
        }, {
            field: "creator",
            title: "创建人",
            align: "center",
            minWidth: 150,
            hide: isHidden("creator")
        }, {
            field: "createTime",
            title: "创建时间",
            align: "center",
            minWidth: 120,
            hide: isHidden("createTime"),
            templet: function (d) {
                return layui.util.toDateString(d.createTime);
            }
        },{
            title: "操作",
            align: "center",
            fixed: "right",
            width: 200,
            toolbar: "#table-alarmEvent-list"
        }]]
    });

    formReder();

    function formReder() {

        // 文本框回车事件
        $(".layui-input").on("keydown", function (event) {
            if (event.keyCode == 13) {
                focusName = event.target.name;
                var submit = $("#LAY-app-alarmEvent-list-search");
                submit.click();
                return false;
            }
        });

        form.val("layuiadmin-alarmEvent-form", formData);
    }


    //监听操作事件
    table.on("tool(LAY-app-alarmEvent-list)", function (e) {
        var data = e.data;
        if (e.event == "edit") {
            top.layer.open({
                type: 2,
                title: "编辑预警管理信息",
                content: "<%= request.getContextPath() %>/basic/warnManage/warnManage_edit.jsp",
                area: ["1000px", "560px"],
                resize: false,
                btn: ["确定", "取消"],
                success: function (layero, index) {
                    var dataJson = {
                        data: data,
                        win: window
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {
                    var submit = layero.find("iframe").contents().find("#layuiadmin-app-form-submit");
                    submit.click();
                }

            });
        } else if (e.event == "view") {
            top.layer.open({
                type: 2,
                title: "查看预警等级详情",
                content: "<%= request.getContextPath() %>/basic/warnManage/warnManage_view.jsp",
                area: ["1000px", "620px"],
                resize: false,
                 btn: ["关闭"],
                success: function (layero, index) {
                    var dataJson = {
                        data: data,
                        win: window
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {
                    top.layer.close(index);
                }

            });
        }
    });

    //批量选中
    $("body").on("click", ".layui-table-body table.layui-table tbody tr td", function () {
        if ($(this).attr("data-field") === "0") return;
        $(this).siblings().eq(0).find("i").click();
    });
</script>
</body>
</html>