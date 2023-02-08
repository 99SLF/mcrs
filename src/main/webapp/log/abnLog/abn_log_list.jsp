<!--
- Author(s): 林俊杰
- Date: 2023-1-4 16:06:11
- Description:
-->
<%@page pageEncoding="UTF-8" %>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>异常日志页面</title>
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
<%--<div class="layui-card">--%>
<%--    <div class="layui-form layui-card-header layuiadmin-card-header-auto">--%>
<%--        <div class="layui-form-item">--%>

<%--            <div class="layui-inline">--%>
<%--                <label class="layui-form-label">设备名称：</label>--%>
<%--                <div class="layui-input-inline">--%>
<%--                    <input type="text" name="equipmentName" value="" placeholder="" autocomplete="off"--%>
<%--                           class="layui-input">--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <div class="layui-inline">--%>
<%--                <label class="layui-form-label">终端名称：</label>--%>
<%--                <div class="layui-input-inline">--%>
<%--                    <input type="text" name="deviceName" value="" placeholder="" autocomplete="off" class="layui-input">--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <div class="layui-inline">--%>
<%--                <label class="layui-form-label">预警类型：</label>--%>
<%--                <div class="layui-input-inline">--%>
<%--                    <select name="abnType" id="abnType" lay-filter="abnType" type="select">--%>
<%--                        <option value=""></option>--%>
<%--                    </select>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <div class="layui-inline">--%>
<%--                <label class="layui-form-label">预警等级：</label>--%>
<%--                <div class="layui-input-inline">--%>
<%--                    <select name="abnLevel" id="abnLevel" lay-filter="abnLevel" type="select">--%>
<%--                        <option value=""></option>--%>
<%--                    </select>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <div class="layui-inline">--%>
<%--                <label class="layui-form-label">交互时间：</label>--%>
<%--                <div class="layui-input-inline">--%>
<%--                    <input type="text" name="equipmentExchangeTime" value="" placeholder="" id="exchangeTime"--%>
<%--                           autocomplete="off" class="layui-input">--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="layui-inline layui-search">--%>
<%--                <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-rolelist-search"--%>
<%--                        id="LAY-app-rolelist-search">--%>
<%--                    <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>--%>
<%--                </button>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    <div class="layui-card-body">--%>
<%--        &lt;%&ndash;        <div class="layui-toolbar" id="toolbar" hidden="true">&ndash;%&gt;--%>
<%--        &lt;%&ndash;            <button class="layui-btn layuiadmin-btn-list layui-btn-sm"  lay-event="add"><i class="layui-icon layui-icon-add-circle-fine"></i>添加</button>&ndash;%&gt;--%>
<%--        &lt;%&ndash;            <button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="batchdel"><i class="layui-icon layui-icon-delete"></i>删除</button>&ndash;%&gt;--%>
<%--        &lt;%&ndash;        </div>&ndash;%&gt;--%>
<%--        <table id="LAY-app-abnLog-list" lay-filter="LAY-app-abnLog-list"></table>--%>
<%--        &lt;%&ndash;        <script type="text/html" id="table-role-list">&ndash;%&gt;--%>
<%--        &lt;%&ndash;            <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>&ndash;%&gt;--%>
<%--        &lt;%&ndash;            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>&ndash;%&gt;--%>
<%--        &lt;%&ndash;        </script>&ndash;%&gt;--%>
<%--    </div>--%>
<%--</div>--%>
<div class="layui-card">
    <script type="text/html" id="toolbar">
        <div class="layui-form layuiadmin-card-header-auto" lay-filter="layuiadmin-abnLog-form" id="layuiadmin-abnLog-form">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">设备名称：</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="equipmentName" autocomplete="off" />
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">终端名称：</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="deviceName" autocomplete="off" />
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">预警类型：</label>
                    <div class="layui-input-inline">
                        <select name="abnType" id="abnType" lay-filter="abnType"
                                type="select">
                            <option value=""></option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline layui-hide">
                    <button id="LAY-app-abnLog-search" class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-abnLog-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
    </script>
    <div class="layui-card-body">
        <table id="LAY-app-abnLog-list" lay-filter="LAY-app-abnLog-list"></table>
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
    var admin = layui.admin;
    var view = layui.view;

    //时间工具类引用
    var util = layui.util;
    //过滤字段
    var hiddenFields = [];
    //功能名
    var funName = "abn_log_list";
    // 高级查询参数
    var advancedFormData = {};
    // 焦点名称
    var focusName = null;

    var laydate = layui.laydate;


    // 监听搜索
    form.on("submit(LAY-app-abnLog-search)", function(data) {
        var field = data.field;
        reloadData(field);
        var formData = {
            equipmentName: field.equipmentName,
            deviceName: field.deviceName,
            abnType: field.abnType
        };
        form.val("layuiadmin-abnLog-form", formData);
        advancedFormData = $.extend(advancedFormData, formData);
    });

    function reloadData(formData) {
        //读取表格数据 表格id
        table.reload("LAY-app-abnLog-list-reload", {
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
        form.val("layuiadmin-abnLog-form", {
            equipmentName: data.equipmentName,
            deviceName: data.deviceName,
            abnType: data.abnType
        });
    }




    function getFullSize() {
        var header = $(".layui-card-header");
        var cardbody = $(".layui-card-body");
        return header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height()) + 1;
    }

    //右侧表头按钮事件监听
    table.on('toolbar(LAY-app-abnLog-list)', function(obj){
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    //表格排序
    table.on('sort(LAY-app-abnLog-list)', function (obj) {
        table.reload('LAY-app-abnLog-list-reload', {
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

    // 监听按钮点击事件
    var active = {
        search: function() {
            var submit = $("#LAY-app-abnLog-search");
            submit.click();
            return false;
        },
        query: function() {
            var url = "<%=request.getContextPath() %>/log/abnLog/abnLog_form_query.jsp";
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
                    var submit = layero.find("iframe").contents().find("#LAY-app-abnLog-search-advanced");
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
        elem: "#LAY-app-abnLog-list",
        id: "LAY-app-abnLog-list-reload",
        url: "<%= request.getContextPath() %>/log/abnLog/query",
        method: "get",
        height: "full-" + getFullSize(),
        page: true,
        limit: 10,
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
        cols: [[
            {
                type: "checkbox"
            }, {
                title: "序号",
                type: "numbers"
            }, {
                field: "equipmentId",
                title: "设备资源号",
                align: "center",
                hide: isHidden("equipmentId"),
                minWidth: 100

            }, {
                field: "equipmentName",
                title: "设备名称",
                align: "center",
                hide: isHidden("equipmentName"),
                minWidth: 100

            }, {
                field: "aPPId",
                title: "APPId",
                align: "center",
                hide: isHidden("aPPId"),
                minWidth: 300
            }, {
                field: "deviceName",
                title: "终端名称",
                align: "center",
                hide: isHidden("deviceName"),
                minWidth: 150
            }, {
                field: "abnTitle",
                title: "预警标题",
                align: "center",
                hide: isHidden("abnTitle"),
                minWidth: 150
            }, {
                field: "abnType",
                title: "预警类型",
                align: "center",
                hide: isHidden("abnType"),
                minWidth: 120,
                templet: function (d) {
                    return layui.admin.getDictText("WRANING_TYPE", d.abnType);
                }
            }, {
                field: "abnLevel",
                title: "预警等级",
                align: "center",
                hide: isHidden("abnLevel"),
                minWidth: 120,
                templet: function (d) {
                    return layui.admin.getDictText("WARNING_LEVEL", d.abnLevel);
                }
            }, {
                field: "abnContent",
                title: "预警内容",
                align: "center",
                hide: isHidden("abnContent"),
                minWidth: 200
            }, {
                field: "equipmentExchangeTime",
                title: "交互时间",
                align: "center",
                hide: isHidden("equipmentExchangeTime"),
                minWidth: 220,
                templet: function (d) {
                    if(d.equipmentExchangeTime!=null){
                        return layui.util.toDateString(d.equipmentExchangeTime);
                    }else{
                        return '';
                    }
                }
            }

        ]]
    });
    formReder();

    function formReder() {
        // 文本框回车事件
        $(".layui-input").on("keydown", function (event) {
            if (event.keyCode == 13) {
                focusName = event.target.name;
                var submit = $("#LAY-app-abnLog-search");
                submit.click();
                return false;
            }
        });

        //预警类型下拉框监听事件
        form.on('select(abnType)', function (data) {
            var submit = $("#LAY-app-abnLog-search");
            submit.click();
        });
        form.render();

        //获取预警类型的下拉值
        layui.admin.renderDictSelect({
            elem: "#abnType",
            dictTypeId: "WRANING_TYPE",
        });
        form.render();
    }

    $(window).resize(function () {
        table.reload("LAY-app-abnLog-list-reload", {
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