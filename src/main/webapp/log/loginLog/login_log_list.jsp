<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 林俊杰
  - Date: 2023-1-13 09:38:16
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>登录日志</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v1">
</head>
<body>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item layui-col-space12">
                <div class="layui-inline">
                    <label class="layui-form-label">设备资源号：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="equipmentId" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">来源：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="source" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">登录用户：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="loginUserName" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">登录时间：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="loginTime" id="loginTime" lay-filter="loginTime" placeholder=""
                               autocomplete="off"
                               class="layui-input">
                    </div>
                    
                    <div class="layui-inline layui-search" style="padding-left: 50px">
                        <button class="layui-btn layuiadmin-btn-list" lay-submit
                                lay-filter="LAY-app-loginLoglist-search"
                                id="LAY-app-loginLoglist-search">
                            <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                        </button>
                    </div>
                </div>

            </div>


        </div>
        <div class="layui-card-body">
            <%--        <div class="layui-toolbar" id="toolbar" hidden="true">--%>
            <%--            <button class="layui-btn layuiadmin-btn-list layui-btn-sm" lay-event="add"><i--%>
            <%--                    class="layui-icon layui-icon-add-circle-fine"></i>新增规则--%>
            <%--            </button>--%>
            <%--            <button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="batchdel"><i--%>
            <%--                    class="layui-icon layui-icon-delete"></i>删除--%>
            <%--            </button>--%>
            <%--        </div>--%>


            <table id="LAY-app-loginLog-list" lay-filter="LAY-app-loginLog-list"></table>

            <%--        <script type="text/html" id="table-loginLog-list">--%>
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
        elem: '#loginTime',
        type: 'date'
    });


    //监听搜索
    form.on("submit(LAY-app-loginLoglist-search)", function (data) {
        var field = data.field;
        table.reload("LAY-app-loginLog-list-reload", {
            where: field
        });
    });

    // //登录时间监听事件
    // form.on("input(loginTime)", function(data) {
    //     var submit = $("#LAY-app-loginLoglist-search");
    //     submit.click();
    // });


    //文本框回车事件
    $(".layui-input").on("keydown", function (event) {
        if (event.keyCode == 13) {
            var submit = $("#LAY-app-loginLoglist-search");
            submit.click();
            return false;
        }
    });


    table.on('sort(LAY-app-loginLog-list)', function (obj) {
        table.reload('LAY-app-loginLog-list-reload', {
            initSort: obj,
            where: {
                sortField: obj.field,
                sortOrder: obj.type
            }
        });
    });

    //左侧表头按钮事件监听
    table.on("toolbar(LAY-app-loginLog-list)", function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    //表格排序
    table.on("sort(LAY-app-loginLog-list)", function (obj) {
        table.reload("LAY-app-loginLog-list-reload", {
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
        table.reload("LAY-app-loginLog-list-reload", {
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
        elem: "#LAY-app-loginLog-list",
        id: "LAY-app-loginLog-list-reload",
        url: "<%= request.getContextPath() %>/log/loginLog/query",
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
            field: "equipmentId",
            title: "设备资源号",
            align: "center",
            minWidth: 120,
            hide: isHidden("equipmentId")
        }, {
            field: "aPPId",
            title: "APPID",
            align: "center",
            minWidth: 200,
            hide: isHidden("aPPId")
        }, {
            field: "source",
            title: "来源",
            align: "center",
            minWidth: 150,
            hide: isHidden("source")
        }, {
            field: "loginUserName",
            title: "登录用户",
            align: "center",
            minWidth: 120,
            hide: isHidden("loginUserName")
        }, {
            field: "loginTime",
            title: "登陆时间",
            align: "center",
            minWidth: 150,
            hide: isHidden("loginTime"),
            templet: function (d) {
                return layui.util.toDateString(d.loginTime);
            }
        }, {
            field: "remarks",
            title: "备注",
            align: "center",
            minWidth: 120,
            hide: isHidden("remarks")
        }]]
    });

    //监听操作事件
    <%--table.on("tool(LAY-app-loginLog-list)", function (e) {--%>
    <%--    var data = e.data;--%>
    <%--    if (e.event == "edit") {--%>
    <%--        top.layer.open({--%>
    <%--            type: 2,--%>
    <%--            title: "编辑设备信息",--%>
    <%--            content: "<%= request.getContextPath() %>/warn/loginLog/alarm_rule_edit.jsp",--%>
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
    <%--                url: "<%= request.getContextPath() %>/warn/loginLog/delete/" + data.loginLogInt,--%>
    <%--                type: "DElETE",--%>
    <%--                data: JSON.stringify({--%>
    <%--                    loginLog: data--%>
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
    <%--                            table.reload("LAY-app-loginLog-list-reload");--%>
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