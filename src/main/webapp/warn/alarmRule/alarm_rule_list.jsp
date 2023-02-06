<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 林俊杰
  - Date: 2022-12-1 23:26:11
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>预警规则管理</title>
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
<%--<div class="layui-fluid">--%>
<%--    <div class="layui-card">--%>
<%--        <div class="layui-form layui-card-header layuiadmin-card-header-auto">--%>
<%--            <div class="layui-form-item">--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label">预警规则编码：</label>--%>
<%--                    <div class="layui-input-inline">--%>
<%--                        <input type="text" name="alarmRuleId" placeholder="" autocomplete="off"--%>
<%--                               class="layui-input">--%>
<%--                    </div>--%>
<%--                </div>--%>

<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label">预警规则标题：</label>--%>
<%--                    <div class="layui-input-inline">--%>
<%--                        <input type="text" name="alarmRuleTitle" placeholder="" autocomplete="off"--%>
<%--                               class="layui-input">--%>
<%--                    </div>--%>
<%--                </div>--%>

<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label">监控层级：</label>--%>
<%--                    <div class="layui-input-inline">--%>
<%--                        <select name="monitorLevel" id="monitorLevel" lay-filter="monitorLevel" type="select">--%>
<%--                            <option value=""></option>--%>
<%--                        </select>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label">状态：</label>--%>
<%--                    <div class="layui-input-inline">--%>
<%--                        <select name="enable" id="enable" lay-filter="enable" type="select">--%>
<%--                            <option value=""></option>--%>
<%--                        </select>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label">预警级别：</label>--%>
<%--                    <div class="layui-input-inline">--%>
<%--                        <select name="alarmLevel" id="alarmLevel" lay-filter="alarmLevel" type="select">--%>
<%--                            <option value=""></option>--%>
<%--                        </select>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label">预警事件编码：</label>--%>
<%--                    <div class="layui-input-inline">--%>
<%--                        <input type="text" name="alarmEventId" placeholder="" autocomplete="off"--%>
<%--                               class="layui-input">--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label">制单人：</label>--%>
<%--                    <div class="layui-input-inline">--%>
<%--                        <input type="text" name="createName" placeholder="" autocomplete="off"--%>
<%--                               class="layui-input">--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label">制单时间：</label>--%>
<%--                    <div class="layui-input-inline">--%>
<%--                        <input type="text" name="ruleMakeFormTime" id="ruleMakeFormTime" placeholder=""--%>
<%--                               autocomplete="off"--%>
<%--                               class="layui-input">--%>
<%--                    </div>--%>

<%--                    <div class="layui-inline layui-search" style="padding-left: 50px">--%>
<%--                        <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-alarmRulelist-search"--%>
<%--                                id="LAY-app-alarmRulelist-search">--%>
<%--                            <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>--%>
<%--                        </button>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <div class="layui-card-body">--%>
<%--            <div class="layui-toolbar" id="toolbar" hidden="true">--%>
<%--                <button class="layui-btn layuiadmin-btn-list layui-btn-sm" lay-event="add"><i--%>
<%--                        class="layui-icon layui-icon-add-circle-fine"></i>新增规则--%>
<%--                </button>--%>
<%--                <button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="batchdel"><i--%>
<%--                        class="layui-icon layui-icon-delete"></i>删除--%>
<%--                </button>--%>
<%--            </div>--%>


<%--            <table id="LAY-app-alarmRule-list" lay-filter="LAY-app-alarmRule-list"></table>--%>

