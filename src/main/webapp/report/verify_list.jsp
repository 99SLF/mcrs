<!--
- Author(s): 李伟杰
- Date: 2023-03-08 14:38:11
- Description:
-->
<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>防止串读记录表</title>
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
             lay-filter="layuiadmin-verify-form" id="layuiadmin-verify-form">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">设备资源号：</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="resource" autocomplete="off"/>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">轴名称：</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="axisName" autocomplete="off"/>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">更新时间：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="UPDATED_TIME" id="UPDATED_TIME" placeholder="请选择更新日期"
                               autocomplete="off" class="layui-input" readonly>
                    </div>
                </div>
                <div class="layui-inline layui-hide">
                    <button id="LAY-app-verify-search" class="layui-btn layuiadmin-btn-list" lay-submit
                            lay-filter="LAY-app-verify-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
    </script>
    <div class="layui-card-body">
        <table id="LAY-app-verify-list" lay-filter="LAY-app-verify-list"></table>
    </div>
</div>
<script src="<%=request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script>
    layui.config({
        base: "<%=request.getContextPath() %>/"
    });
</script>
<script src="<%=request.getContextPath() %>/std/dist/index.all.js"></script>
<script type="text/javascript">
    var layer = layui.layer;
    var table = layui.table;
    var form = layui.form;
    var $ = layui.jquery;
    var util = layui.util;
    var admin = layui.admin;
    var view = layui.view;
    var laydate = layui.laydate;
    // 过滤字段
    var hiddenFields = [];
    // 功能名
    var funName = "verify_list";
    // 高级查询参数
    var advancedFormData = {};
    // 焦点名称
    var focusName = null;
    // 开始时间选择器
    // 监听搜索
    form.on("submit(LAY-app-verify-search)", function (data) {
        var startTime = "";
        var endTime = "";
        var field = data.field;
        if(field.UPDATED_TIME == null||field.UPDATED_TIME==""){
            layer.msg("请选择查询时间区间", {
                icon: 3,
                time: 1000
            })
            return;
        }
        if (field.UPDATED_TIME != null) {
            startTime = field.UPDATED_TIME.substring(0, field.UPDATED_TIME.indexOf("~"));
            endTime = field.UPDATED_TIME.substring(field.UPDATED_TIME.indexOf("~") + 1);
        }
        field["startTime"] = startTime
        field["endTime"] = endTime
        reloadData(field);
        var formData = {
            resource: field.resource,
            axisName: field.axisName,
            UPDATED_TIME: field.UPDATED_TIME
        };
        form.val("layuiadmin-verify-form", formData);
        advancedFormData = $.extend(advancedFormData, formData);
    });


    function reloadData(formData) {
        //读取表格数据 表格id
        table.reload("LAY-app-verify-list-reload", {
            url: "<%=request.getContextPath() %>/report/VerifyUnusual/query",
            method: "get",
            page: {
                curr: 1
            },
            where: formData
        });
        formReder();
        if (focusName) {
            $("input[name=" + focusName + "]").focus();
        }
    }

    function setFormData(data) {
        advancedFormData = data;
        reloadData(data);
        form.val("layuiadmin-verify-form", {
            resource: data.resource,
            axisName: data.axisName,
            UPDATED_TIME: data.UPDATED_TIME
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
            var submit = $("#LAY-app-verify-search");
            submit.click();
            return false;
        },
        query: function () {
            var url = "<%=request.getContextPath() %>/report/verify_form_query.jsp";
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
                    var submit = layero.find("iframe").contents().find("#LAY-app-verify-search-advanced");
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
    table.on("toolbar(LAY-app-verify-list)", function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    // 表格排序
    table.on("sort(LAY-app-verify-list)", function (obj) {
        table.reload("LAY-app-verify-list-reload", {
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
        elem: "#LAY-app-verify-list",
        id: "LAY-app-verify-list-reload",
        data: [],
        height: "full-" + getFullSize(),
        page: true,
        limit: 1000,
        toolbar: "#toolbar",
        defaultToolbar: [{
            title: "查询",
            layEvent: "search",
            icon: "layui-icon layui-icon-search layuiadmin-button-btn",
        }, {
            title: "高级查询",
            layEvent: "query",
            icon: "icon iconfont icon-gaojichaxun",
        }, "filter","exports"],
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
        limits: [1000, 1500, 2000, 2500],
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
            field: "resource",
            title: "设备资源号",
            align: "center",
            hide: isHidden("resource"),
            minWidth: 120
        }, {
            field: "axisName",
            title: "轴名称",
            align: "center",
            minWidth: 100,
            hide: isHidden("axisName")
        }, {
            field: "rfidReader",
            title: "读写器ID",
            align: "center",
            minWidth: 120,
            hide: isHidden("rfidReader")
        }, {
            field: "antenna",
            title: "天线编码",
            align: "center",
            hide: isHidden("antenna"),
            minWidth: 120
        }, {
            field: "processLot",
            title: "已读取标签值",
            align: "center",
            hide: isHidden("processLot"),
            minWidth: 120
        }, {
            field: "tag",
            title: "替换的标签值",
            align: "center",
            hide: isHidden("tag"),
            minWidth: 120
        }, {
            field: "readNum",
            title: "读取到的次数",
            align: "center",
            hide: isHidden("readNum"),
            minWidth: 120
        }, {
            field: "sfcPre",
            title: "生产SFC",
            align: "center",
            minWidth: 120,
            hide: isHidden("sfcPre")
        }, {
            field: "sfc",
            title: "拆分后SFC",
            align: "center",
            minWidth: 120,
            hide: isHidden("sfc")
        }, {
            field: "updatedTime",
            title: "更新时间",
            align: "center",
            hide: isHidden("updatedTime"),
            templet: function (d) {
                return d.updatedTime==null?"":util.toDateString(d.updatedTime, "yyyy-MM-dd HH:mm:ss");
            },
            minWidth: 200
        }]]
    });

    formReder();

    function formReder() {
        laydate.render({
            elem: "#UPDATED_TIME",
            type: "datetime",
            trigger: "click",
            range: "~"
        });
        // 文本框回车事件
        $(".layui-input").on("keydown", function (event) {
            if (event.keyCode == 13) {
                focusName = event.target.name;
                var submit = $("#LAY-app-verify-search");
                submit.click();
                return false;
            }
        });
    }

    $(window).resize(function () {
        table.reload("LAY-app-verify-list-reload", {
            height: "full-" + getFullSize()
        });
    });

    $("body").on("click", ".layui-table-body table.layui-table tbody tr td", function () {
        if ($(this).attr("data-field") === "0") return;
        $(this).siblings().eq(0).find("i").click();
    });
</script>
</body>
</html>