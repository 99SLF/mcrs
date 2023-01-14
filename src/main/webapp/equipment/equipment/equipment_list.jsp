<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 林俊杰
  - Date: 2022-12-01 16:08:11
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>设备管理</title>
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
                    <label class="layui-form-label">设备资源号：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="equipmentId" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                    <label class="layui-form-label">设备名称：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="equipmentName" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>

                <div class="layui-inline layui-search">
                    <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-equipmentlist-search"
                            id="LAY-app-equipmentlist-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>

        <div class="layui-card-body">
            <div class="layui-toolbar" id="toolbar" hidden="true">
                <button class="layui-btn layuiadmin-btn-list layui-btn-sm" lay-event="add"><i
                        class="layui-icon layui-icon-add-circle-fine"></i>新建
                </button>
                <button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="batchdel"><i
                        class="layui-icon layui-icon-delete"></i>删除
                </button>
                <button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="import"><i
                        class="layui-icon layui-icon-import"></i>导入
                </button>
            </div>

            <table id="LAY-app-equipment-list" lay-filter="LAY-app-equipment-list"></table>

            <script type="text/html" id="table-equipment-list">
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
    form.on("submit(LAY-app-equipmentlist-search)", function (data) {
        var field = data.field;
        table.reload("LAY-app-equipment-list-reload", {
            where: field
        });
    });


    //获取启用类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#enable",
        dictTypeId: "IS_USE",
    });
    form.render();

    //文本框回车事件
    $(".layui-input").on("keydown", function (event) {
        if (event.keyCode == 13) {
            var submit = $("#LAY-app-equipmentlist-search");
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
                content: "<%= request.getContextPath() %>/equipment/equipment/equipment_add.jsp",
                area: ["1000px", "600px"],
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
        batchdel: function() {
            var checkStatus = table.checkStatus("LAY-app-equipment-list-reload");
            var data = checkStatus.data;
            if (data.length == 0) {
                layer.msg("请至少选中一条记录！");
            }
            if (data.length > 0) {
                var equipmentInts = new Array();
                for (var i=0; i<data.length;i++) {
                    equipmentInts[i] = data[i].equipmentInt;
                }
                layer.confirm("确定删除所选设备信息？", {
                    icon: 3,
                    title: "系统提示"
                }, function(index) {
                    $.ajax({
                        url: "<%= request.getContextPath() %>/equipment/equipment/batchDelete",
                        type: "DELETE",
                        data: JSON.stringify(equipmentInts),
                        cache: false,
                        contentType: "text/json",
                        success: function(result) {
                            if (result.exception) {
                                layer.alert(result.exception.message, {
                                    icon: 2,
                                    title: "系统提示"
                                });
                            } else if (result) {
                                layer.msg("删除成功", {
                                    icon: 1,
                                    time: 2000
                                }, function() {
                                    table.reload("LAY-app-equipment-list-reload");
                                });
                            } else {
                                layer.msg("删除失败");
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
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

    table.on('sort(LAY-app-equipment-list)', function (obj) {
        table.reload('LAY-app-equipment-list-reload', {
            initSort: obj,
            where: {
                sortField: obj.field,
                sortOrder: obj.type
            }
        });
    });

    //左侧表头按钮事件监听
    table.on("toolbar(LAY-app-equipment-list)", function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    //表格排序
    table.on("sort(LAY-app-equipment-list)", function (obj) {
        table.reload("LAY-app-equipment-list-reload", {
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
        table.reload("LAY-app-equipment-list-reload", {
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
        success: function(result) {
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
        elem: "#LAY-app-equipment-list",
        id: "LAY-app-equipment-list-reload",
        url: "<%= request.getContextPath() %>/equipment/equipment/query",
        method: "GET",
        height: "full-" + getFullSize(),
        page: true,
        limit: 10,
        limits: [10, 15, 20, 30],
        toolbar: "#toolbar",
        defaultToolbar: ["filter"],
        colHideChange: function(col, checked) {
            var field = col.field;
            var hidden = col.hide;
            $.ajax({
                url: "<%=request.getContextPath() %>/cols/filter/set?funName=" + funName + "&field=" + field + "&hidden=" + hidden,
                type: "GET",
                cache: false,
                contentType: "text/json",
                success: function(result) {
                    if (result) {
                    } else{
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
            hide: isHidden("equipmentId"),
            //打开监听
            event: "view",
            //监听打开详情页面
            templet: function (data) {
                return '<span style="color: #09bbfd">' + data.equipmentId +'</span>';
            }
        }, {
            field: "equipmentName",
            title: "设备名称",
            align: "center",
            minWidth: 120,
            hide: isHidden("equipmentName")
        }, {
            field: "enable",
            title: "启用",
            align: "center",
            minWidth: 100,
            hide: isHidden("enable"),
            templet:function(d) {
                return layui.admin.getDictText("IS_USE", d.enable);
            }
        },{
            field: "equipmentInstallLocation",
            title: "设备安装位置",
            align: "center",
            minWidth: 120,
            hide: isHidden("equipmentInstallLocation")
        }, {
            field: "equipTypeName",
            title: "设备类型",
            align: "center",
            minWidth: 100,
            hide: isHidden("equipTypeName"),
            templet:function(d) {
                return layui.admin.getDictText("EQUIPMENT_PROPERTY", d.equipTypeName);
            }
        }, {
            field: "mesIpAddress",
            title: "MES连接IP",
            align: "center",
            minWidth: 150,
            hide: isHidden("mesIpAddress")
        }, {
            field: "protocolCommunication",
            title: "支持通信协议",
            align: "center",
            minWidth: 150,
            hide: isHidden("protocolCommunication")
        }, {
            field: "equipmentIp",
            title: "设备连接IP",
            align: "center",
            minWidth: 120,
            hide: isHidden("equipmentIp")
        }, {
            field: "equipmentContinuePort",
            title: "设备连接端口",
            align: "center",
            minWidth: 150,
            hide: isHidden("equipmentContinuePort")
        }, {
            field: "accPointResName",
            title: "接入点名称",
            align: "center",
            minWidth: 120,
            hide: isHidden("accPointResName")
        }, {
            field: "matrixCode",
            title: "基地代码",
            align: "center",
            minWidth: 100,
            hide: true
        }, {
            field: "factoryCode",
            title: "工厂代码",
            align: "center",
            minWidth: 120,
            hide: true
        }, {
            field: "processName",
            title: "使用工序",
            align: "center",
            minWidth: 100,
            hide: true
        }, {
            field: "creator",
            title: "创建人",
            align: "center",
            minWidth: 100,
            hide: true
        },{
            field: "createTime",
            title: "创建时间",
            align: "center",
            minWidth: 200,
            hide: true,
            templet:function(d) {
                return layui.util.toDateString(d.createTime,'yyyy-MM-dd HH:mm:ss');
            }
        },{
            title: "操作",
            align: "center",
            fixed: "right",
            width: 200,
            toolbar: "#table-equipment-list"
        }]]
    });

    //监听操作事件
    table.on("tool(LAY-app-equipment-list)", function (e) {
        var data = e.data;
        if (e.event == "edit") {
            top.layer.open({
                type: 2,
                title: "编辑设备信息",
                content: "<%= request.getContextPath() %>/equipment/equipment/equipment_edit.jsp",
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
                    url: "<%= request.getContextPath() %>/equipment/equipment/delete/"+data.equipmentInt,
                    type: "DElETE",
                    data: JSON.stringify({
                        equipment: data
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
                                table.reload("LAY-app-equipment-list-reload");
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
        else if (e.event == "view") {
            top.layer.open({
                type: 2,
                title: "查看设备详情",
                content: "<%= request.getContextPath() %>/equipment/equipment/equipment_view.jsp",
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