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
        <div class="layui-form layuiadmin-card-header-auto" lay-filter="layuiadmin-equipmentType-form"
             id="layuiadmin-equipmentType-form">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">设备类型代码：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="equipTypeCode" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">设备类型名称：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="equipTypeName" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline layui-hide">
                    <button id="LAY-app-equipmentType-list-search"
                            class="layui-btn layuiadmin-btn-list"
                            lay-submit lay-filter="LAY-app-equipmentType-list-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
    </script>
    <div class="layui-card-body">
        <table id="LAY-app-equipmentType-list" lay-filter="LAY-app-equipmentType-list"></table>
        <script type="text/html" id="table-equipmentType-list">
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
    var admin = layui.admin;
    var view = layui.view;

    //全局参数
    var req_data;

    //功能名
    var funName = "list";

    var hiddenFields = [];

    //全加载：日期
    var laydate = layui.laydate;
    var isExits = false;

    // 焦点名称
    var focusName = null;

    // 高级查询参数
    var advancedFormData = {};

    //监听搜索
    form.on("submit(LAY-app-equipmentType-list-search)", function (data) {


        var field = data.field;
        reloadData(field);
        var formData = {
            equipTypeCode: field.equipTypeCode,
            equipTypeName: field.equipTypeName
        };

        //设置整个表单数据 layuiadmin-update_package-form
        form.val("layuiadmin-equipmentType-form", formData);
        advancedFormData = $.extend(advancedFormData, formData);


        // table.reload("LAY-app-device-list-reload", {
        //     where: field
        // });
    });

    function reloadData(formData) {

        //读取表格数据 表格id LAY-app-update_package-list-reload
        table.reload("LAY-app-equipmentType-list-reload", {
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
        //将设置整个表单的数据
        form.val("layuiadmin-equipmentType-form", {
            equipTypeCode: data.equipTypeCode,
            equipTypeName: data.equipTypeName
        });
    }


    var active = {
        search: function () {
            //点击搜索
            var submit = $("#LAY-app-equipmentType-list-search");
            submit.click();
            return false;
        },
        //高级搜索
        query: function () {
            var url = "<%=request.getContextPath() %>/basic/equipType/equipType_list_form_query.jsp";
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
                    var submit = layero.find("iframe").contents().find("#LAY-app-equipmentType-search-advanced");
                    submit.click();
                    top.layer.close(index);
                },
                btn2: function (index, layero) {
                    layero.find("iframe")[0].contentWindow.reset();
                }
            });
        },
        //设备新建
        add: function () {
            top.layer.open({
                type: 2,
                title: "新增设备类型",
                content: "<%= request.getContextPath() %>/basic/equipType/equipType_add.jsp",
                area: ["800px", "450px"],
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
            var checkStatus = table.checkStatus("LAY-app-equipmentType-list-reload");
            var data = checkStatus.data;
            if (data.length == 0) {
                layer.msg("请至少选中一条记录！");
            }
            if (data.length > 0) {
                var equipTypeIds = new Array();
                for (var i = 0; i < data.length; i++) {
                    equipTypeIds[i] = data[i].equipTypeId;
                }
                layer.confirm("确定删除所选设备信息？", {
                    icon: 3,
                    title: "系统提示"
                }, function (index) {
                    $.ajax({
                        url: "<%= request.getContextPath() %>/EquipController/batchDelete",
                        type: "DELETE",
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
                                    time: 2000
                                }, function () {
                                    table.reload("LAY-app-equipmentType-list-reload");
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
            var checkStatus = table.checkStatus("LAY-app-equipmentType-list-reload");
            var data = checkStatus.data;
            if (data.length == 0) {
                layer.msg("请至少选中一条记录！");
            }
            for (i = 0; i < data.length; i++) {
                debugger;
                if (data[i].equipTypeEnable == "101") {
                    isExits = true;
                    break;
                }
                isExits = false
            }
            if (isExits == false) {
                if (data.length > 0) {
                    var equipTypeIds = new Array();
                    for (var i = 0; i < data.length; i++) {
                        equipTypeIds[i] = data[i].equipTypeId;
                    }
                    layer.confirm("确定启用所选设备类型信息？", {
                        icon: 3,
                        title: "系统提示"
                    }, function (index) {
                        $.ajax({
                            url: "<%= request.getContextPath() %>/EquipController/enable",
                            type: "POSt",
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
                                    layer.msg("启用成功", {
                                        icon: 1,
                                        time: 2000
                                    }, function () {
                                        table.reload("LAY-app-equipmentType-list-reload");
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
                layer.msg("当前包含已启用，无需再启用");
            }else {
                layer.msg("启用失败");
            }
        }
    };

    table.on('sort(LAY-app-equipmentType-list)', function (obj) {
        table.reload('LAY-app-equipmentType-list-reload', {
            initSort: obj,
            where: {
                sortField: obj.field,
                sortOrder: obj.type
            }
        });
    });

    //左侧表头按钮事件监听
    table.on("toolbar(LAY-app-equipmentType-list)", function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    //表格排序
    table.on("sort(LAY-app-equipmentType-list)", function (obj) {
        table.reload("LAY-app-equipmentType-list-reload", {
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
        table.reload("LAY-app-equipmentType-list-reload", {
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
        elem: "#LAY-app-equipmentType-list",
        id: "LAY-app-equipmentType-list-reload",
        url: "<%= request.getContextPath() %>/EquipController/query",
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
            title: "新增设备类型",
            layEvent: "add",
            icon: "layui-icon layui-icon-add-circle",
        }, {
            title: "批量删除",
            layEvent: "batchdel",
            icon: "layui-icon layui-icon-delete ",
        }, {
            title: "启用设备",
            layEvent: "enable",
            icon: "layui-icon layui-icon-ok-circle",
        }, "filter","exports"],
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
            minWidth: 150,
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
            minWidth: 150,
            hide: isHidden("equipTypeName")
        }, {
            field: "equipTypeEnable",
            title: "启用",
            align: "center",
            minWidth: 60,
            hide: isHidden("equipTypeEnable"),
            templet:function(d) {

                return layui.admin.getDictText("IS_USE", d.equipTypeEnable);
            }
        }, {
            field: "manufacturer",
            title: "厂家",
            align: "center",
            minWidth: 150,
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
            minWidth: 150,
            hide: isHidden("protocolCommunication")
        }, {
            field: "mesIpAddress",
            title: "MES连接IP地址",
            align: "center",
            minWidth: 150,
            hide: isHidden("mesIpAddress")
        }, {
            field: "remarks",
            title: "备注",
            align: "center",
            minWidth: 150,
            hide: isHidden("remarks")
        }, {
            field: "equipCreatorName",
            title: "创建人",
            align: "center",
            minWidth: 150,
            hide: isHidden("equipCreatorName")
        }, {
            field: "createTime",
            title: "创建时间",
            align: "center",
            minWidth: 200,
            hide: isHidden("createTime"),
            templet:function (data) {
                return layui.util.toDateString(data.createTime, "yyyy-MM-dd HH:mm:ss");
            }
        }, {
            field: "equipUpdaterName",
            title: "修改人",
            align: "center",
            minWidth: 150,
            hide: isHidden("equipUpdaterName")
        }, {
            field: "updateTime",
            title: "修改时间",
            align: "center",
            minWidth: 200,
            hide: isHidden("updateTime"),
            templet: function (d) {
                if (d.updateTime != null) {
                    return layui.util.toDateString(d.updateTime);
                } else {
                    return '';
                }

            }
            // templet:function (data) {
            //     if (data.updateTime !==null || data.updateTime !=="") {
            //         return layui.util.toDateString(data.updateTime, "yyyy-MM-dd HH:mm:ss");
            //     }
            // }

        }, {
            title: "操作",
            align: "center",
            fixed: "right",
            width: 150,
            toolbar: "#table-equipmentType-list"
        }]]
    });

    formReder();

    function formReder() {
        // 文本框回车事件
        $(".layui-input").on("keydown", function (event) {
            if (event.keyCode == 13) {
                focusName = event.target.name;
                var submit = $("#LAY-app-equipmentType-list-search");
                submit.click();
                return false;
            }
        });

        //软件类型下拉框监听事件
        form.on("select(isEnable)", function (data) {
            var submit = $("#LAY-app-equipmentType-list-search");
            submit.click();
        });
    }


    //监听操作事件
    table.on("tool(LAY-app-equipmentType-list)", function (e) {
        var data = e.data;
        if (e.event == "edit") {
            top.layer.open({
                type: 2,
                title: "编辑设备类型信息维护",
                content: "<%= request.getContextPath() %>/basic/equipType/equipType_edit.jsp",
                area: ["800px", "480px"],
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
                                table.reload("LAY-app-equipmentType-list-reload");
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
                area: ["800px", "480px"],
                resize: false,
                btn: ["关闭"],
                success: function (layero, index) {
                    debugger;
                    var dataJson = {
                        data: data,
                        win: window
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {
                    parent.layer.close(index);
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