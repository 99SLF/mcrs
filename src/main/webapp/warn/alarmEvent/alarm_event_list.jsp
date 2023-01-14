<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 林俊杰
  - Date: 2022-12-01 16:06:00
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>预警信息</title>
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
                    <label class="layui-form-label">预警事件编码：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="alarmEventId" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">预警事件标题：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="alarmEventTitle" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">预警级别：</label>
                    <div class="layui-input-inline">
                        <select name="alarmLevel" id="alarmLevel" lay-filter="alarmLevel" type="select">
                            <option value=""></option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">预警类型：</label>
                    <div class="layui-input-block">
                        <select name="alarmType" id="alarmType" lay-filter="alarmType" type="select">
                            <option value=""></option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">制单人：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="makeFormPeople" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">制单时间：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="makeFormTime" placeholder="" id="makeFormTime"
                               autocomplete="off"
                               class="layui-input">
                    </div>

                    <div class="layui-inline layui-search" style="padding-left: 50px">
                        <button class="layui-btn layuiadmin-btn-list" lay-submit
                                lay-filter="LAY-app-alarmEventlist-search"
                                id="LAY-app-alarmEventlist-search">
                            <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-card-body">
            <div class="layui-toolbar" id="toolbar" hidden="true">
                <button class="layui-btn layuiadmin-btn-list layui-btn-sm" lay-event="add"><i
                        class="layui-icon layui-icon-add-circle-fine"></i>新增事件
                </button>
                <button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="enable"><i
                        class="layui-icon layui-icon-ok-circle"></i>启用
                </button>
                <button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="batchdel"><i
                        class="layui-icon layui-icon-delete"></i>删除
                </button>
            </div>

            <table id="LAY-app-alarmEvent-list" lay-filter="LAY-app-alarmEvent-list"></table>

            <script type="text/html" id="table-alarmEvent-list">
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
    var isExits = false;

    //全局参数
    var req_data;

    //功能名
    var funName = "list";

    var hiddenFields = [];

    var laydate = layui.laydate;
    //日期时间选择器
    laydate.render({
        elem: '#makeFormTime',
        type: 'date'
    });

    //获取预警类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#alarmType",
        dictTypeId: "WRANING_TYPE",
    });
    form.render();

    //获取预警级别的下拉值
    layui.admin.renderDictSelect({
        elem: "#alarmLevel",
        dictTypeId: "WARNING_LEVEL",
    });
    form.render();

    //监听搜索
    form.on("submit(LAY-app-alarmEventlist-search)", function (data) {
        var field = data.field;
        table.reload("LAY-app-alarmEvent-list-reload", {
            where: field
        });
    });

    //预警类型下拉框监听事件
    form.on("select(alarmType)", function (data) {
        var submit = $("#LAY-app-alarmEventlist-search");
        submit.click();
    });
    //预警级别下拉框监听事件
    form.on("select(alarmLevel)", function (data) {
        var submit = $("#LAY-app-alarmEventlist-search");
        submit.click();
    });


    //文本框回车事件
    $(".layui-input").on("keydown", function (event) {
        if (event.keyCode == 13) {
            var submit = $("#LAY-app-alarmEventlist-search");
            submit.click();
            return false;
        }
    });

    var active = {
        //预警事件新建
        add: function () {
            top.layer.open({
                type: 2,
                title: "预警事件新建",
                content: "<%= request.getContextPath() %>/warn/alarmEvent/alarm_event_add.jsp",
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
            var checkStatus = table.checkStatus("LAY-app-alarmEvent-list-reload");
            var data = checkStatus.data;
            if (data.length == 0) {
                layer.msg("请至少选中一条记录！");
            }
            if (data.length > 0) {
                var alarmEventInts = new Array();
                for (var i = 0; i < data.length; i++) {
                    alarmEventInts[i] = data[i].alarmEventInt;
                }
                layer.confirm("确定删除所选预警信息？", {
                    icon: 3,
                    title: "系统提示"
                }, function (index) {
                    $.ajax({
                        url: "<%= request.getContextPath() %>/warn/alarmEvent/batchDelete",
                        type: "DELETE",
                        data: JSON.stringify(alarmEventInts),
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
                                    table.reload("LAY-app-alarmEvent-list-reload");
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
            var checkStatus = table.checkStatus("LAY-app-alarmEvent-list-reload");
            var data = checkStatus.data;
            if (data.length == 0) {
                layer.msg("请至少选中一条记录！");
            }
            for (i = 0; i < data.length; i++) {
                debugger;
                if (data[i].enableStatus == "101") {
                    isExits = true;
                    break;
                }
                isExits = false
            }
            if (isExits == false) {
                if (data.length > 0) {
                    var alarmEventInts = new Array();
                    for (var i = 0; i < data.length; i++) {
                        alarmEventInts[i] = data[i].alarmEventInt;
                    }
                    layer.confirm("确定启用所选预警信息？", {
                        icon: 3,
                        title: "系统提示"
                    }, function (index) {
                        $.ajax({
                            url: "<%= request.getContextPath() %>/warn/alarmEvent/enable",
                            type: "POSt",
                            data: JSON.stringify(alarmEventInts),
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
                                        table.reload("LAY-app-alarmEvent-list-reload");
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
            } else if(isExits == true){
                layer.msg("当前选择事件存在已启用");
            }else {
                layer.msg("启用失败");
            }
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
        url: "<%= request.getContextPath() %>/warn/alarmEvent/query",
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
            field: "alarmEventId",
            title: "预警事件编码",
            align: "center",
            minWidth: 120,
            hide: isHidden("alarmEventId"),
            //打开监听
            event: "view",
            //监听打开详情页面
            templet: function (data) {
                return '<span style="color: #09bbfd">' + data.alarmEventId + '</span>';
            }
        }, {
            field: "alarmEventTitle",
            title: "预警事件标题",
            align: "center",
            minWidth: 120,
            hide: isHidden("alarmEventTitle")
        }, {
            field: "enableStatus",
            title: "启用",
            align: "center",
            minWidth: 120,
            hide: isHidden("enableStatus"),
            templet: function (d) {
                return layui.admin.getDictText("IS_USE", d.enableStatus);
            }
        }, {
            field: "alarmLevel",
            title: "预警级别",
            align: "center",
            minWidth: 100,
            hide: isHidden("alarmLevel"),
            templet: function (d) {
                return layui.admin.getDictText("WARNING_LEVEL", d.alarmLevel);
            }
        }, {
            field: "alarmType",
            title: "预警类型",
            align: "center",
            minWidth: 150,
            hide: isHidden("alarmType"),
            templet: function (d) {
                return layui.admin.getDictText("WRANING_TYPE", d.alarmType);
            }
        }, {
            field: "alarmEventContent",
            title: "内容",
            align: "center",
            minWidth: 150,
            hide: isHidden("alarmEventContent")
        }, {
            field: "upperLimit",
            title: "上限",
            align: "center",
            minWidth: 120,
            hide: isHidden("upperLimit")
        }, {
            field: "lowerLimit",
            title: "下限",
            align: "center",
            minWidth: 100,
            hide: isHidden("lowerLimit")
        }, {
            field: "makeFormPeople",
            title: "制单人",
            align: "center",
            minWidth: 120,
            hide: isHidden("makeFormPeople")
        }, {
            field: "makeFormTime",
            title: "制单时间",
            align: "center",
            minWidth: 100,
            hide: isHidden("makeFormTime"),
            templet: function (d) {
                return layui.util.toDateString(d.makeFormTime);
            }
        }, {
            field: "updatePeople",
            title: "修改人",
            align: "center",
            minWidth: 120,
            hide: isHidden("updatePeople")
        }, {
            field: "updateTime",
            title: "修改时间",
            align: "center",
            minWidth: 100,
            hide: isHidden("updateTime"),
            templet: function (d) {
                return layui.util.toDateString(d.updateTime);
            }
        }, {
            title: "操作",
            align: "center",
            fixed: "right",
            width: 200,
            toolbar: "#table-alarmEvent-list"
        }]]
    });

    //监听操作事件
    table.on("tool(LAY-app-alarmEvent-list)", function (e) {
        var data = e.data;
        if (e.event == "edit") {
            top.layer.open({
                type: 2,
                title: "编辑设备信息",
                content: "<%= request.getContextPath() %>/warn/alarmEvent/alarm_event_edit.jsp",
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
                    url: "<%= request.getContextPath() %>/warn/alarmEvent/delete/" + data.alarmEventInt,
                    type: "DElETE",
                    data: JSON.stringify({
                        alarmEvent: data
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
                                table.reload("LAY-app-alarmEvent-list-reload");
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
                title: "查看预警事件详情",
                content: "<%= request.getContextPath() %>/warn/alarmEvent/alarm_event_view.jsp",
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