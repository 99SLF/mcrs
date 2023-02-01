<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 林俊杰
  - Date: 2022-12-01 16:18:16
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>接口日志</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v1">
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
        <div class="layui-form layuiadmin-card-header-auto" lay-filter="layuiadmin-interfaceLog-form"
             id="layuiadmin-interfaceLog-form">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">来源：</label>
                    <div class="layui-input-inline">
                        <select name="source" id="source" lay-filter="source"
                                type="select">
                            <option value=""></option>
                        </select>
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">接口类型：</label>
                    <div class="layui-input-inline">
                        <select name="interfaceType" id="interfaceType" lay-filter="interfaceType"
                                type="select">
                            <option value=""></option>
                        </select>
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">设备名称：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="equipmentName" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>

                <div class="layui-inline layui-hide">
                    <button id="LAY-app-interfaceLog-search" class="layui-btn layuiadmin-btn-list" lay-submit
                            lay-filter="LAY-app-interfaceLog-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
    </script>
    <div class="layui-card-body">
        <table id="LAY-app-interfaceLog-list" lay-filter="LAY-app-interfaceLog-list"></table>
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
    var admin = layui.admin;
    var view = layui.view;
    //全局参数
    var req_data;

    var formData = {};

    //功能名
    var funName = "interface_log_list";

    var hiddenFields = [];
    // 高级查询参数
    var advancedFormData = {};
    // 焦点名称
    var focusName = null;

    var laydate = layui.laydate;
    //日期时间选择器
    laydate.render({
        elem: '#createTime',
        type: 'date'
    });

    // 监听搜索
    form.on("submit(LAY-app-interfaceLog-search)", function(data) {
        var field = data.field;
        reloadData(field);
        formData = {
            source: field.source,
            interfaceType: field.interfaceType,
            equipmentName: field.equipmentName
        };
        form.val("layuiadmin-interfaceLog-form", formData);
        advancedFormData = $.extend(advancedFormData, formData);
    });


    function reloadData(formData) {
        //读取表格数据 表格id
        table.reload("LAY-app-interfaceLog-list-reload", {
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
        form.val("layuiadmin-interfaceLog-form", {
            source: data.source,
            interfaceType: data.interfaceType,
            equipmentName: data.equipmentName
        });
    }

    table.on('sort(LAY-app-interfaceLog-list)', function (obj) {
        table.reload('LAY-app-interfaceLog-list-reload', {
            initSort: obj,
            where: {
                sortField: obj.field,
                sortOrder: obj.type
            }
        });
    });

    //左侧表头按钮事件监听
    table.on("toolbar(LAY-app-interfaceLog-list)", function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    //表格排序
    table.on("sort(LAY-app-interfaceLog-list)", function (obj) {
        table.reload("LAY-app-interfaceLog-list-reload", {
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
        table.reload("LAY-app-interfaceLog-list-reload", {
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

    // 监听按钮点击事件
    var active = {
        search: function() {
            var submit = $("#LAY-app-interfaceLog-search");
            submit.click();
            return false;
        },
        query: function() {
            var url = "<%=request.getContextPath() %>/log/interfaceLog/interfaceLog_form_query.jsp";
            admin.popupRight({
                type: 2,
                content: [url, "yes"],
                btn: ["查询", "重置", "取消"],
                success: function(layero, index) {
                    var dataJson = {
                        win : window,
                        data: advancedFormData
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function(index, layero) {
                    var submit = layero.find("iframe").contents().find("#LAY-app-interfaceLog-search-advanced");
                    submit.click();
                    top.layer.close(index);
                },
                btn2: function(index, layero) {
                    layero.find("iframe")[0].contentWindow.reset();
                }
            });
        }
    };


    table.render({
        elem: "#LAY-app-interfaceLog-list",
        id: "LAY-app-interfaceLog-list-reload",
        url: "<%= request.getContextPath() %>/log/interfaceLog/query",
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
        parseData: function (res) {
            return {
                code: res.code,
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
            field: "source",
            title: "来源",
            align: "center",
            minWidth: 120,
            hide: isHidden("source"),
            templet: function (d) {
                return layui.admin.getDictText("SOURCE", d.source);
            }
        }, {
            field: "equipmentId",
            title: "设备资源号",
            align: "center",
            minWidth: 150,
            hide: isHidden("equipmentId")
        }, {
            field: "equipmentName",
            title: "设备名称",
            align: "left",
            minWidth: 150,
            hide: isHidden("equipmentName")
        }, {
            field: "aPPId",
            title: "APPID",
            align: "center",
            minWidth: 300,
            hide: isHidden("aPPId")
        }, {
            field: "interfaceType",
            title: "接口类型",
            align: "center",
            minWidth: 150,
            hide: isHidden("interfaceType"),
            templet: function (d) {
                return layui.admin.getDictText("API_TYPE", d.interfaceType);
            }
        }, {
            field: "equipmentIp",
            title: "设备接入IP地址",
            align: "center",
            minWidth: 150,
            hide: isHidden("equipmentIp")
        }, {
            field: "equipmentContinuePort",
            title: "接入端口号",
            align: "center",
            minWidth: 120,
            hide: isHidden("equipmentContinuePort")
        }, {
            field: "createTime",
            title: "创建时间",
            align: "center",
            minWidth: 200,
            hide: isHidden("createTime"),
            templet: function (d) {
                return layui.util.toDateString(d.createTime);
            }
        }, {
            field: "json",
            title: "JSON包",
            align: "center",
            minWidth: 120,
            hide: isHidden("json")
        }, {
            field: "result",
            title: "处理结果",
            align: "center",
            minWidth: 100,
            hide: isHidden("result"),
            templet: function (d) {
                return layui.admin.getDictText("DISPOSE_RESULT", d.result);
            }
        }, {
            field: "disposeStartTime",
            title: "处理开始时间",
            align: "center",
            minWidth: 200,
            hide: isHidden("disposeStartTime"),
            templet: function (d) {
                return layui.util.toDateString(d.disposeStartTime);
            }
        }, {
            field: "disposeEndTime",
            title: "处理结束时间",
            align: "center",
            minWidth: 200,
            hide: isHidden("disposeEndTime"),
            templet: function (d) {
                return layui.util.toDateString(d.disposeEndTime);
            }
        }, {
            field: "invokerName",
            title: "调用者",
            align: "center",
            minWidth: 120,
            hide: isHidden("invokerName")
        }, {
            field: "disposeTime",
            title: "处理时长",
            align: "center",
            minWidth: 200,
            hide: isHidden("disposeTime")
        }, {
            field: "interfaceName",
            title: "接口名称",
            align: "center",
            minWidth: 120,
            hide: isHidden("interfaceName")
        }]]
    });

    formReder();

    function formReder() {
        // 文本框回车事件
        $(".layui-input").on("keydown", function (event) {
            if (event.keyCode == 13) {
                focusName = event.target.name;
                var submit = $("#LAY-app-interfaceLog-search");
                submit.click();
                return false;
            }
        });


        //来源下拉框监听事件
        form.on("select(source)", function (data) {
            var submit = $("#LAY-app-interfaceLog-search");
            submit.click();
        });
        //接口类型下拉框监听事件
        form.on("select(interfaceType)", function (data) {
            var submit = $("#LAY-app-interfaceLog-search");
            submit.click();
        });

        //获取接口类型的下拉值
        layui.admin.renderDictSelect({
            elem: "#interfaceType",
            dictTypeId: "API_TYPE",
        });
        form.render();

        //获取来源的下拉值
        layui.admin.renderDictSelect({
            elem: "#source",
            dictTypeId: "SOURCE",
        });
        form.render();

        form.val("layuiadmin-interfaceLog-form", formData);
    }
</script>
</body>
</html>