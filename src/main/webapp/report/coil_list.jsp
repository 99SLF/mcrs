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
    <title>上下料卷径报表</title>
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
             lay-filter="layuiadmin-coil-form" id="layuiadmin-coil-form">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">收卷轴名称：</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="rAxisName" autocomplete="off"/>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">是否最后一卷：</label>
                    <div class="layui-input-inline">
                        <select name="isLastVolume" id="isLastVolume" lay-filter="isLastVolume" type="select">
                            <option value="">请选择</option>
                            <option value="0">否</option>
                            <option value="1">是</option>
                        </select>
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
                    <button id="LAY-app-coil-search" class="layui-btn layuiadmin-btn-list" lay-submit
                            lay-filter="LAY-app-coil-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
    </script>
    <div class="layui-card-body">
        <table id="LAY-app-coil-list" lay-filter="LAY-app-coil-list"></table>
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
    var funName = "coil_list";
    // 高级查询参数
    var advancedFormData = {};
    // 焦点名称
    var focusName = null;
    // 开始时间选择器
    // 监听搜索
    form.on("submit(LAY-app-coil-search)", function (data) {
        var startTime = "";
        var endTime = "";
        var field = data.field;
        if (field.UPDATED_TIME != null) {
            startTime = field.UPDATED_TIME.substring(0, field.UPDATED_TIME.indexOf("~"));
            endTime = field.UPDATED_TIME.substring(field.UPDATED_TIME.indexOf("~") + 1);
        }
        field["startTime"] = startTime
        field["endTime"] = endTime
        reloadData(field);
        var formData = {
            rAxisName: field.rAxisName,
            isLastVolume: field.isLastVolume,
            UPDATED_TIME: field.UPDATED_TIME
        };
        form.val("layuiadmin-coil-form", formData);
        advancedFormData = $.extend(advancedFormData, formData);
    });


    function reloadData(formData) {
        //读取表格数据 表格id
        table.reload("LAY-app-coil-list-reload", {
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
        form.val("layuiadmin-coil-form", {
            rAxisName: data.rAxisName,
            isLastVolume: data.isLastVolume,
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
            var submit = $("#LAY-app-coil-search");
            submit.click();
            return false;
        },
        query: function () {
            var url = "<%=request.getContextPath() %>/report/coil_form_query.jsp";
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
                    var submit = layero.find("iframe").contents().find("#LAY-app-coil-search-advanced");
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
    table.on("toolbar(LAY-app-coil-list)", function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    // 表格排序
    table.on("sort(LAY-app-coil-list)", function (obj) {
        table.reload("LAY-app-coil-list-reload", {
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
        elem: "#LAY-app-coil-list",
        id: "LAY-app-coil-list-reload",
        url: "<%=request.getContextPath() %>/report/CoilDiameterRecord/query",
        method: "get",
        height: "full-" + getFullSize(),
        page: true,
        limit: 100,
        toolbar: "#toolbar",
        defaultToolbar: [{
            title: "查询",
            layEvent: "search",
            icon: "layui-icon layui-icon-search layuiadmin-button-btn",
        }, {
            title: "高级查询",
            layEvent: "query",
            icon: "icon iconfont icon-gaojichaxun",
        }, "filter"],
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
        limits: [100, 150, 200, 300],
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
            field: "resource",
            title: "设备资源号",
            align: "center",
            hide: isHidden("resource"),
            minWidth: 120
        }, {
            field: "sfcPreData",
            title: "放卷SFC",
            align: "center",
            minWidth: 100,
            hide: isHidden("sfcPreData")
        }, {
            field: "uDiamRealityValue",
            title: "放卷卷径",
            align: "center",
            minWidth: 120,
            hide: isHidden("uDiamRealityValue")
        }, {
            field: "rAxisName",
            title: "收卷轴名称",
            align: "center",
            hide: isHidden("rAxisName"),
            minWidth: 120
        }, {
            field: "rProcessLotPre",
            title: "收卷载具号",
            align: "center",
            hide: isHidden("rProcessLotPre"),
            minWidth: 120
        }, {
            field: "sfcData",
            title: "收卷SFC",
            align: "center",
            hide: isHidden("sfcData"),
            minWidth: 120
        }, {
            field: "rDiamRealityValue",
            title: "收卷卷径",
            align: "center",
            hide: isHidden("rDiamRealityValue"),
            minWidth: 120
        }, {
            field: "isLastVolume",
            title: "是否最后一卷",
            align: "center",
            minWidth: 120,
            hide: isHidden("isLastVolume"),
            templet: function (d) {
                if (d.isLastVolume == 0) {
                    return "否";
                } else if (d.isLastVolume == 1) {
                    return "是"
                }else{
                    return "";
                }
            }
        }, {
            field: "unwindIsOver",
            title: "放卷物料是否消耗完成",
            align: "center",
            minWidth: 180,
            hide: isHidden("unwindIsOver"),
            templet: function (d) {
                if (d.unwindIsOver == 0) {
                    return "否";
                } else if (d.unwindIsOver == 1) {
                    return "是"
                }else{
                    return "";
                }
            }
        }, {
            field: "remark",
            title: "放卷异常信息记录",
            align: "center",
            hide: isHidden("remark"),
            minWidth: 150
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

        //启用下拉框监听事件
        form.on("select(isLastVolume)", function (data) {
            var submit = $("#LAY-app-coil-search");
            submit.click();
        });

        // 文本框回车事件
        $(".layui-input").on("keydown", function (event) {
            if (event.keyCode == 13) {
                focusName = event.target.name;
                var submit = $("#LAY-app-coil-search");
                submit.click();
                return false;
            }
        });
    }

    $(window).resize(function () {
        table.reload("LAY-app-coil-list-reload", {
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