<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 林俊杰
  - Date: 2023-1-13 16:41:04
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>MES交换日志</title>
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
        <div class="layui-form layuiadmin-card-header-auto" lay-filter="layuiadmin-mesLog-form"
             id="layuiadmin-mesLog-form">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">设备名称：</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="equipmentName" autocomplete="off"/>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">终端名称：</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="deviceName" autocomplete="off"/>
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">MES连接IP：</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="mesIpAddress" autocomplete="off"/>
                    </div>
                </div>
                <div class="layui-inline layui-hide">
                    <button id="LAY-app-mesLog-search" class="layui-btn layuiadmin-btn-list" lay-submit
                            lay-filter="LAY-app-mesLog-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
    </script>
    <div class="layui-card-body">
        <table id="LAY-app-mesLog-list" lay-filter="LAY-app-mesLog-list"></table>
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

    //功能名
    var funName = "mes_log_list";
    // 高级查询参数
    var advancedFormData = {};
    // 焦点名称
    var focusName = null;


    var hiddenFields = [];

    var laydate = layui.laydate;


    // 监听搜索
    form.on("submit(LAY-app-mesLog-search)", function(data) {
        var field = data.field;
        reloadData(field);
        var formData = {
            equipmentName: field.equipmentName,
            deviceName: field.deviceName,
            mesIpAddress: field.mesIpAddress
        };
        form.val("layuiadmin-mesLog-form", formData);
        advancedFormData = $.extend(advancedFormData, formData);
    });


    function reloadData(formData) {
        //读取表格数据 表格id
        table.reload("LAY-app-mesLog-list-reload", {
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
        form.val("layuiadmin-mesLog-form", {
            equipmentName: data.equipmentName,
            deviceName: data.deviceName,
            mesIpAddress: data.mesIpAddress
        });
    }

    table.on('sort(LAY-app-mesLog-list)', function (obj) {
        table.reload('LAY-app-mesLog-list-reload', {
            initSort: obj,
            where: {
                sortField: obj.field,
                sortOrder: obj.type
            }
        });
    });

    //左侧表头按钮事件监听
    table.on("toolbar(LAY-app-mesLog-list)", function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    //表格排序
    table.on("sort(LAY-app-mesLog-list)", function (obj) {
        table.reload("LAY-app-mesLog-list-reload", {
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
        table.reload("LAY-app-mesLog-list-reload", {
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
            var submit = $("#LAY-app-mesLog-search");
            submit.click();
            return false;
        },
        query: function() {
            var url = "<%=request.getContextPath() %>/log/mesLog/mesLog_form_query.jsp";
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
                    var submit = layero.find("iframe").contents().find("#LAY-app-mesLog-search-advanced");
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
        elem: "#LAY-app-mesLog-list",
        id: "LAY-app-mesLog-list-reload",
        url: "<%= request.getContextPath() %>/log/mesLog/query",
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
            field: "logStatus",
            title: "日志状态",
            align: "center",
            minWidth: 100,
            hide: isHidden("logStatus"),
            templet: function (d) {
                return layui.admin.getDictText("LOG_STATUS", d.logStatus);
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
            minWidth: 250,
            hide: isHidden("aPPId")
        }, {
            field: "deviceName",
            title: "终端名称",
            align: "center",
            minWidth: 150,
            hide: isHidden("deviceName")
        }, {
            field: "mesIpAddress",
            title: "MES连接IP地址",
            align: "center",
            minWidth: 150,
            hide: isHidden("mesIpAddress")
        }, {
            field: "equipmentContinuePort",
            title: "设备连接端口",
            align: "center",
            minWidth: 120,
            hide: isHidden("equipmentContinuePort")
        }, {
            field: "mesContent",
            title: "交互内容",
            align: "left",
            minWidth: 120,
            hide: isHidden("mesContent")
        }, {
            field: "createName",
            title: "创建人",
            align: "center",
            minWidth: 120,
            hide: isHidden("createName")
        }, {
            field: "createTime",
            title: "创建时间",
            align: "center",
            minWidth: 200,
            hide: isHidden("createTime"),
            templet: function (d) {
                if (d.createTime != null) {
                    return layui.util.toDateString(d.createTime);
                } else {
                    return '';
                }
            }
        }]]
    });

    formReder();

    function formReder() {
        // 文本框回车事件
        $(".layui-input").on("keydown", function (event) {
            if (event.keyCode == 13) {
                focusName = event.target.name;
                var submit = $("#LAY-app-mesLog-search");
                submit.click();
                return false;
            }
        });
    }

    //监听操作事件
    <%--table.on("tool(LAY-app-mesLog-list)", function (e) {--%>
    <%--    var data = e.data;--%>
    <%--    if (e.event == "edit") {--%>
    <%--        top.layer.open({--%>
    <%--            type: 2,--%>
    <%--            title: "编辑设备信息",--%>
    <%--            content: "<%= request.getContextPath() %>/warn/mesLog/alarm_rule_edit.jsp",--%>
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
    <%--                url: "<%= request.getContextPath() %>/warn/mesLog/delete/" + data.mesLogInt,--%>
    <%--                type: "DElETE",--%>
    <%--                data: JSON.stringify({--%>
    <%--                    mesLog: data--%>
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
    <%--                            table.reload("LAY-app-mesLog-list-reload");--%>
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