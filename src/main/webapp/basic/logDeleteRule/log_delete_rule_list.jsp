<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 林俊杰
  - Date: 2022-12-22 11:23:00
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>日志删除规则管理</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.0">
</head>
<body>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">日志删除规则编码：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="deleteRuleNum" placeholder="请输入编码" autocomplete="off"
                               class="layui-input">
                    </div>
                    <label class="layui-form-label">日志删除规则标题：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="deleteRuleTitle" placeholder="请输入标题" autocomplete="off"
                               class="layui-input">
                    </div>
                    <label class="layui-form-label">规则级别：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="ruleLevel" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">规则类型：</label>
                    <div class="layui-input-inline">
                        <select name="deleteRuleType" id="deleteRuleType" lay-filter="" type="select">
                            <option value=""></option>
                        </select>
                    </div>
                    <label class="layui-form-label">制单人：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="creator" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                    <div class="layui-inline layui-search">
                        <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-logDeleteRulelist-search"
                                id="LAY-app-logDeleteRulelist-search">
                            <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                        </button>
                    </div>
                </div>

            </div>
        </div>

        <div class="layui-card-body">
            <div class="layui-toolbar" id="toolbar" hidden="true">
                <button class="layui-btn layuiadmin-btn-list layui-btn-sm" lay-event="add"><i
                        class="layui-icon layui-icon-add-circle-fine"></i>删除规则新增
                </button>
                <button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="enable"><i
                        class="layui-icon layui-icon-ok-circle"></i>启用
                </button>
                <button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="batchdel"><i
                        class="layui-icon layui-icon-delete"></i>删除
                </button>
            </div>

            <table id="LAY-app-logDeleteRule-list" lay-filter="LAY-app-logDeleteRule-list"></table>

            <script type="text/html" id="table-logDeleteRule-list">
                <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i
                        class="layui-icon layui-icon-edit"></i>修改</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i
                        class="layui-icon layui-icon-delete"></i>删除</a>
            </script>
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

    //全局参数
    var req_data;

    //功能名
    var funName = "list";

    var hiddenFields = [];

    // var laydate = layui.laydate;
    // //日期时间选择器
    // laydate.render({
    //     elem: '#makeFormTime',
    //     type: 'date'
    // });

    //获取规则类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#deleteRuleType",
        dictTypeId: "WRANING_TYPE",
    });
    //设置预警类型的默认值
    form.render();

    //监听搜索
    form.on("submit(LAY-app-logDeleteRulelist-search)", function (data) {
        var field = data.field;
        table.reload("LAY-app-logDeleteRule-list-reload", {
            where: field
        });
    });


    //文本框回车事件
    $(".layui-input").on("keydown", function (event) {
        if (event.keyCode == 13) {
            var submit = $("#LAY-app-logDeleteRulelist-search");
            submit.click();
            return false;
        }
    });

    var active = {
        //删除规则添加
        add: function () {
            top.layer.open({
                type: 2,
                title: "删除规则添加",
                content: "<%= request.getContextPath() %>/basic/logDeleteRule/log_delete_rule_add.jsp",
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
        },
        //批量删除
        batchdel: function () {
            var checkStatus = table.checkStatus("LAY-app-logDeleteRule-list-reload");
            var data = checkStatus.data;
            if (data.length == 0) {
                layer.msg("请至少选中一条记录！");
            }
            if (data.length > 0) {
                var ruleDeleteIds = new Array();
                for (var i = 0; i < data.length; i++) {
                    ruleDeleteIds[i] = data[i].ruleDeleteId;
                }
                layer.confirm("确定删除所选日志删除规则？", {
                    icon: 3,
                    title: "系统提示"
                }, function (index) {
                    $.ajax({
                        url: "<%= request.getContextPath() %>/logDeleteRule/logDeleteRule/batchDelete",
                        type: "DELETE",
                        data: JSON.stringify(ruleDeleteIds),
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
                                    table.reload("LAY-app-logDeleteRule-list-reload");
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
        },
        enable: function () {
            var checkStatus = table.checkStatus("LAY-app-logDeleteRule-list-reload");
            var data = checkStatus.data;
            if (data.length == 0) {
                layer.msg("请至少选中一条记录！");
            }
            if (data.length > 0) {
                var ruleDeleteIds = new Array();
                for (var i = 0; i < data.length; i++) {
                    ruleDeleteIds[i] = data[i].ruleDeleteId;
                }
                layer.confirm("确定启用所选日志删除规则？", {
                    icon: 3,
                    title: "系统提示"
                }, function (index) {
                    $.ajax({
                        url: "<%= request.getContextPath() %>/logDeleteRule/logDeleteRule/enable",
                        type: "POSt",
                        data: JSON.stringify(ruleDeleteIds),
                        cache: false,
                        contentType: "text/json",
                        success: function (result) {
                            if (result.exception) {
                                layer.alert(result.exception.message, {
                                    icon: 2,
                                    title: "系统提示"
                                });
                            } else if (result) {
                                layer.msg("启用成功", {
                                    icon: 1,
                                    time: 2000
                                }, function () {
                                    table.reload("LAY-app-logDeleteRule-list-reload");
                                });
                            } else {
                                layer.msg("启用失败");
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

    table.on('sort(LAY-app-logDeleteRule-list)', function (obj) {
        table.reload('LAY-app-logDeleteRule-list-reload', {
            initSort: obj,
            where: {
                sortField: obj.field,
                sortOrder: obj.type
            }
        });
    });

    //左侧表头按钮事件监听
    table.on("toolbar(LAY-app-logDeleteRule-list)", function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    //表格排序
    table.on("sort(LAY-app-logDeleteRule-list)", function (obj) {
        table.reload("LAY-app-logDeleteRule-list-reload", {
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
        table.reload("LAY-app-logDeleteRule-list-reload", {
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


    table.render({
        elem: "#LAY-app-logDeleteRule-list",
        id: "LAY-app-logDeleteRule-list-reload",
        url: "<%= request.getContextPath() %>/logDeleteRule/logDeleteRule/query",
        method: "GET",
        height: "full-" + getFullSize(),
        page: true,
        limit: 10,
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
            debugger;
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
            field: "deleteRuleNum",
            title: "日志删除规则编码",
            align: "center",
            minWidth: 120,
            hide: isHidden("deleteRuleNum")
        }, {
            field: "deleteRuleTitle",
            title: "日志删除标题",
            align: "center",
            minWidth: 120,
            hide: isHidden("deleteRuleTitle")
        }, {
            field: "enable",
            title: "是否启用",
            align: "center",
            minWidth: 120,
            hide: isHidden("enable")
        }, {
            field: "deleteRuleType",
            title: "日志删除规则类型",
            align: "center",
            minWidth: 100,
            hide: isHidden("deleteRuleType")
        }, {
            field: "ruleLevel",
            title: "规则级别",
            align: "center",
            minWidth: 150,
            hide: isHidden("ruleLevel")
        }, {
            field: "timeInterval",
            title: "时间间隔",
            align: "center",
            minWidth: 150,
            hide: isHidden("timeInterval")
        }, {
            field: "timeUnit",
            title: "时间单位",
            align: "center",
            minWidth: 120,
            hide: isHidden("timeUnit")
        }, {
            field: "creator",
            title: "制单人",
            align: "center",
            minWidth: 100,
            hide: isHidden("creator")
        }, {
            field: "createTime",
            title: "制单时间",
            align: "center",
            minWidth: 120,
            hide: isHidden("createTime")
        }, {
            field: "updater",
            title: "修改人",
            align: "center",
            minWidth: 100,
            hide: isHidden("updater")
        }, {
            field: "updateTime",
            title: "修改时间",
            align: "center",
            minWidth: 120,
            hide: isHidden("updateTime")
        }, {
            title: "操作",
            align: "center",
            fixed: "right",
            width: 200,
            toolbar: "#table-logDeleteRule-list"
        }]]
    });

    //监听操作事件
    table.on("tool(LAY-app-logDeleteRule-list)", function (e) {
        var data = e.data;
        if (e.event == "edit") {
            top.layer.open({
                type: 2,
                title: "编辑日志删除规则信息",
                content: "<%= request.getContextPath() %>/basic/logDeleteRule/log_delete_rule_edit.jsp",
                area: ["800px", "560px"],
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
                    url: "<%= request.getContextPath() %>/logDeleteRule/logDeleteRule/delete/" + data.ruleDeleteId,
                    type: "DElETE",
                    data: JSON.stringify({
                        logDeleteRule: data
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
                                table.reload("LAY-app-logDeleteRule-list-reload");
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