<%--            <script type="text/html" id="table-alarmRule-list">--%>
<%--                <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i--%>
<%--                        class="layui-icon layui-icon-edit"></i>编辑</a>--%>
<%--                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i--%>
<%--                        class="layui-icon layui-icon-delete"></i>删除</a>--%>
<%--            </script>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<div class="layui-card">
    <script type="text/html" id="toolbar">
        <div class="layui-form layuiadmin-card-header-auto" lay-filter="layuiadmin-alarmRule-form"
             id="layuiadmin-alarmRule-form">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">预警规则编码：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="alarmRuleId" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">预警规则标题：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="alarmRuleTitle" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">启用：</label>
                    <div class="layui-input-inline">
                        <select name="enable" id="enable" lay-filter="enable" type="select">
                            <option value=""></option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline layui-hide">
                    <button id="LAY-app-alarmRule-list-search" class="layui-btn layuiadmin-btn-list" lay-submit
                            lay-filter="LAY-app-alarmRule-list-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
    </script>
    <div class="layui-card-body">
        <table id="LAY-app-alarmRule-list" lay-filter="LAY-app-alarmRule-list"></table>

        <script type="text/html" id="table-alarmRule-list">
            <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i
                    class="layui-icon layui-icon-edit"></i>编辑</a>
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i
                    class="layui-icon layui-icon-delete"></i>删除</a>
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
    var submit = false;
    var isExist = false;
    var admin = layui.admin;
    var view = layui.view;

    //全局参数
    var req_data;

    //功能名
    var funName = "alarm_rule_list";

    // 高级查询参数
    var advancedFormData = {};
    // 焦点名称
    var focusName = null;

    var formData = {};

    var hiddenFields = [];

    var laydate = layui.laydate;


    //监听搜索
    form.on("submit(LAY-app-alarmRule-list-search)", function (data) {
        var field = data.field;
        reloadData(field);
        formData = {
            alarmRuleId: field.alarmRuleId,
            alarmRuleTitle: field.alarmRuleTitle,
            enable: field.enable
        };
        form.val("layuiadmin-alarmRule-form", formData);
        advancedFormData = $.extend(advancedFormData, formData);
    });

    function reloadData(formData) {
        table.reload("LAY-app-alarmRule-list-reload", {
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
        form.val("layuiadmin-alarmRule-form", {
            alarmRuleId: data.alarmRuleId,
            alarmRuleTitle: data.alarmRuleTitle,
            enable: data.enable
        });
    }


    var active = {
        //查询按钮
        search: function () {
            var submit = $("#LAY-app-alarmRule-list-search");
            submit.click();
            return false;
        },
        //高级搜索
        query: function () {
            var url = "<%=request.getContextPath() %>/warn/alarmRule/alarmRule_form_query.jsp";
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
                    var submit = layero.find("iframe").contents().find("#LAY-app-alarmRule-search-advanced");
                    submit.click();
                    top.layer.close(index);
                },
                btn2: function (index, layero) {
                    layero.find("iframe")[0].contentWindow.reset();
                }
            });
        },
        //预警规则新建
        add: function () {
            top.layer.open({
                type: 2,
                title: "预警规则新建",
                content: "<%= request.getContextPath() %>/warn/alarmRule/alarm_rule_add.jsp",
                area: ["1000px", "560px"],
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
        },
        //批量删除
        batchdel: function () {
            var checkStatus = table.checkStatus("LAY-app-alarmRule-list-reload");
            var data = checkStatus.data;
            if (data.length == 0) {
                layer.msg("请至少选中一条记录！");
            }
            if (data.length > 0) {
                var alarmRuleInts = new Array();
                for (var i = 0; i < data.length; i++) {
                    alarmRuleInts[i] = data[i].alarmRuleInt;
                }
                layer.confirm("确定删除所选预警规则？", {
                    icon: 3,
                    title: "系统提示"
                }, function (index) {
                    $.ajax({
                        url: "<%= request.getContextPath() %>/warn/alarmRule/batchDelete",
                        type: "DELETE",
                        data: JSON.stringify(alarmRuleInts),
                        cache: false,
                        contentType: "text/json",
                        success: function (result) {
                            if (result.exception) {
                                layer.alert(result.exception.message, {
                                    icon: 2,
                                    title: "系统提示"
                                });
                            } else if (result) {
                                layer.msg("删除成功", {
                                    icon: 1,
                                    time: 2000
                                }, function () {
                                    table.reload("LAY-app-alarmRule-list-reload");
                                    formReder();
                                });
                            } else {
                                layer.msg("删除失败");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            layer.msg(jqXHR.responseText, {
                                time: 2000,
                                icon: 5
                            });
                        }
                    });
                });
            }
        }
    };

    table.on('sort(LAY-app-alarmRule-list)', function (obj) {
        table.reload('LAY-app-alarmRule-list-reload', {
            initSort: obj,
            where: {
                sortField: obj.field,
                sortOrder: obj.type
            }
        });
        formReder();
    });

    //左侧表头按钮事件监听
    table.on("toolbar(LAY-app-alarmRule-list)", function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    //表格排序
    table.on("sort(LAY-app-alarmRule-list)", function (obj) {
        table.reload("LAY-app-alarmRule-list-reload", {
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
        table.reload("LAY-app-alarmRule-list-reload", {
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
        elem: "#LAY-app-alarmRule-list",
        id: "LAY-app-alarmRule-list-reload",
        url: "<%= request.getContextPath() %>/warn/alarmRule/query",
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
        }, {
            title: "新增预警规则",
            layEvent: "add",
            icon: "layui-icon layui-icon-add-circle-fine",
        }, {
            title: "批量删除",
            layEvent: "batchdel",
            icon: "layui-icon layui-icon-delete ",
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
            field: "alarmRuleId",
            title: "预警规则编码",
            align: "center",
            minWidth: 150,
            hide: isHidden("alarmRuleId"),
            //打开监听
            event: "view",
            //监听打开详情页面
            templet: function (data) {
                return '<span style="color: #09bbfd">' + data.alarmRuleId + '</span>';
            }
        }, {
            field: "alarmRuleTitle",
            title: "预警规则标题",
            align: "center",
            minWidth: 180,
            hide: isHidden("alarmRuleTitle")
        }, {
            field: "enable",
            title: "启用",
            align: "center",
            minWidth: 120,
            hide: isHidden("enable"),
            templet: function (d) {
                return layui.admin.getDictText("IS_USE", d.enable);
            }
        }, {
            field: "monitorLevel",
            title: "监控层级",
            align: "center",
            minWidth: 100,
            hide: isHidden("monitorLevel"),
            templet: function (d) {
                return layui.admin.getDictText("WARNING_LEVEL", d.monitorLevel);
            }
        }, {
            field: "alarmRuleId",
            title: "预警事件编码",
            align: "center",
            minWidth: 150,
            hide: isHidden("alarmEventId")
        }, {
            field: "alarmRuleDescribe",
            title: "规则描述",
            align: "center",
            minWidth: 150,
            hide: isHidden("alarmRuleDescribe")
        }, {
            field: "createName",
            title: "制单人",
            align: "center",
            minWidth: 120,
            hide: isHidden("createName")
        }, {
            field: "ruleMakeFormTime",
            title: "制单时间",
            align: "center",
            minWidth: 200,
            hide: isHidden("ruleMakeFormTime"),
            templet: function (d) {
                return layui.util.toDateString(d.ruleMakeFormTime);
            }
        }, {
            field: "updateName",
            title: "修改人",
            align: "center",
            minWidth: 120,
            hide: isHidden("updateName")
        }, {
            field: "ruleUpdateTime",
            title: "修改时间",
            align: "center",
            minWidth: 200,
            hide: isHidden("ruleUpdateTime"),
            templet: function (d) {
                if (d.ruleUpdateTime != null) {
                    return layui.util.toDateString(d.ruleUpdateTime);
                } else {
                    return '';
                }

            }
        }, {
            title: "操作",
            align: "center",
            fixed: "right",
            width: 200,
            toolbar: "#table-alarmRule-list"
        }]]
    });

    formReder();

    function formReder() {

        // 文本框回车事件
        $(".layui-input").on("keydown", function (event) {
            if (event.keyCode == 13) {
                focusName = event.target.name;
                var submit = $("#LAY-app-alarmRule-list-search");
                submit.click();
                return false;
            }
        });

        //启用下拉框监听事件
        form.on("select(enable)", function (data) {
            var submit = $("#LAY-app-alarmRule-list-search");
            submit.click();
        });

        //获取启用的下拉值
        layui.admin.renderDictSelect({
            elem: "#enable",
            dictTypeId: "IS_USE",
        });
        form.render();

        form.val("layuiadmin-alarmRule-form", formData);
    }

    //监听操作事件
    table.on("tool(LAY-app-alarmRule-list)", function (e) {
        var data = e.data;
        if (e.event == "edit") {
            top.layer.open({
                type: 2,
                title: "编辑设备信息",
                content: "<%= request.getContextPath() %>/warn/alarmRule/alarm_rule_edit.jsp",
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
                    var edit = layero.find("iframe").contents().find("#layuiadmin-app-form-edit");
                    edit.click();
                }

            });
        } else if (e.event == "del") {
            layer.confirm("确定删除该设备？", {
                icon: 3,
                title: "系统提示"
            }, function (index) {
                $.ajax({
                    url: "<%= request.getContextPath() %>/warn/alarmRule/delete/" + data.alarmRuleInt,
                    type: "DElETE",
                    data: JSON.stringify({
                        alarmRule: data
                    }),
                    cache: false,
                    contentType: "text/json",
                    success: function (result) {
                        if (result.exception) {
                            layer.alert(result.exception.message, {
                                icon: 2,
                                title: "系统提示"
                            });
                        } else if (result) {
                            layer.msg("删除成功", {
                                icon: 1,
                                time: 500
                            }, function () {
                                table.reload("LAY-app-alarmRule-list-reload");
                                formReder();
                            });
                        } else {
                            layer.msg("删除失败！", {
                                icon: 2,
                                time: 2000
                            });
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        layer.msg(jqXHR.responseText, {
                            time: 500,
                            icon: 5
                        });
                    }
                });
            });
        } else if (e.event == "view") {
            top.layer.open({
                type: 2,
                title: "查看预警规则详情",
                content: "<%= request.getContextPath() %>/warn/alarmRule/alarm_rule_view.jsp",
                area: ["1000px", "560px"],
                resize: false,
                // btn: ["确定", "取消"],
                success: function (layero, index) {
                    var dataJson = {
                        data: data,
                        win: window
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {
                    var edit = layero.find("iframe").contents().find("#layuiadmin-app-form-edit");
                    edit.click();
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