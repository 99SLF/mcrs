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
</head>
<body>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item layui-col-space12" >
                <div class="layui-inline">
                    <label class="layui-form-label">预警规则编码：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="alarmRuleId" placeholder="请输入编码" autocomplete="off"
                               class="layui-input">
                    </div>
                    <label class="layui-form-label">预警规则标题：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="alarmRuleTitle" placeholder="请输入预警规则标题" autocomplete="off"
                               class="layui-input">
                    </div>
                    <label class="layui-form-label">监控层级：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="monitorLevel" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">状态：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="enable" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                    <label class="layui-form-label">预警事件编码：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="alarmEventId" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                    <label class="layui-form-label">监控对象：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="monitorObject" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline layui-search">
                    <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-alarmRulelist-search"
                            id="LAY-app-alarmRulelist-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
                <div class="layui-inline" >
                    <label class="layui-form-label">制单人：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="ruleMakeFormPeople" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                    <label class="layui-form-label">制单时间：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="ruleMakeFormTime" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                    <div class="layui-input-inline">
                        <input type="hidden" name="test" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>

            </div>
        </div>

        <div class="layui-card-body">
            <div class="layui-toolbar" id="toolbar" hidden="true">
                <button class="layui-btn layuiadmin-btn-list layui-btn-sm" lay-event="add"><i
                        class="layui-icon layui-icon-add-circle-fine"></i>新增规则
                </button>
            </div>

            <table id="LAY-app-alarmRule-list" lay-filter="LAY-app-alarmRule-list"></table>

            <script type="text/html" id="table-alarmRule-list">
                <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i
                        class="layui-icon layui-icon-edit"></i>编辑</a>
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

    //监听搜索
    form.on("submit(LAY-app-alarmRulelist-search)", function (data) {
        var field = data.field;
        table.reload("LAY-app-alarmRule-list-reload", {
            where: field
        });
    });


    //文本框回车事件
    $(".layui-input").on("keydown", function (event) {
        if (event.keyCode == 13) {
            var submit = $("#LAY-app-alarmRulelist-search");
            submit.click();
            return false;
        }
    });

    var active = {
        //设备新建
        add: function () {
            top.layer.open({
                type: 2,
                title: "设备新建",
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
    };

    table.on('sort(LAY-app-alarmRule-list)', function (obj) {
        table.reload('LAY-app-alarmRule-list-reload', {
            initSort: obj,
            where: {
                sortField: obj.field,
                sortOrder: obj.type
            }
        });
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
    });

    // 查询过滤字段
    $.ajax({
        url: "com.zimax.components.coframe.tools.ColsFilter.queryHiddenField.biz.ext",
        type: "POST",
        async: false,
        data: JSON.stringify({
            funName: funName
        }),
        cache: false,
        contentType: "text/json",
        success: function (result) {
            if (result) {
                hiddenFields = result.colsFilters;
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
        defaultToolbar: ["filter"],
        colHideChange: function (col, checked) {
            var field = col.field;
            var hidden = col.hide;
            $.ajax({
                url: "com.zimax.components.coframe.tools.ColsFilter.setHiddenField.biz.ext",
                type: "POST",
                data: JSON.stringify({
                    hidden: hidden,
                    colsFilter: {
                        funName: funName,
                        field: field
                    }
                }),
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
            minWidth: 120,
            hide: isHidden("alarmRuleId")
        }, {
            field: "alarmRuleTitle",
            title: "预警规则标题",
            align: "center",
            minWidth: 120,
            hide: isHidden("alarmRuleTitle")
        }, {
            field: "enable",
            title: "是否启用",
            align: "center",
            minWidth: 120,
            hide: isHidden("enable")
        }, {
            field: "monitorLevel",
            title: "监控层级",
            align: "center",
            minWidth: 100,
            hide: isHidden("monitorLevel")
        }, {
            field: "alarmEventId",
            title: "预警事件编码",
            align: "center",
            minWidth: 150,
            hide: isHidden("alarmEventId")
        }, {
            field: "monitorObject",
            title: "监控对象",
            align: "center",
            minWidth: 150,
            hide: isHidden("monitorObject")
        }, {
            field: "alarmRuleDescribe",
            title: "规则描述",
            align: "center",
            minWidth: 120,
            hide: isHidden("alarmRuleDescribe")
        }, {
            field: "ruleMakeFormPeople",
            title: "制单人",
            align: "center",
            minWidth: 120,
            hide: isHidden("ruleMakeFormPeople")
        }, {
            field: "ruleMakeFormTime",
            title: "制单时间",
            align: "center",
            minWidth: 100,
            hide: isHidden("ruleMakeFormTime")
        }, {
            field: "ruleUpdatePeople",
            title: "修改人",
            align: "center",
            minWidth: 120,
            hide: isHidden("ruleUpdatePeople")
        }, {
            field: "ruleUpdateTime",
            title: "修改时间",
            align: "center",
            minWidth: 100,
            hide: isHidden("ruleUpdateTime")
        }, {
            title: "操作",
            align: "center",
            fixed: "right",
            width: 200,
            toolbar: "#table-alarmRule-list"
        }]]
    });

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
                    url: "<%= request.getContextPath() %>/warn/alarmRule/delete/" + data.alarmRuleId,
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