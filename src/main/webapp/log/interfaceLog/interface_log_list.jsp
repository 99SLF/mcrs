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
</head>
<body>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">来源：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="source" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">接口类型：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="interfaceType" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">设备接入IP：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="equipmentIp" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">调用者：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="invokerName" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">接口名称：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="interfaceName" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">创建时间：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="createTime" id="createTime" placeholder=""
                               autocomplete="off"
                               class="layui-input">
                    </div>
                    <div class="layui-inline layui-search" style="padding-left: 50px">
                        <button class="layui-btn layuiadmin-btn-list" lay-submit
                                lay-filter="LAY-app-interfaceLoglist-search"
                                id="LAY-app-interfaceLoglist-search">
                            <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-card-body">

            <%--                    <div class="layui-toolbar" id="toolbar" hidden="true">--%>
            <%--                        <button class="layui-btn layuiadmin-btn-list layui-btn-sm" lay-event="add"><i--%>
            <%--                                class="layui-icon layui-icon-add-circle-fine"></i>新增规则--%>
            <%--                        </button>--%>
            <%--                        <button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="batchdel"><i--%>
            <%--                                class="layui-icon layui-icon-delete"></i>删除--%>
            <%--                        </button>--%>
            <%--                    </div>--%>

            <table id="LAY-app-interfaceLog-list" lay-filter="LAY-app-interfaceLog-list"></table>

            <%--        <script type="text/html" id="table-interfaceLog-list">--%>
            <%--            <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i--%>
            <%--                    class="layui-icon layui-icon-edit"></i>编辑</a>--%>
            <%--            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i--%>
            <%--                    class="layui-icon layui-icon-delete"></i>删除</a>--%>
            <%--        </script>--%>
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

    var laydate = layui.laydate;
    //日期时间选择器
    laydate.render({
        elem: '#createTime',
        type: 'date'
    });


    //监听搜索
    form.on("submit(LAY-app-interfaceLoglist-search)", function (data) {
        var field = data.field;
        table.reload("LAY-app-interfaceLog-list-reload", {
            where: field
        });
    });


    //文本框回车事件
    $(".layui-input").on("keydown", function (event) {
        if (event.keyCode == 13) {
            var submit = $("#LAY-app-interfaceLoglist-search");
            submit.click();
            return false;
        }
    });

    <%--var active = {--%>
    <%--    //设备新建--%>
    <%--    add: function () {--%>
    <%--        top.layer.open({--%>
    <%--            type: 2,--%>
    <%--            title: "预警规则新建",--%>
    <%--            content: "<%= request.getContextPath() %>/warn/interfaceLog/alarm_rule_add.jsp",--%>
    <%--            area: ["1000px", "560px"],--%>
    <%--            resize: false,--%>
    <%--            btn: ["确定", "取消"],--%>
    <%--            success: function (layero, index) {--%>
    <%--                var dataJson = {--%>
    <%--                    win: window,--%>
    <%--                };--%>
    <%--                layero.find("iframe")[0].contentWindow.SetData(dataJson);--%>
    <%--            },--%>
    <%--            yes: function (index, layero) {--%>
    <%--                var submit = layero.find("iframe").contents().find("#layuiadmin-app-form-submit");--%>
    <%--                submit.click();--%>
    <%--            }--%>
    <%--        });--%>
    <%--    },--%>
    <%--    //批量删除--%>
    <%--    batchdel: function () {--%>
    <%--        var checkStatus = table.checkStatus("LAY-app-interfaceLog-list-reload");--%>
    <%--        var data = checkStatus.data;--%>
    <%--        if (data.length == 0) {--%>
    <%--            layer.msg("请至少选中一条记录！");--%>
    <%--        }--%>
    <%--        if (data.length > 0) {--%>
    <%--            var interfaceLogInts = new Array();--%>
    <%--            for (var i = 0; i < data.length; i++) {--%>
    <%--                interfaceLogInts[i] = data[i].interfaceLogInt;--%>
    <%--            }--%>
    <%--            layer.confirm("确定删除所选预警规则？", {--%>
    <%--                icon: 3,--%>
    <%--                title: "系统提示"--%>
    <%--            }, function (index) {--%>
    <%--                $.ajax({--%>
    <%--                    url: "<%= request.getContextPath() %>/warn/interfaceLog/batchDelete",--%>
    <%--                    type: "DELETE",--%>
    <%--                    data: JSON.stringify(interfaceLogInts),--%>
    <%--                    cache: false,--%>
    <%--                    contentType: "text/json",--%>
    <%--                    success: function (result) {--%>
    <%--                        if (result.exception) {--%>
    <%--                            layer.alert(result.exception.message, {--%>
    <%--                                icon: 2,--%>
    <%--                                title: "系统提示"--%>
    <%--                            });--%>
    <%--                        } else if (result) {--%>
    <%--                            layer.msg("删除成功", {--%>
    <%--                                icon: 1,--%>
    <%--                                time: 2000--%>
    <%--                            }, function () {--%>
    <%--                                table.reload("LAY-app-interfaceLog-list-reload");--%>
    <%--                            });--%>
    <%--                        } else {--%>
    <%--                            layer.msg("删除失败");--%>
    <%--                        }--%>
    <%--                    },--%>
    <%--                    error: function (jqXHR, textStatus, errorThrown) {--%>
    <%--                        layer.msg(jqXHR.responseText, {--%>
    <%--                            time: 2000,--%>
    <%--                            icon: 5--%>
    <%--                        });--%>
    <%--                    }--%>
    <%--                });--%>
    <%--            });--%>
    <%--        }--%>
    <%--    }--%>
    <%--};--%>

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
            field: "interfaceLogNum",
            title: "日志编号",
            align: "center",
            minWidth: 120,
            hide: isHidden("interfaceLogNum")
        }, {
            field: "logType",
            title: "日志类型",
            align: "center",
            minWidth: 120,
            hide: isHidden("logType"),
            templet: function (d) {
                return layui.admin.getDictText("LOG_TYPE", d.logType);
            }
        }, {
            field: "source",
            title: "来源",
            align: "center",
            minWidth: 120,
            hide: isHidden("source")
        }, {
            field: "equipmentId",
            title: "设备资源号",
            align: "center",
            minWidth: 100,
            hide: isHidden("equipmentId")
        }, {
            field: "aPPId",
            title: "APPID",
            align: "center",
            minWidth: 150,
            hide: isHidden("aPPId")
        }, {
            field: "interfaceType",
            title: "接口类型",
            align: "center",
            minWidth: 150,
            hide: isHidden("interfaceType")
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
            field: "jSONPage",
            title: "JSON包",
            align: "center",
            minWidth: 120,
            hide: isHidden("jSONPage")
        }, {
            field: "disposeResult",
            title: "处理结果",
            align: "center",
            minWidth: 100,
            hide: isHidden("disposeResult")
        }, {
            field: "startTime",
            title: "处理开始时间",
            align: "center",
            minWidth: 200,
            hide: isHidden("startTime"),
            templet:function(d) {
                return layui.util.toDateString(d.startTime);
            }
        }, {
            field: "endTime",
            title: "处理结束时间",
            align: "center",
            minWidth: 200,
            hide: isHidden("endTime"),
            templet: function (d) {
                return layui.util.toDateString(d.endTime);
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
            minWidth: 120,
            hide: isHidden("disposeTime")
        }, {
            field: "interfaceName",
            title: "接口名称",
            align: "center",
            minWidth: 120,
            hide: isHidden("interfaceName")
        }]]
    });

    //监听操作事件
    <%--table.on("tool(LAY-app-interfaceLog-list)", function (e) {--%>
    <%--    var data = e.data;--%>
    <%--    if (e.event == "edit") {--%>
    <%--        top.layer.open({--%>
    <%--            type: 2,--%>
    <%--            title: "编辑设备信息",--%>
    <%--            content: "<%= request.getContextPath() %>/warn/interfaceLog/alarm_rule_edit.jsp",--%>
    <%--            area: ["1000px", "560px"],--%>
    <%--            resize: false,--%>
    <%--            btn: ["确定", "取消"],--%>
    <%--            success: function (layero, index) {--%>
    <%--                var dataJson = {--%>
    <%--                    data: data,--%>
    <%--                    win: window--%>
    <%--                };--%>
    <%--                layero.find("iframe")[0].contentWindow.SetData(dataJson);--%>
    <%--            },--%>
    <%--            yes: function (index, layero) {--%>
    <%--                var edit = layero.find("iframe").contents().find("#layuiadmin-app-form-edit");--%>
    <%--                edit.click();--%>
    <%--            }--%>

    <%--        });--%>
    <%--    } else if (e.event == "del") {--%>
    <%--        layer.confirm("确定删除该设备？", {--%>
    <%--            icon: 3,--%>
    <%--            title: "系统提示"--%>
    <%--        }, function (index) {--%>
    <%--            $.ajax({--%>
    <%--                url: "<%= request.getContextPath() %>/warn/interfaceLog/delete/" + data.interfaceLogInt,--%>
    <%--                type: "DElETE",--%>
    <%--                data: JSON.stringify({--%>
    <%--                    interfaceLog: data--%>
    <%--                }),--%>
    <%--                cache: false,--%>
    <%--                contentType: "text/json",--%>
    <%--                success: function (result) {--%>
    <%--                    if (result.exception) {--%>
    <%--                        layer.alert(result.exception.message, {--%>
    <%--                            icon: 2,--%>
    <%--                            title: "系统提示"--%>
    <%--                        });--%>
    <%--                    } else if (result) {--%>
    <%--                        layer.msg("删除成功", {--%>
    <%--                            icon: 1,--%>
    <%--                            time: 500--%>
    <%--                        }, function () {--%>
    <%--                            table.reload("LAY-app-interfaceLog-list-reload");--%>
    <%--                        });--%>
    <%--                    } else {--%>
    <%--                        layer.msg("删除失败！", {--%>
    <%--                            icon: 2,--%>
    <%--                            time: 2000--%>
    <%--                        });--%>
    <%--                    }--%>
    <%--                },--%>
    <%--                error: function (jqXHR, textStatus, errorThrown) {--%>
    <%--                    layer.msg(jqXHR.responseText, {--%>
    <%--                        time: 500,--%>
    <%--                        icon: 5--%>
    <%--                    });--%>
    <%--                }--%>
    <%--            });--%>
    <%--        });--%>
    <%--    }--%>
    <%--});--%>

    // //批量选中
    // $("body").on("click", ".layui-table-body table.layui-table tbody tr td", function () {
    //     if ($(this).attr("data-field") === "0") return;
    //     $(this).siblings().eq(0).find("i").click();
    // });
</script>
</body>
</html>