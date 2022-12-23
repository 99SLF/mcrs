<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 李伟杰
  - Date: 2022-12-21 16:11:58
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>设备类型信息维护</title>
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
                    <label class="layui-form-label">设备类型代码：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="equipTypeCode" placeholder="设备类型代码" autocomplete="off"
                               class="layui-input">
                    </div>
                    <label class="layui-form-label">设备类型名称：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="equipTypeName" placeholder="设备类型名称" autocomplete="off"
                               class="layui-input">
                    </div>
                    <label class="layui-form-label">制单人：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="creator" placeholder="请输入" autocomplete="off"
                               class="layui-input">
                    </div>
                    <label class="layui-form-label">制单时间：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="createTime" placeholder="选择时间" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>

                <div class="layui-inline layui-search">
                    <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-devicelist-search"
                            id="LAY-app-devicelist-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>

        <div class="layui-card-body">
            <div class="layui-toolbar" id="toolbar" hidden="true">
                <button class="layui-btn layuiadmin-btn-list layui-btn-sm" lay-event="add"><i
                        class="layui-icon layui-icon-add-circle-fine"></i>新增设备类型
                </button>
                <button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="batchdel"><i
                        class="layui-icon layui-icon-refresh" readonly></i>启用
                </button>
            </div>

            <table id="LAY-app-device-list" lay-filter="LAY-app-device-list"></table>

            <script type="text/html" id="table-device-list">
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
    //全加载：日期
    var laydate = layui.laydate;

    //全局参数
    var req_data;

    //功能名
    var funName = "list";

    var hiddenFields = [];

    //监听搜索
    form.on("submit(LAY-app-devicelist-search)", function (data) {
        var field = data.field;
        table.reload("LAY-app-device-list-reload", {
            where: field
        });
    });


    //文本框回车事件
    $(".layui-input").on("keydown", function (event) {
        if (event.keyCode == 13) {
            var submit = $("#LAY-app-devicelist-search");
            submit.click();
            return false;
        }
    });

    var active = {
        //设备新建
        add: function () {
            top.layer.open({
                type: 2,
                title: "新增设备类型",
                content: "<%= request.getContextPath() %>/basic/equipType/equipType_add.jsp",
                area: ["1000px", "800px"],
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
        <%--//批量删除--%>
        <%--batchdel: function () {--%>
        <%--    var checkStatus = table.checkStatus("LAY-app-device-list-reload");--%>
        <%--    var data = checkStatus.data;--%>
        <%--    if (data.length == 0) {--%>
        <%--        layer.msg("请至少选中一条记录！");--%>
        <%--    }--%>
        <%--    if (data.length > 0) {--%>
        <%--        var deviceIds = new Array();--%>
        <%--        for (var i = 0; i < data.length; i++) {--%>
        <%--            deviceIds[i] = data[i].deviceId;--%>
        <%--        }--%>
        <%--        layer.confirm("确定删除所选终端信息？", {--%>
        <%--            icon: 3,--%>
        <%--            title: "系统提示"--%>
        <%--        }, function (index) {--%>
        <%--            $.ajax({--%>
        <%--                url: "<%= request.getContextPath() %>/equipment/device/batchDelete",--%>
        <%--                type: "DELETE",--%>
        <%--                data: JSON.stringify(deviceIds),--%>
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
        <%--                            time: 2000--%>
        <%--                        }, function () {--%>
        <%--                            table.reload("LAY-app-device-list-reload");--%>
        <%--                        });--%>
        <%--                    } else {--%>
        <%--                        layer.msg("删除失败");--%>
        <%--                    }--%>

        <%--                },--%>
        <%--                error: function (jqXHR, textStatus, errorThrown) {--%>
        <%--                    layer.msg(jqXHR.responseText, {--%>
        <%--                        time: 2000,--%>
        <%--                        icon: 5--%>
        <%--                    });--%>
        <%--                }--%>
        <%--            });--%>
        <%--        });--%>
        <%--    }--%>
        <%--},--%>
    };

    table.on('sort(LAY-app-device-list)', function (obj) {
        table.reload('LAY-app-device-list-reload', {
            initSort: obj,
            where: {
                sortField: obj.field,
                sortOrder: obj.type
            }
        });
    });

    //左侧表头按钮事件监听
    table.on("toolbar(LAY-app-device-list)", function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    //表格排序
    table.on("sort(LAY-app-device-list)", function (obj) {
        table.reload("LAY-app-device-list-reload", {
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
        table.reload("LAY-app-device-list-reload", {
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

    // 查询
    table.render({
        elem: "#LAY-app-device-list",
        id: "LAY-app-device-list-reload",
        url: "<%= request.getContextPath() %>/EquipController/query",
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
            field: "equipTypeCode",
            title: '设备类型代码',
            align: "center",
            minWidth: 120,
            //打开监听
            event: "view",
            hide: isHidden("equipTypeCode"),
            //监听打开详情页面
            templet: function (d) {
                return '<span style="color: #09bbfd">' + d.equipTypeCode +'</span>';
            }
        }, {
            field: "equipTypeName",
            title: "设备类型名称",
            align: "center",
            minWidth: 120,
            hide: isHidden("equipTypeName")
        }, {
            field: "equipTypeEnable",
            title: "是否启用",
            align: "center",
            minWidth: 90,
            hide: isHidden("equipTypeEnable")
        }, {
            field: "manufacturer",
            title: "厂家",
            align: "center",
            minWidth: 100,
            hide: isHidden("manufacturer")
        }, {
            field: "equipControllerModel",
            title: "使用控制器型号",
            align: "center",
            minWidth: 150,
            hide: isHidden("equipControllerModel")
        }, {
            field: "protocolCommunication",
            title: "支持通信协议",
            align: "center",
            minWidth: 120,
            hide: isHidden("protocolCommunication")
        }, {
            field: "manufacturer",
            title: "工厂名称",
            align: "center",
            minWidth: 100,
            hide: isHidden("manufacturer")
        }, {
            field: "mesIpAddress",
            title: "MES连接IP地址",
            align: "center",
            minWidth: 140,
            hide: isHidden("mesIpAddress")
        }, {
            field: "remarks",
            title: "备注",
            align: "center",
            minWidth: 120,
            hide: isHidden("remarks")
        }, {
            field: "creator",
            title: "制单人",
            align: "center",
            minWidth: 120,
            hide: isHidden("creator")
        }, {
            field: "createTime",
            title: "制单时间",
            align: "center",
            minWidth: 100,
            hide: isHidden("createTime"),
            templet:function (data) {
                return layui.util.toDateString(data.createTime, "yyyy-MM-dd HH:mm:ss");
            }
        }, {
            field: "updater",
            title: "修改人",
            align: "center",
            minWidth: 120,
            hide: isHidden("updater")
        }, {
            field: "updateTime",
            title: "修改时间",
            align: "center",
            minWidth: 100,
            hide: isHidden("updateTime")
            // templet:function (data) {
            //     if (data.updateTime !==null || data.updateTime !=="") {
            //         return layui.util.toDateString(data.updateTime, "yyyy-MM-dd HH:mm:ss");
            //     }
            // }

        }, {
            title: "操作",
            align: "center",
            fixed: "right",
            width: 200,
            toolbar: "#table-device-list"
        }]]
    });


    //监听操作事件
    table.on("tool(LAY-app-device-list)", function (e) {
        var data = e.data;
        if (e.event == "edit") {
            top.layer.open({
                type: 2,
                title: "编辑设备类型信息维护",
                content: "<%= request.getContextPath() %>/basic/equipType/equipType_edit.jsp",
                area: ["1000px", "800px"],
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
            layer.confirm("确定删除该设备信息？", {
                icon: 3,
                title: "系统提示"
            }, function (index) {
                var equipTypeIds =new Array();
                equipTypeIds[0] = data.equipTypeId;
                $.ajax({
                    url: "<%= request.getContextPath() %>/EquipController/batchDelete",
                    type: "DElETE",
                    data: JSON.stringify(equipTypeIds),
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
                                table.reload("LAY-app-device-list-reload");
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
        }else if (e.event == "view") {
            top.layer.open({
                type: 2,
                title: "编辑设备类型信息维护",
                content: "<%= request.getContextPath() %>/basic/equipType/equipType_detailed.jsp",
                area: ["1000px", "800px"],
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